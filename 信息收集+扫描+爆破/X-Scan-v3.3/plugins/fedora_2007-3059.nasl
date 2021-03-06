
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2007-3059
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(28159);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 7 2007-3059: koffice");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2007-3059 (koffice)");
 script_set_attribute(attribute: "description", value: "KOffice - Integrated Office Suite
KOffice is a free, integrated office suite for KDE, the K Desktop Environment.

-
Update Information:

This update includes fixes to pdf import filters that can cause crashes possibl
y execute arbitrary code.  See
[9]http://www.kde.org/info/security/advisory-20071107-1.txt
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2007-3387", "CVE-2007-4352", "CVE-2007-5392", "CVE-2007-5393");
script_summary(english: "Check for the version of the koffice package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"koffice-1.6.3-13.fc7", release:"FC7") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
