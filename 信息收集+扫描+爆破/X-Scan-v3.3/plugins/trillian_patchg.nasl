#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(12076);
 script_version("$Revision: 1.9 $");

 script_cve_id("CVE-2004-2304");
 script_xref(name:"OSVDB", value:"4056");

 script_name(english:"Trillian DirectIM Packet Remote Overflow");
 script_summary(english:"Determines the version of Trillian.exe");
 
 script_set_attribute(
  attribute:"synopsis",
  value:string(
   "The remote Windows host contains an instant messaging client that is\n",
   "vulnerable to a buffer overflow attack."
  )
 );
 script_set_attribute(
  attribute:"description", 
  value:string(
   "An integer buffer overflow exists in the AOL Instant Messenger (AIM)\n",
   "component of the version of Trillian instant messaging client\n",
   "installed on the remote host.  By sending a DirectIM packet with a\n",
   "size above 8k bytes, a remote attacker can potentially execute code on\n",
   "the affected host subject to the user's privileges."
  )
 );
 script_set_attribute(
  attribute:"see_also", 
  value:"http://www.nessus.org/u?03d60de8"
 );
 script_set_attribute(
  attribute:"see_also", 
  value:"http://archives.neohapsis.com/archives/fulldisclosure/2004-02/1212.html"
 );
 script_set_attribute(
  attribute:"solution", 
  value:"Upgrade to Trillian 0.74 patch G or higher."
 );
 script_set_attribute(
  attribute:"cvss_vector", 
  value:"CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C"
 );
 script_end_attributes();
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");

 script_family(english:"Windows");
 
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");
 script_require_ports(139, 445);
 exit(0);
}


include("smb_func.inc");
include("smb_hotfixes.inc");

if ( ! get_kb_item("SMB/Registry/Enumerated") ) exit(1);

# reg value = "C:\Program Files\Trillian\trillian.exe -command="%1"   "


name 	=  kb_smb_name();
login	=  kb_smb_login();
pass  	=  kb_smb_password();
domain 	=  kb_smb_domain();
port    =  kb_smb_transport();


if(!get_port_state(port))exit(1);
soc = open_sock_tcp(port);
if(!soc)exit(1);

session_init(socket:soc, hostname:name);
r = NetUseAdd(login:login, password:pass, domain:domain, share:"IPC$");
if ( r != 1 ) exit(1);

hklm = RegConnectRegistry(hkey:HKEY_LOCAL_MACHINE);
if ( isnull(hklm) )
{
 NetUseDel();
 exit(1);
}

key_h = RegOpenKey(handle:hklm, key:"SOFTWARE\Classes\AIM\shell\open\command", mode:MAXIMUM_ALLOWED);
if ( isnull(key_h) )
{
 RegCloseKey(handle:hklm);
 NetUseDel();
 exit(0);
}

value = RegQueryValue(handle:key_h, item:"Default");
RegCloseKey(handle:key_h);
RegCloseKey(handle:hklm);
NetUseDel(close:FALSE);

if ( isnull(value) ) {
	NetUseDel();
	exit(1);
}

rootfile = hotfix_get_programfilesdir();
share = ereg_replace(pattern:"([A-Z]):.*", replace:"\1$", string:rootfile);
findash = strstr(rootfile, "-command");
file = rootfile - findash;

r = NetUseAdd(login:login, password:pass,domain:domain, share:share);
if ( r != 1 )
{
 NetUseDel();
 exit(1);
}

handle = CreateFile (file:file, desired_access:GENERIC_READ, file_attributes:FILE_ATTRIBUTE_NORMAL, share_mode:FILE_SHARE_READ, create_disposition:OPEN_EXISTING);


if ( ! isnull(handle) )
{
 # C:\Program Files\Trillian>find /N /i "v0.7" trillian.exe
 #
 #---------- TRILLIAN.EXE
 #[31288]v0.74 (w/ Patch G) - February 2004

 off = 31200;
 data = ReadFile(handle:handle, length:512, offset:off);
 CloseFile(handle:handle);
 data = str_replace(find:raw_string(0), replace:"", string:data);
 version = strstr(data, "v0.7");
 if ( version )
 {
  hopup = strstr(data, " - ");
  v = version - hopup;
  set_kb_item(name:"Host/Windows/Trillian/Version", value:v);
  if (egrep(string:v, pattern:"v0\.7[1-4].*")) {
    if (! egrep(string:v, pattern:"\(w/ Patch [G-Z]\)")) security_hole(port);
  }
 }
}

NetUseDel();
