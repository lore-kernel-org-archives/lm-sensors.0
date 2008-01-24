From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 24 Jan 2008 17:11:25 +0000
Subject: [lm-sensors] [PATCH] hwmon/dme1737: fix divide-by-0
Message-Id: <191fb4ca0801240911m79bdc87p72b734df3427ee4b@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_16488_23871854.1201194685192"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

------=_Part_16488_23871854.1201194685192
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch fixes a possible divide-by-0.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>

------=_Part_16488_23871854.1201194685192
Content-Type: text/x-patch; name=dme1737-fix-divide-by-zero.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbtk9c830
Content-Disposition: attachment; filename=dme1737-fix-divide-by-zero.patch

SW5kZXg6IGxpbnV4LTIuNi4yNC1yYzgvZHJpdmVycy9od21vbi9kbWUxNzM3LmMKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gbGludXgtMi42LjI0LXJjOC5vcmlnL2RyaXZlcnMvaHdtb24vZG1lMTczNy5jCTIwMDgt
MDEtMjQgMDk6MDQ6MjQuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjYuMjQtcmM4L2RyaXZl
cnMvaHdtb24vZG1lMTczNy5jCTIwMDgtMDEtMjQgMDk6MDU6MDUuMDAwMDAwMDAwIC0wODAwCkBA
IC0yODUsOCArMjg1LDggQEAKIAogc3RhdGljIGlubGluZSBpbnQgRkFOX1RPX1JFRyhpbnQgdmFs
LCBpbnQgdHBjKQogewotCXJldHVybiBTRU5TT1JTX0xJTUlUKCh0cGMgPT0gMCkgPyA5MDAwMCAq
IDYwIC8gdmFsIDogdmFsIC8gdHBjLAotCQkJICAgICAwLCAweGZmZmYpOworCXJldHVybiAodmFs
IDw9IDApID8gMHhmZmZmIDogU0VOU09SU19MSU1JVCgodHBjID09IDApID8KKwkJOTAwMDAgKiA2
MCAvIHZhbCA6IHZhbCAvIHRwYywgMCwgMHhmZmZlKTsKIH0KIAogLyogRmFuIFRQQyAodGFjaCBw
dWxzZSBjb3VudCkK
------=_Part_16488_23871854.1201194685192
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_16488_23871854.1201194685192--
