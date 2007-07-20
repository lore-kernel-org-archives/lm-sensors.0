From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 20 Jul 2007 21:16:47 +0000
Subject: [lm-sensors] [PATCH RESEND] hwmon/dme1737: fix temp fault attribute
Message-Id: <191fb4ca0707201416v7077bd89i2691c7faf1ce9bcd@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_119293_31051257.1184966207042"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

------=_Part_119293_31051257.1184966207042
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fix temp?_fault attribute. The temp was incorrectly compared against
0x0800 rather than 0x8000. Only the upper 8 bits are compared as the
datasheet doesn't specify what happens to the lower bits in case of a
diode fault.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>
---

------=_Part_119293_31051257.1184966207042
Content-Type: text/x-patch; name=hwmon-dme1737-fix-temp-fault.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4d68ke3
Content-Disposition: attachment; filename="hwmon-dme1737-fix-temp-fault.patch"

Rml4IHRlbXA/X2ZhdWx0IGF0dHJpYnV0ZS4gVGhlIHRlbXAgd2FzIGluY29ycmVjdGx5IGNvbXBh
cmVkIGFnYWluc3QgMHgwODAwIHJhdGhlciB0aGFuIDB4ODAwMC4gT25seSB0aGUgdXBwZXIgOCBi
aXRzIGFyZSBjb21wYXJlZCBhcyB0aGUgZGF0YXNoZWV0IGRvZXNuJ3Qgc3BlY2lmeSB3aGF0IGhh
cHBlbnMgdG8gdGhlIGxvd2VyIGJpdHMgaW4gY2FzZSBvZiBhIGRpb2RlIGZhdWx0LgoKU2lnbmVk
LW9mZi1ieTogSnVlcmcgSGFlZmxpZ2VyIDxqdWVyZ2ggYXQgZ21haWwuY29tPgotLS0KSW5kZXg6
IGxpbnV4LTIuNi9kcml2ZXJzL2h3bW9uL2RtZTE3MzcuYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0y
LjYub3JpZy9kcml2ZXJzL2h3bW9uL2RtZTE3MzcuYwkyMDA3LTA3LTE2IDE3OjMxOjA0LjAwMDAw
MDAwMCAtMDcwMAorKysgbGludXgtMi42L2RyaXZlcnMvaHdtb24vZG1lMTczNy5jCTIwMDctMDct
MjAgMTQ6MTA6MzIuMDAwMDAwMDAwIC0wNzAwCkBAIC03NTAsNyArNzUwLDcgQEAKIAkJcmVzID0g
KGRhdGEtPmFsYXJtcyA+PiBETUUxNzM3X0JJVF9BTEFSTV9URU1QW2l4XSkgJiAweDAxOwogCQli
cmVhazsKIAljYXNlIFNZU19URU1QX0ZBVUxUOgotCQlyZXMgPSAoZGF0YS0+dGVtcFtpeF0gPT0g
MHgwODAwKTsKKwkJcmVzID0gKCgodTE2KWRhdGEtPnRlbXBbaXhdICYgMHhmZjAwKSA9PSAweDgw
MDApOwogCQlicmVhazsKIAlkZWZhdWx0OgogCQlyZXMgPSAwOwo=
------=_Part_119293_31051257.1184966207042
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_119293_31051257.1184966207042--
