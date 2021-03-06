
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(14173);
 script_version ("$Revision: 1.6 $");
 script_name(english: "MDKSA-2004:075: mod_ssl");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2004:075 (mod_ssl).");
 script_set_attribute(attribute: "description", value: "Ralf S. Engelschall found a remaining risky call to ssl_log while
reviewing code for another issue reported by Virulent. The updated
packages are patched to correct the problem.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2004:075");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2004-0700");
script_summary(english: "Check for the version of the mod_ssl package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"mod_ssl-2.8.16-1.2.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mod_ssl-2.8.12-8.2.91mdk", release:"MDK9.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mod_ssl-2.8.15-1.2.92mdk", release:"MDK9.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"mod_ssl-", release:"MDK10.0")
 || rpm_exists(rpm:"mod_ssl-", release:"MDK9.1")
 || rpm_exists(rpm:"mod_ssl-", release:"MDK9.2") )
{
 set_kb_item(name:"CVE-2004-0700", value:TRUE);
}
exit(0, "Host is not affected");
