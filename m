From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Fri, 23 Aug 2013 23:15:50 +0000
Subject: [lm-sensors] [RFC PATCH 09/14] arm: dts: point to cooling-zones on omap4430 cpu node
Message-Id: <1377299755-5134-10-git-send-email-eduardo.valentin@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, grant.likely@linaro.org, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com
Cc: durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

T01BUDQ0MzAgZGV2aWNlcyBjYW4gcmVhY2ggaGlnaCB0ZW1wZXJhdHVyZXMgYW5kIHRodXMKbmVl
ZHMgdG8gaGF2ZSBjcHVmcmVxLWNvb2xpbmcgb24gc3lzdGVtcyBydW5uaW5nIG9uIGl0LgoKVGhp
cyBwYXRjaCBsaW5rcyB0aGUgY3B1IG5vZGUgdG8gaXRzIHRoZXJtYWwtem9uZQpzbyB0aGF0IGNw
dWZyZXEtY3B1MCBkcml2ZXIgbG9hZHMgdGhlIGNvb2xpbmcgZGV2aWNlLgoKQ2M6ICJCZW5vw650
IENvdXNzb24iIDxiLWNvdXNzb25AdGkuY29tPgpDYzogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9t
aWRlLmNvbT4KQ2M6IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtLmxpbnV4Lm9yZy51az4KQ2M6IGxp
bnV4LW9tYXBAdmdlci5rZXJuZWwub3JnCkNjOiBkZXZpY2V0cmVlLWRpc2N1c3NAbGlzdHMub3ps
YWJzLm9yZwpDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCkNjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEVkdWFyZG8gVmFsZW50aW4g
PGVkdWFyZG8udmFsZW50aW5AdGkuY29tPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL29tYXA0NDN4
LmR0c2kgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL29tYXA0NDN4LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9vbWFw
NDQzeC5kdHNpCmluZGV4IDkxYTNhNWQuLmU0ZWVhNDMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL29tYXA0NDN4LmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvb21hcDQ0M3guZHRz
aQpAQCAtMjIsNiArMjIsNyBAQAogCQkJCTEwMDgwMDAgMTM3NTAwMAogCQkJPjsKIAkJCWNsb2Nr
LWxhdGVuY3kgPSA8MzAwMDAwPjsgLyogRnJvbSBsZWdhY3kgZHJpdmVyICovCisJCQljb29saW5n
LXpvbmVzID0gPCZjcHVfdGhlcm1hbD47CiAJCX07CiAJfTsKIAotLSAKMS44LjIuMS4zNDIuZ2Zh
NzI4NWQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
bS1zZW5zb3JzIG1haWxpbmcgbGlzdApsbS1zZW5zb3JzQGxtLXNlbnNvcnMub3JnCmh0dHA6Ly9s
aXN0cy5sbS1zZW5zb3JzLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xtLXNlbnNvcnM
