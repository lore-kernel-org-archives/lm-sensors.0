From: Ulf Jordan <jordan@chalmers.se>
Date: Sat, 08 Dec 2007 10:00:19 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Fix typo for NSC
Message-Id: <Pine.LNX.4.63.0712081041290.32213@elfpc10.elmagn.chalmers.se>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="276943995-607444277-1197107654=:32213"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--276943995-607444277-1197107654=:32213
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-ID: <Pine.LNX.4.63.0712081054281.32213@elfpc10.elmagn.chalmers.se>

Hello!

In the Super IO detection section of sensors-detect, devid = 0xd0 is 
identifed as PC87371 and 0xdf as PC97371. According to National's 
datasheets these SIDs correspond to PC87317 and PC97317, respectively. 
PC87371 and PC97371 do not seem to exist.

Some further discussion is available on the LinuxBIOS mailing list in 
the thread starting at 
http://www.linuxbios.org/pipermail/linuxbios/2007-December/027954.html

Attached is a patch that fixes the typo.


/ulf
--276943995-607444277-1197107654=:32213
Content-Type: TEXT/PLAIN; charset=us-ascii;
	name=sensors-detect-PC87317-PC97317-typo.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0712081054140.32213@elfpc10.elmagn.chalmers.se>
Content-Description: 
Content-Disposition: attachment;
	filename=sensors-detect-PC87317-PC97317-typo.patch

Rml4IHR5cG8uIEFjY29yZGluZyB0byBOYXRpb25hbCdzIGRhdGFzaGVldCBQ
Qzg3MzE3IGhhcyBTSUQgPSAweGQwIGFuZA0KUEM5NzMxNyBoYXMgU0lEID0g
MHhkZi4gUEM4NzM3MS9QQzk3MzcxIGRvIG5vdCBzZWVtIHRvIGV4aXN0Lg0K
DQpTaWduZWQtb2ZmLWJ5OiBVbGYgSm9yZGFuIDxqb3JkYW5AY2hhbG1lcnMu
c2U+DQoNCkluZGV4OiBzZW5zb3JzLWRldGVjdA0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KLS0tIHNlbnNvcnMtZGV0ZWN0CShyZXZpc2lvbiA1MDY0KQ0K
KysrIHNlbnNvcnMtZGV0ZWN0CSh3b3JraW5nIGNvcHkpDQpAQCAtMTY5Miwx
MiArMTY5MiwxMiBAQA0KIAlsb2dkZXYgPT4gMHgwZiwNCiAgICAgICB9LA0K
ICAgICAgIHsNCi0JbmFtZSA9PiAiTmF0LiBTZW1pLiBQQzg3MzcxIFN1cGVy
IElPIiwNCisJbmFtZSA9PiAiTmF0LiBTZW1pLiBQQzg3MzE3IFN1cGVyIElP
IiwNCiAJZHJpdmVyID0+ICJub3QtYS1zZW5zb3IiLA0KIAlkZXZpZCA9PiAw
eGQwLA0KICAgICAgIH0sDQogICAgICAgew0KLQluYW1lID0+ICJOYXQuIFNl
bWkuIFBDOTczNzEgU3VwZXIgSU8iLA0KKwluYW1lID0+ICJOYXQuIFNlbWku
IFBDOTczMTcgU3VwZXIgSU8iLA0KIAlkcml2ZXIgPT4gIm5vdC1hLXNlbnNv
ciIsDQogCWRldmlkID0+IDB4ZGYsDQogICAgICAgfSwNCg==

--276943995-607444277-1197107654=:32213
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--276943995-607444277-1197107654=:32213--
