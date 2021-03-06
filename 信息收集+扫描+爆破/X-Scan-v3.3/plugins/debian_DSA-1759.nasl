# This script was automatically generated from the dsa-1759
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(36052);
 script_version("$Revision: 1.3 $");
 script_xref(name: "DSA", value: "1759");
 script_cve_id("CVE-2009-0790");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1759 security update');
 script_set_attribute(attribute: 'description', value:
'Gerd v. Egidy discovered that the Pluto IKE daemon in strongswan, an
IPSec implementation for linux, is prone to a denial of service attack
via a malicious packet.
For the oldstable distribution (etch), this problem has been fixed in
version 2.8.0+dfsg-1+etch1.
For the stable distribution (lenny), this problem has been fixed in
version 4.2.4-5+lenny1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2009/dsa-1759');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your strongswan packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1759] DSA-1759-1 strongswan");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1759-1 strongswan");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'strongswan', release: '4.0', reference: '2.8.0+dfsg-1+etch1');
deb_check(prefix: 'strongswan', release: '5.0', reference: '4.2.4-5+lenny1');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
