From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Fri, 23 Aug 2013 23:15:48 +0000
Subject: [lm-sensors] [RFC PATCH 07/14] arm: dts: add omap4430 thermal data
Message-Id: <1377299755-5134-8-git-send-email-eduardo.valentin@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, grant.likely@linaro.org, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com
Cc: durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

VGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBkdHNpIGVudHJ5IG9uIG9tYXA0NDMwIHRvIGNvbnRhaW4K
dGhlIHRoZXJtYWwgZGF0YS4gVGhpcyBkYXRhIHdpbGwgZW5hYmxlIHRoZSBwYXNzaXZlCmNvb2xp
bmcgd2l0aCBDUFVmcmVxIGNvb2xpbmcgZGV2aWNlIGF0IDEwMEMgYW5kIHRoZQpzeXN0ZW0gd2ls
bCBkbyBhIHRoZXJtYWwgc2h1dGRvd24gYXQgMTI1Qy4KCkNjOiAiQmVub8OudCBDb3Vzc29uIiA8
Yi1jb3Vzc29uQHRpLmNvbT4KQ2M6IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+CkNj
OiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybS5saW51eC5vcmcudWs+CkNjOiBsaW51eC1vbWFwQHZn
ZXIua2VybmVsLm9yZwpDYzogZGV2aWNldHJlZS1kaXNjdXNzQGxpc3RzLm96bGFicy5vcmcKQ2M6
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpDYzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBFZHVhcmRvIFZhbGVudGluIDxlZHVhcmRvLnZh
bGVudGluQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9vbWFwNDQzeC5kdHNpIHwgNSAr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL29tYXA0NDN4LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9vbWFwNDQzeC5k
dHNpCmluZGV4IGJjZjQ1NWUuLjkxYTNhNWQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L29tYXA0NDN4LmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvb21hcDQ0M3guZHRzaQpAQCAt
MjUsOSArMjUsMTQgQEAKIAkJfTsKIAl9OwogCisJdGhlcm1hbF96b25lc3sKKwkJI2luY2x1ZGUg
Im9tYXA0LWNwdS10aGVybWFsLmR0c2kiCisJfTsKKwogCWJhbmRnYXAgewogCQlyZWcgPSA8MHg0
YTAwMjI2MCAweDQKIAkJICAgICAgIDB4NGEwMDIzMkMgMHg0PjsKIAkJY29tcGF0aWJsZSA9ICJ0
aSxvbWFwNDQzMC1iYW5kZ2FwIjsKKwkJbW9uaXRvcmVkLXpvbmVzID0gPCZjcHVfdGhlcm1hbCAw
PjsKIAl9OwogfTsKLS0gCjEuOC4yLjEuMzQyLmdmYTcyODVkCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbG0tc2Vuc29ycyBtYWlsaW5nIGxpc3QKbG0t
c2Vuc29yc0BsbS1zZW5zb3JzLm9yZwpodHRwOi8vbGlzdHMubG0tc2Vuc29ycy5vcmcvbWFpbG1h
bi9saXN0aW5mby9sbS1zZW5zb3Jz
