From: TuskenTower <tuskentower@gmail.com>
Date: Fri, 13 Apr 2007 04:09:54 +0000
Subject: [lm-sensors] Add the temp offset diode register to the k8temp
Message-Id: <741eae780704122109t404ba5dbn5e95d15861de83ae@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_104_5874728.1176437394370"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

------=_Part_104_5874728.1176437394370
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[CC'ing the lm-sensors list in case the Documentation/hwmon/k8temp
documentation is out of date]

Hi Rudolf,
I have attached my patch (sorry gmail always screws them up for me) to
have the k8temp utilize the temperature diode offset when calculating
the reported temperature.

Short Story:
I started looking at this because the k8temp driver reported
temperatures that were very different from those reported by the BIOS.
 Since I couldn't make heads or tails of why the numbers were wrong, I
read the spec sheet and the driver source.  I came up with the changes
based on spec sheet (see my bug report).  The temperature reported by
k8temp is not the same as the BIOS, but both CPU temps are uniformly 6
degrees C lower than BIOS reported temps.  The diode offset corrects
CPU1 by 4 and CPU 2 by 7.

I was wondering what you thought of my changes.

For the long story , please see http://www.lm-sensors.org/ticket/2200 .

thanks,
Amul

------=_Part_104_5874728.1176437394370
Content-Type: application/octet-stream; name=k8temp_diodeoffset.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0g38u76
Content-Disposition: attachment; filename="k8temp_diodeoffset.patch"

ZGlmZiAtdXByTiBrZXJuZWwub3JpZy9kcml2ZXJzL2h3bW9uL2s4dGVtcC5jIGtlcm5lbC9kcml2
ZXJzL2h3bW9uL2s4dGVtcC5jCi0tLSBrZXJuZWwub3JpZy9kcml2ZXJzL2h3bW9uL2s4dGVtcC5j
CTIwMDctMDQtMTIgMjM6MTU6MDIuMDAwMDAwMDAwIC0wNDAwCisrKyBrZXJuZWwvZHJpdmVycy9o
d21vbi9rOHRlbXAuYwkyMDA3LTA0LTEyIDIzOjEzOjUzLjAwMDAwMDAwMCAtMDQwMApAQCAtMzMs
NiArMzMsNyBAQAogI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+CiAKICNkZWZpbmUgVEVNUF9GUk9N
X1JFRyh2YWwpCSgoKCgodmFsKSA+PiAxNikgJiAweGZmKSAtIDQ5KSAqIDEwMDApCisjZGVmaW5l
IE9GRlNFVF9GUk9NX1JFRyh2YWwpCSgodmFsID4+IDgpICYgMHgzZik/KDExIC0gKCh2YWwgPj4g
OCkgJiAweDNmKSk6MAogI2RlZmluZSBSRUdfVEVNUAkweGU0CiAjZGVmaW5lIFNFTF9QTEFDRQkw
eDQwCiAjZGVmaW5lIFNFTF9DT1JFCTB4MDQKQEAgLTExNyw3ICsxMTgsOCBAQCBzdGF0aWMgc3Np
emVfdCBzaG93X3RlbXAoc3RydWN0IGRldmljZSAqCiAJc3RydWN0IGs4dGVtcF9kYXRhICpkYXRh
ID0gazh0ZW1wX3VwZGF0ZV9kZXZpY2UoZGV2KTsKIAogCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVk
XG4iLAotCQkgICAgICAgVEVNUF9GUk9NX1JFRyhkYXRhLT50ZW1wW2NvcmVdW3BsYWNlXSkpOwor
CQkJKChpbnQpIFRFTVBfRlJPTV9SRUcoZGF0YS0+dGVtcFtjb3JlXVtwbGFjZV0pKSArCisJCQko
KChpbnQpIE9GRlNFVF9GUk9NX1JFRyhkYXRhLT50ZW1wW2NvcmVdW3BsYWNlXSkpKjEwMDApKTsK
IH0KIAogLyogY29yZSwgcGxhY2UgKi8K
------=_Part_104_5874728.1176437394370
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_104_5874728.1176437394370--
