From: "Andrew Paprocki" <andrew@ishiboo.com>
Date: Wed, 17 Sep 2008 03:55:11 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Fix fan tachometer reading in
Message-Id: <76366b180809162055x2eaa52d3l9fcce3272423bde2@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_1455_20690620.1221623711474"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

------=_Part_1455_20690620.1221623711474
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The IT8712F v0.9.1 datasheet applies to revisions >= 0x8 (J).
The driver was incorrectly attempting to enable 16-bit fan
readings on rev 0x7 (I) which led to incorrect RPM values.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
Tested-by: John Gumb <john.gumb@tandberg.com>
---
 drivers/hwmon/it87.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

------=_Part_1455_20690620.1221623711474
Content-Type: application/octet-stream;
	name=0001-hwmon-it87-Fix-fan-tachometer-reading-in-IT8712F.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fl7f6wye0
Content-Disposition: attachment;
	filename=0001-hwmon-it87-Fix-fan-tachometer-reading-in-IT8712F.patch

RnJvbSBiMDYwNGY0MjQzNjUxNDM2MmY2YjU4ZGY1N2NlZmQwMDRlOTYzOTAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXcgUGFwcm9ja2kgPGFuZHJld0Bpc2hpYm9vLmNvbT4K
RGF0ZTogVHVlLCAxNiBTZXAgMjAwOCAyMzo0NzoxOSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGh3
bW9uOiAoaXQ4NykgRml4IGZhbiB0YWNob21ldGVyIHJlYWRpbmcgaW4gSVQ4NzEyRiByZXYgMHg3
IChJKQoKVGhlIElUODcxMkYgdjAuOS4xIGRhdGFzaGVldCBhcHBsaWVzIHRvIHJldmlzaW9ucyA+
PSAweDggKEopLgpUaGUgZHJpdmVyIHdhcyBpbmNvcnJlY3RseSBhdHRlbXB0aW5nIHRvIGVuYWJs
ZSAxNi1iaXQgZmFuCnJlYWRpbmdzIG9uIHJldiAweDcgKEkpIHdoaWNoIGxlZCB0byBpbmNvcnJl
Y3QgUlBNIHZhbHVlcy4KClNpZ25lZC1vZmYtYnk6IEFuZHJldyBQYXByb2NraSA8YW5kcmV3QGlz
aGlib28uY29tPgpUZXN0ZWQtYnk6IEpvaG4gR3VtYiA8am9obi5ndW1iQHRhbmRiZXJnLmNvbT4K
LS0tCiBkcml2ZXJzL2h3bW9uL2l0ODcuYyB8ICAgIDQgKystLQogMSBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21v
bi9pdDg3LmMgYi9kcml2ZXJzL2h3bW9uL2l0ODcuYwppbmRleCAzMGNkYjA5Li5mMTEzMzA4IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2h3bW9uL2l0ODcuYworKysgYi9kcml2ZXJzL2h3bW9uL2l0ODcu
YwpAQCAtMjczLDEwICsyNzMsMTAgQEAgc3RydWN0IGl0ODdfZGF0YSB7CiBzdGF0aWMgaW5saW5l
IGludCBoYXNfMTZiaXRfZmFucyhjb25zdCBzdHJ1Y3QgaXQ4N19kYXRhICpkYXRhKQogewogCS8q
IElUODcwNUYgRGF0YXNoZWV0IDAuNC4xLCAzaCA9PSBWZXJzaW9uIEcuCi0JICAgSVQ4NzEyRiBE
YXRhc2hlZXQgMC45LjEsIHNlY3Rpb24gOC4zLjUgaW5kaWNhdGVzIDdoID09IFZlcnNpb24gSS4K
KwkgICBJVDg3MTJGIERhdGFzaGVldCAwLjkuMSwgc2VjdGlvbiA4LjMuNSBpbmRpY2F0ZXMgOGgg
PT0gVmVyc2lvbiBKLgogCSAgIFRoZXNlIGFyZSB0aGUgZmlyc3QgcmV2aXNpb25zIHdpdGggMTZi
aXQgdGFjaG9tZXRlciBzdXBwb3J0LiAqLwogCXJldHVybiAoZGF0YS0+dHlwZSA9PSBpdDg3ICYm
IGRhdGEtPnJldmlzaW9uID49IDB4MDMpCi0JICAgIHx8IChkYXRhLT50eXBlID09IGl0ODcxMiAm
JiBkYXRhLT5yZXZpc2lvbiA+PSAweDA3KQorCSAgICB8fCAoZGF0YS0+dHlwZSA9PSBpdDg3MTIg
JiYgZGF0YS0+cmV2aXNpb24gPj0gMHgwOCkKIAkgICAgfHwgZGF0YS0+dHlwZSA9PSBpdDg3MTYK
IAkgICAgfHwgZGF0YS0+dHlwZSA9PSBpdDg3MTg7CiB9Ci0tIAoxLjUuNgoK
------=_Part_1455_20690620.1221623711474
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_1455_20690620.1221623711474--
