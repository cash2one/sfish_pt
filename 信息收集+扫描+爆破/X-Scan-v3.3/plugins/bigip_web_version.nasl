# bigip_web_version.nasl
#
# History:
#
# 1.00, 12/2/07
# - Initial release

# Changes by Tenable:
# - Revised plugin title, family change (9/1/09)


include("compat.inc");

if (description)
    {
    script_id(30216);
    script_version("$Revision: 1.3 $");

    script_name(english:"F5 BIG-IP Web Management Interface Version");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server is a web management interface." );
 script_set_attribute(attribute:"description", value:
"An F5 BIG-IP web management interface is running on this port, and
Nessus has determined its software version." );
 script_set_attribute(attribute:"see_also", value:"http://www.f5.com/products/big-ip/" );
 script_set_attribute(attribute:"risk_factor", value:"None" );
 script_set_attribute(attribute:"solution", value:"n/a" );

    script_summary(english:"Tests for F5 BIG-IP web interface version");
    script_family(english:"CGI abuses");
script_end_attributes();

    script_category(ACT_GATHER_INFO);
    script_copyright(english:"This script is Copyright (c) 2007-2009 nnposter");
    script_dependencies("bigip_web_detect.nasl","http_login.nasl");
    script_require_keys("www/bigip");
    script_require_ports("Services/www",443);
    exit(0);
    }


include("http_func.inc");
include("http_keepalive.inc");
include("misc_func.inc");


if (!get_kb_item("www/bigip")) exit(0);

port=get_http_port(default:443);
if (!get_tcp_port_state(port) || !get_kb_item("www/"+port+"/bigip")) exit(0);

url="/tmui/Control/jspmap/tmui/system/device/properties_general.jsp";
resp=http_keepalive_send_recv(port:port,
                              data:http_get(item:url,port:port),
                              embedded:TRUE);
if (!resp) exit(0);

resp=egrep(pattern:'title=["\']BIG-IP',string:resp,icase:TRUE);
match=eregmatch(pattern:'title=["\'](BIG-IP [^"\']+)',string:resp,icase:TRUE);
version=match[1];
if (!version) exit(0);

replace_or_set_kb_item(name:"www/"+port+"/bigip/version",value:version);
security_note(port:port,
              data:'The remote host is running the F5 BIG-IP web management version\n' + version, '\n');
