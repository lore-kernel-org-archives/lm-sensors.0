From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 28 Jan 2008 00:39:46 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/dme1737: fix divide-by-0
Message-Id: <191fb4ca0801271639v76fb38d0tb26eff3302f7bf41@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_7087_2745696.1201480786506"
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0801240911m79bdc87p72b734df3427ee4b@mail.gmail.com>
In-Reply-To: <191fb4ca0801240911m79bdc87p72b734df3427ee4b@mail.gmail.com>
To: lm-sensors@vger.kernel.org

------=_Part_7087_2745696.1201480786506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch fixes a possible divide-by-0 and a minor bug in the
FAN_FROM_REG macro (in TPC mode).

Signed-off-by: Juerg Haefliger <juergh at gmail.com>

------=_Part_7087_2745696.1201480786506
Content-Type: text/x-patch; name=dme1737-fix-divide-by-zero.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbyajph50
Content-Disposition: attachment; filename=dme1737-fix-divide-by-zero.patch

SW5kZXg6IGxpbnV4L2RyaXZlcnMvaHdtb24vZG1lMTczNy5jCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4
Lm9yaWcvZHJpdmVycy9od21vbi9kbWUxNzM3LmMJMjAwOC0wMS0yNCAwOTowNDoyNC4wMDAwMDAw
MDAgLTA4MDAKKysrIGxpbnV4L2RyaXZlcnMvaHdtb24vZG1lMTczNy5jCTIwMDgtMDEtMjcgMTY6
MzM6NDcuMDAwMDAwMDAwIC0wODAwCkBAIC0yNzksMTQgKzI3OSwyMSBAQAogLyogRmFuIGlucHV0
IFJQTSAqLwogc3RhdGljIGlubGluZSBpbnQgRkFOX0ZST01fUkVHKGludCByZWcsIGludCB0cGMp
CiB7Ci0JcmV0dXJuIChyZWcgPT0gMCB8fCByZWcgPT0gMHhmZmZmKSA/IDAgOgotCQkodHBjID09
IDApID8gOTAwMDAgKiA2MCAvIHJlZyA6IHRwYyAqIHJlZzsKKwlpZiAodHBjKSB7CisJCXJldHVy
biB0cGMgKiByZWc7CisJfSBlbHNlIHsKKwkJcmV0dXJuIChyZWcgPT0gMCB8fCByZWcgPT0gMHhm
ZmZmKSA/IDAgOiA5MDAwMCAqIDYwIC8gcmVnOworCX0KIH0KIAogc3RhdGljIGlubGluZSBpbnQg
RkFOX1RPX1JFRyhpbnQgdmFsLCBpbnQgdHBjKQogewotCXJldHVybiBTRU5TT1JTX0xJTUlUKCh0
cGMgPT0gMCkgPyA5MDAwMCAqIDYwIC8gdmFsIDogdmFsIC8gdHBjLAotCQkJICAgICAwLCAweGZm
ZmYpOworCWlmICh0cGMpIHsKKwkJcmV0dXJuIFNFTlNPUlNfTElNSVQodmFsIC8gdHBjLCAwLCAw
eGZmZmYpOworCX0gZWxzZSB7CisJCXJldHVybiAodmFsIDw9IDApID8gMHhmZmZmIDoKKwkJCVNF
TlNPUlNfTElNSVQoOTAwMDAgKiA2MCAvIHZhbCwgMCwgMHhmZmZlKTsKKwl9CiB9CiAKIC8qIEZh
biBUUEMgKHRhY2ggcHVsc2UgY291bnQpCg==
------=_Part_7087_2745696.1201480786506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_7087_2745696.1201480786506--
