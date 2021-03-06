#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(12046);
 script_xref(name:"IAVA", value:"2004-t-0003");
 script_cve_id("CVE-2004-0009");
 script_bugtraq_id(9590);
 script_xref(name:"OSVDB", value:"3877");
 script_xref(name:"Secunia", value:"10811");
 script_version("$Revision: 1.11 $");
 
 script_name(english:"Apache-SSL SSLVerifyClient SSLFakeBasicAuth Client Certificate Forgery");
 script_summary(english:"Checks for version of Apache-SSL");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server is affected by a client certificate forging
vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a version of ApacheSSL which is older than
1.3.29/1.53. Such version are reportedly vulnerable to a flaw which
may allow an attacker to make the remote server forge a client
certificate." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/fulldisclosure/2004-02/0257.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.apache-ssl.org/advisory-20040206.txt" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to ApacheSSL 1.3.29/1.53 or newer" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 script_family(english:"Web Servers");
 script_dependencie("find_service1.nasl", "http_version.nasl");
 script_require_keys("www/apache");
 script_require_ports("Services/www", 80);
 exit(0);
}

#
# The script code starts here
#
include ("global_settings.inc");
include ("misc_func.inc");
include ("http.inc");
include ("backport.inc");

port = get_http_port(default:80);

 banner = get_backport_banner(banner:get_http_banner(port: port));
 
 serv = strstr(banner, "Server");
 if(ereg(pattern:".*Apache(-AdvancedExtranetServer)?/.* Ben-SSL/1\.([0-9][^0-9]|[0-4][0-9]|5[0-2])[^0-9]", string:serv))
 {
   security_hole(port);
 }
