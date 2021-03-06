#
#  This script was written by David Maciejak <david dot maciejak at kyxar dot fr>
#  This script is released under the GNU GPL v2
#

# Changes by Tenable:
# - Revised plugin title, family change (9/3/09)


include("compat.inc");

if(description)
{
 script_id(17200);
 script_version("$Revision: 1.9 $");
 
 script_name(english:"Trend Micro IWSS Console Management Detection");

 script_set_attribute(attribute:"synopsis", value:
"The remote host is running a web security suite." );
 script_set_attribute(attribute:"description", value:
"The remote host appears to run the Trend Micro Interscan Web Security
Suite.

Make sure that only authorized hosts can connect to this service, as 
the information of its existence may help an attacker to make more 
sophisticated attacks against the remote network." );
 script_set_attribute(attribute:"solution", value:
"Filter incoming traffic to this port" );
 script_set_attribute(attribute:"risk_factor", value:"None" );

script_end_attributes();

 script_summary(english:"Checks for Trend Micro IWSS web console management");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2005-2009 David Maciejak");
 script_family(english:"CGI abuses");
 script_dependencie("httpver.nasl");

 script_require_ports(1812);
 exit(0);
}

#
# The script code starts here
#

include("http_func.inc");
include("http_keepalive.inc");

port = 1812;
if(get_port_state(port))
{
 req = http_get(item:"/logon.jsp", port:port);
 rep = http_keepalive_send_recv(port:port, data:req);
 if( rep == NULL ) exit(0);
 if("Trend Micro InterScan Web Security Suite" >< rep)
 {
   set_kb_item(name:string("Services/www/",port,"/iwss"), value:TRUE);
   security_note(port);
   set_kb_item(name:"Services/www/" + port + "/embedded", value:TRUE);
 }
}
