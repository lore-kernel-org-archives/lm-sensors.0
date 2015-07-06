From: Lukasz Majewski <l.majewski@samsung.com>
Date: Mon, 06 Jul 2015 10:26:40 +0000
Subject: Re: [lm-sensors] [PATCH] thermal: consistently use int for temperatures
Message-Id: <20150706122640.2a61ca05@amdc2363>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sensors@lm-sensors.org

SGkgU2FzY2hhLAoKPiBUaGUgdGhlcm1hbCBjb2RlIHVzZXMgaW50LCBsb25nIGFuZCB1bnNpZ25l
ZCBsb25nIGZvciB0ZW1wZXJhdHVyZXMKPiBpbiBkaWZmZXJlbnQgcGxhY2VzLgo+IAo+IFVzaW5n
IGFuIHVuc2lnbmVkIHR5cGUgbGltaXRzIHRoZSB0aGVybWFsIGZyYW1ld29yayB0byBwb3NpdGl2
ZQo+IHRlbXBlcmF0dXJlcyB3aXRob3V0IG5lZWQuIEFsc28gc2V2ZXJhbCBkcml2ZXJzIGN1cnJl
bnRseSB3aWxsIHJlcG9ydAo+IHRlbXBlcmF0dXJlcyBuZWFyIFVJTlRfTUFYIGZvciB0ZW1wZXJh
dHVyZXMgYmVsb3cgMMKwQy4gVGhpcyB3aWxsCj4gcHJvYmFibHkgaW1tZWRpYXRlbHkgc2h1dCB0
aGUgbWFjaGluZSBkb3duIGR1ZSB0byBvdmVydGVtcGVyYXR1cmUgaWYKPiBzdGFydGVkIGJlbG93
IDDCsEMuCj4gCj4gJ2xvbmcnIGlzIDY0Yml0IG9uIHNldmVyYWwgYXJjaGl0ZWN0dXJlcy4gVGhp
cyBpcyBub3QgbmVlZGVkIHNpbmNlCj4gSU5UX01BWCDCsG1DIGlzIGFib3ZlIHRoZSBtZWx0aW5n
IHBvaW50IG9mIGFsbCBrbm93biBtYXRlcmlhbHMuCj4gCj4gQ29uc2lzdGVudGx5IHVzZSBhIHBs
YWluICdpbnQnIGZvciB0ZW1wZXJhdHVyZXMgdGhyb3VnaG91dCB0aGUKPiB0aGVybWFsIGNvZGUg
YW5kIHRoZSBkcml2ZXJzLiBUaGlzIG9ubHkgY2hhbmdlcyB0aGUgcGxhY2VzIGluIHRoZQo+IGRy
aXZlcnMgd2hlcmUgdGhlIHRlbXBlcmF0dXJlIGlzIHBhc3NlZCBhcm91bmQgYXMgcG9pbnRlciwg
d2hlbgo+IGRyaXZlcnMgaW50ZXJuYWxseSB1c2UgYW5vdGhlciB0eXBlIHRoaXMgaXMgbm90IGNo
YW5nZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJv
bml4LmRlPgoKU2FzY2hhLCB0aGFua3MgZm9yIHRoaXMgY2xlYW51cCB3b3JrLiAKClJldmlld2Vk
LWJ5OiBMdWthc3ogTWFqZXdza2kgPGwubWFqZXdza2lAc2Ftc3VuZy5jb20+CgotLSAKQmVzdCBy
ZWdhcmRzLAoKTHVrYXN6IE1hamV3c2tpCgpTYW1zdW5nIFImRCBJbnN0aXR1dGUgUG9sYW5kIChT
UlBPTCkgfCBMaW51eCBQbGF0Zm9ybSBHcm91cAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbG0tc2Vuc29ycyBtYWlsaW5nIGxpc3QKbG0tc2Vuc29yc0Bs
bS1zZW5zb3JzLm9yZwpodHRwOi8vbGlzdHMubG0tc2Vuc29ycy5vcmcvbWFpbG1hbi9saXN0aW5m
by9sbS1zZW5zb3Jz
