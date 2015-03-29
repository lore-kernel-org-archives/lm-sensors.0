From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sun, 29 Mar 2015 12:57:37 +0000
Subject: [lm-sensors] [PATCH v2 0/2] i8k.c => dell-smm-hwmon.c
Message-Id: <1427633859-18596-1-git-send-email-pali.rohar@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com>
In-Reply-To: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.de>
Cc: Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

VGhpcyBwYXRjaCBzZXJpZXMgbW92ZXMgZHJpdmVycy9jaGFyL2k4ay5jIHRvIGRyaXZlcnMvaHdt
b24vZGVsbC1zbW0taHdtb24uYwphbmQgYWxsb3dzIHRvIGNvbXBpbGUgaHdtb24gZHJpdmVyIHdp
dGhvdXQgL3Byb2MvaThrIGZpbGUuCgpQYWxpIFJvaMOhciAoMik6CiAgaHdtb246IFJlbmFtZSBp
OGsgZHJpdmVyIHRvIGRlbGwtc21tLWh3bW9uIGFuZCBtb3ZlIGl0IHRvIGh3bW9uIHRyZWUKICBo
d21vbjogQWxsb3cgdG8gY29tcGlsZSBkZWxsLXNtbS1od21vbiBkcml2ZXIgd2l0aG91dCAvcHJv
Yy9pOGsKCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgfCAgICA0ICstCiBhcmNoL3g4
Ni9LY29uZmlnICAgICAgICAgICAgICAgfCAgIDI1ICstCiBkcml2ZXJzL2NoYXIvTWFrZWZpbGUg
ICAgICAgICAgfCAgICAxIC0KIGRyaXZlcnMvY2hhci9pOGsuYyAgICAgICAgICAgICB8IDEwMDUg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2h3bW9uL0tj
b25maWcgICAgICAgICAgfCAgIDExICsKIGRyaXZlcnMvaHdtb24vTWFrZWZpbGUgICAgICAgICB8
ICAgIDEgKwogZHJpdmVycy9od21vbi9kZWxsLXNtbS1od21vbi5jIHwgMTAyNSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiA3IGZpbGVzIGNoYW5nZWQsIDEwNDkgaW5z
ZXJ0aW9ucygrKSwgMTAyMyBkZWxldGlvbnMoLSkKIGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2NoYXIvaThrLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2h3bW9uL2RlbGwtc21tLWh3
bW9uLmMKCi0tIAoxLjcuOS41CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbG0tc2Vuc29ycyBtYWlsaW5nIGxpc3QKbG0tc2Vuc29yc0BsbS1zZW5zb3Jz
Lm9yZwpodHRwOi8vbGlzdHMubG0tc2Vuc29ycy5vcmcvbWFpbG1hbi9saXN0aW5mby9sbS1zZW5z
b3Jz
