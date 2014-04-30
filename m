From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 30 Apr 2014 14:29:22 +0000
Subject: Re: [lm-sensors] [PATCH 02/10] mfd: vexpress: Convert custom func API to regmap
Message-Id: <20140430142922.GU29462@lee--X1>
List-Id: <lm-sensors.vger.kernel.org>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
 <1398707877-22596-3-git-send-email-pawel.moll@arm.com>
 <20140430135855.GO29462@lee--X1>
 <1398867224.24255.22.camel@hornet>
In-Reply-To: <1398867224.24255.22.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel Moll <pawel.moll@arm.com>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "arm@kernel.org" <arm@kernel.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Mike Turquette <mturquette@linaro.org>

PiA+IE1GRCBkaWZmc3RhdCBsb29rcyBncmVhdCBhbmQgdGhlIGNoYW5nZXMgbG9vayBzZW5zaWJs
ZToKPiA+ICAgQWNrZWQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gCj4g
VGhhbmtzIQo+IAo+ID4gSSBndWVzcyBzb21lb25lIHdpbGwgbmVlZCB0byBjcmVhdGUgYSBicmFu
Y2ggZm9yIHVzIGFsbCB0byBwdWxsIGZyb20uCj4gPiBJJ20gaGFwcHkgdG8gZG8gaXQgaWYgbmVl
ZHMgYmUuCj4gCj4gSSB3YXMgdGhpbmtpbmcgdGhhdCwgd2l0aCBlbm91Z2ggYWNrcyAoYW5kIEkn
bSBjb3VudGluZyBvbiBvbmUgZnJvbSB5b3UKPiBmb3IgIltQQVRDSCAwNC8xMF0gbWZkOiB2ZXhw
cmVzczogRGVmaW5lIHRoZSBkZXZpY2UgYXMgTUZEIGNlbGxzIiA6LSksCgpUaGF0IHdvbid0IGhh
cHBlbiByaWdodCBhd2F5IC0gaXQncyBhbm90aGVyIDUwMCsgbGluZSBwYXRjaCBhbmQKY29udGFy
eSB0byBwb3B1bGFyIGJlbGlldmUgSSBkbyBoYXZlIG15IG93biB3b3JrIHRvIGNvbnRlbmQgd2l0
aCB0b28uCgo+IG1lcmdpbmcgdGhlIHdob2xlIHNlcmllcyAob3IgYXQgbGVhc3QgcGF0Y2hlcyAx
LTQgYW5kIDctOCkgdGhyb3VnaAo+IGFybS1zb2MgdHJlZSB3b3VsZCBiZSB0aGUgc2ltcGxlc3Qg
b3B0aW9uLiBJIGhhdmUgbm8gcHJvYmxlbSB3aXRoIHRoZQo+IGluZGVwZW5kZW50IGJpdHMgKGNs
aywgY2xvY2tzb3VyY2UsIGh3bW9uIGFuZCB0aGUgbWZkL0hCSSBjaGFuZ2UpIGdvaW5nCj4gdGhy
b3VnaCBhcHByb3ByaWF0ZSBzdWJzeXN0ZW1zLgoKSSBoYXZlIG5vIHByb2JsZW0gd2l0aCB0aGF0
IGFzIGxvbmcgYXMgb25lIG9mIHRoZSBBUk0tU29DIGd1eXMgY2FuCnByb3ZpZGUgYSBicmFuY2gg
d2hlcmUgdGhlIG90aGVyIHN1YnN5c3RlbXMgY2FuIHB1bGwgZnJvbS4gIElmIHRoZXkKaGF2ZSBu
byB0aW1lLCBteSBvZmZlciBzdGlsbCBzdGFuZHMuCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVE1p
Y3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3Vy
Y2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRl
ciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxtLXNlbnNvcnMgbWFpbGluZyBsaXN0CmxtLXNlbnNvcnNAbG0tc2Vuc29ycy5vcmcKaHR0cDov
L2xpc3RzLmxtLXNlbnNvcnMub3JnL21haWxtYW4vbGlzdGluZm8vbG0tc2Vuc29ycw=
