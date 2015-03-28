From: Paul Bolle <pebolle@tiscali.nl>
Date: Sat, 28 Mar 2015 11:04:20 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
Message-Id: <1427540660.2334.14.camel@x220>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com>
	 <1427538255-10860-3-git-send-email-pali.rohar@gmail.com>
In-Reply-To: <1427538255-10860-3-git-send-email-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

T24gU2F0LCAyMDE1LTAzLTI4IGF0IDExOjI0ICswMTAwLCBQYWxpIFJvaMOhciB3cm90ZToKPiAt
LS0gYS9kcml2ZXJzL2h3bW9uL0tjb25maWcKPiArKysgYi9kcml2ZXJzL2h3bW9uL0tjb25maWcK
PiBAQCAtMTcwMyw2ICsxNzAzLDE3IEBAIGNvbmZpZyBTRU5TT1JTX1VMVFJBNDUKPiAgCSAgVGhp
cyBkcml2ZXIgcHJvdmlkZXMgc3VwcG9ydCBmb3IgdGhlIFVsdHJhNDUgd29ya3N0YXRpb24gZW52
aXJvbm1lbnRhbAo+ICAJICBzZW5zb3JzLgo+ICAKPiArY29uZmlnIFNFTlNPUlNfREVMTF9TTU0K
PiArCXRyaXN0YXRlICJEZWxsIGxhcHRvcCBTTU0gQklPUyBod21vbiBkcml2ZXIiCj4gKwlkZXBl
bmRzIE9OIFg4NgoKSG93IGRpZCB0aGlzIHBhc3QgeW91ciB0ZXN0aW5nPwoKPiArCS0tLWhlbHAt
LS0KPiArCSAgVGhpcyBod21vbiBkcml2ZXIgYWRkcyBzdXBwb3J0IGZvciByZXBvcnRpbmcgdGVt
cGVyYXR1cmUgb2YgZGlmZmVyZW50Cj4gKwkgIHNlbnNvcnMgYW5kIGNvbnRyb2xzIHRoZSBmYW5z
IG9uIERlbGwgbGFwdG9wcyB2aWEgU3lzdGVtIE1hbmFnZW1lbnQKPiArCSAgTW9kZSBwcm92aWRl
ZCBieSBEZWxsIEJJT1MuCj4gKwo+ICsJICBXaGVuIG9wdGlvbiBJOEsgaXMgYWxzbyBlbmFibGVk
IHRoaXMgZHJpdmVyIHByb3ZpZGVzIGxlZ2FjeSAvcHJvYy9pOGsKPiArCSAgdXNlcnNwYWNlIGlu
dGVyZmFjZSBmb3IgaThrdXRpbHMgcGFja2FnZS4KPiArIAoKClBhdWwgQm9sbGUKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsbS1zZW5zb3JzIG1haWxp
bmcgbGlzdApsbS1zZW5zb3JzQGxtLXNlbnNvcnMub3JnCmh0dHA6Ly9saXN0cy5sbS1zZW5zb3Jz
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xtLXNlbnNvcnM
