From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 30 Apr 2014 14:13:44 +0000
Subject: Re: [lm-sensors] [PATCH 02/10] mfd: vexpress: Convert custom func API to regmap
Message-Id: <1398867224.24255.22.camel@hornet>
List-Id: <lm-sensors.vger.kernel.org>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
	 <1398707877-22596-3-git-send-email-pawel.moll@arm.com>
	 <20140430135855.GO29462@lee--X1>
In-Reply-To: <20140430135855.GO29462@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "arm@kernel.org" <arm@kernel.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Mike Turquette <mturquette@linaro.org>

T24gV2VkLCAyMDE0LTA0LTMwIGF0IDE0OjU4ICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gTUZE
IGRpZmZzdGF0IGxvb2tzIGdyZWF0IGFuZCB0aGUgY2hhbmdlcyBsb29rIHNlbnNpYmxlOgo+ICAg
QWNrZWQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpUaGFua3MhCgo+IEkg
Z3Vlc3Mgc29tZW9uZSB3aWxsIG5lZWQgdG8gY3JlYXRlIGEgYnJhbmNoIGZvciB1cyBhbGwgdG8g
cHVsbCBmcm9tLgo+IEknbSBoYXBweSB0byBkbyBpdCBpZiBuZWVkcyBiZS4KCkkgd2FzIHRoaW5r
aW5nIHRoYXQsIHdpdGggZW5vdWdoIGFja3MgKGFuZCBJJ20gY291bnRpbmcgb24gb25lIGZyb20g
eW91CmZvciAiW1BBVENIIDA0LzEwXSBtZmQ6IHZleHByZXNzOiBEZWZpbmUgdGhlIGRldmljZSBh
cyBNRkQgY2VsbHMiIDotKSwKbWVyZ2luZyB0aGUgd2hvbGUgc2VyaWVzIChvciBhdCBsZWFzdCBw
YXRjaGVzIDEtNCBhbmQgNy04KSB0aHJvdWdoCmFybS1zb2MgdHJlZSB3b3VsZCBiZSB0aGUgc2lt
cGxlc3Qgb3B0aW9uLiBJIGhhdmUgbm8gcHJvYmxlbSB3aXRoIHRoZQppbmRlcGVuZGVudCBiaXRz
IChjbGssIGNsb2Nrc291cmNlLCBod21vbiBhbmQgdGhlIG1mZC9IQkkgY2hhbmdlKSBnb2luZwp0
aHJvdWdoIGFwcHJvcHJpYXRlIHN1YnN5c3RlbXMuCgpQYXdlxYIKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsbS1zZW5zb3JzIG1haWxpbmcgbGlzdAps
bS1zZW5zb3JzQGxtLXNlbnNvcnMub3JnCmh0dHA6Ly9saXN0cy5sbS1zZW5zb3JzLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xtLXNlbnNvcnM
