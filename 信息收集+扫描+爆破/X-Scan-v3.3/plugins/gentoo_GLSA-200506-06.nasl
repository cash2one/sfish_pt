# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200506-06.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(18448);
 script_version("$Revision: 1.7 $");
 script_xref(name: "GLSA", value: "200506-06");
 script_cve_id("CVE-2005-0064");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200506-06 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200506-06
(libextractor: Multiple overflow vulnerabilities)


    Xpdf is vulnerable to multiple overflows, as described in GLSA
    200501-28. Also, integer overflows were discovered in Real and PNG
    extractors.
  
Impact

    An attacker could design malicious PDF, PNG or Real files which,
    when processed by an application making use of libextractor, would
    result in the execution of arbitrary code with the rights of the user
    running the application.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All libextractor users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=media-libs/libextractor-0.5.0"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0064');
script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200501-28.xml');
script_set_attribute(attribute: 'see_also', value: 'http://gnunet.org/libextractor/');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200506-06.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200506-06] libextractor: Multiple overflow vulnerabilities');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'libextractor: Multiple overflow vulnerabilities');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-libs/libextractor", unaffected: make_list("ge 0.5.0"), vulnerable: make_list("lt 0.5.0")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
