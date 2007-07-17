From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 17 Jul 2007 01:35:36 +0000
Subject: [lm-sensors] [PATCH] hwmon: fix temp fault in dme1737 driver
Message-Id: <191fb4ca0707161835x101f9a7dx51da4c275b0133bb@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_63671_24798546.1184636136122"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

------=_Part_63671_24798546.1184636136122
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fix temp?_fault attribute. The temp was incorrectly compared against
0x0800 rather than 0x8000.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>

------=_Part_63671_24798546.1184636136122
Content-Type: text/x-patch; name=hwmon-dme1737-fix-temp-fault.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f47ppg7l
Content-Disposition: attachment; filename="hwmon-dme1737-fix-temp-fault.patch"

Rml4IHRlbXA/X2ZhdWx0IGF0dHJpYnV0ZS4gVGhlIHRlbXAgd2FzIGluY29ycmVjdGx5IGNvbXBh
cmVkIGFnYWluc3QgMHgwODAwIHJhdGhlciB0aGFuIDB4ODAwMC4KClNpZ25lZC1vZmYtYnk6IEp1
ZXJnIEhhZWZsaWdlciA8anVlcmdoIGF0IGdtYWlsLmNvbT4KLS0tCkluZGV4OiBsaW51eC0yLjYv
ZHJpdmVycy9od21vbi9kbWUxNzM3LmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJp
dmVycy9od21vbi9kbWUxNzM3LmMJMjAwNy0wNy0xNiAxNzozMTowNC4wMDAwMDAwMDAgLTA3MDAK
KysrIGxpbnV4LTIuNi9kcml2ZXJzL2h3bW9uL2RtZTE3MzcuYwkyMDA3LTA3LTE2IDE3OjQ4OjIz
LjAwMDAwMDAwMCAtMDcwMApAQCAtNzUwLDcgKzc1MCw3IEBACiAJCXJlcyA9IChkYXRhLT5hbGFy
bXMgPj4gRE1FMTczN19CSVRfQUxBUk1fVEVNUFtpeF0pICYgMHgwMTsKIAkJYnJlYWs7CiAJY2Fz
ZSBTWVNfVEVNUF9GQVVMVDoKLQkJcmVzID0gKGRhdGEtPnRlbXBbaXhdID09IDB4MDgwMCk7CisJ
CXJlcyA9IChkYXRhLT50ZW1wW2l4XSA9PSAoczE2KTB4ODAwMCk7CiAJCWJyZWFrOwogCWRlZmF1
bHQ6CiAJCXJlcyA9IDA7Cg==
------=_Part_63671_24798546.1184636136122
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_63671_24798546.1184636136122--
