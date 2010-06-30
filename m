From: yuri.nefedov@gmail.com
Date: Wed, 30 Jun 2010 10:04:58 +0000
Subject: [lm-sensors] config for Gigabyte P55-US3L
Message-Id: <alpine.DEB.2.00.1006301403230.25622@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-1967347543-1277892207=:25622"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1967347543-1277892207=:25622
Content-Type: TEXT/PLAIN; FORMAT=flowed; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1006301404011.25674@localhost.localdomain>


  Unfortunately wiki page (http://www.lm-sensors.org/wiki/Configurations)
  is not working  (requires authorization).

  So I send the configuration in the attachment.

  I used the following modules:
# Chip drivers
it87
coretemp

  The output of sensors is:
it8720-isa-0290
Adapter: ISA adapter
VCore1:      +0.85 V  (min =  +0.66 V, max =  +1.39 V)
DDR15V:      +1.58 V  (min =  +1.39 V, max =  +1.60 V)
+3.3V:       +3.34 V  (min =  +3.14 V, max =  +3.47 V)
+5V:         +4.97 V  (min =  +4.76 V, max =  +5.24 V)
in4:         +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
+12V:       +11.92 V  (min = +11.37 V, max = +12.59 V)
in6:         +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
-12V:       -12.01 V  (min = -10.84 V, max = -13.17 V)
VBat:        +3.25 V
CPU Fan:    1285 RPM  (min = 1000 RPM)
Case Fan:    928 RPM  (min =    0 RPM)
PCH Temp:    +32.0C  (low  = +127.0C, high = +50.0C)  sensor = thermistor
CPU Temp:    +24.0C  (low  = +127.0C, high = +70.0C)  sensor = thermistor
cpu0_vid:   +0.313 V

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +31.0C  (high = +84.0C, crit = +100.0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +27.0C  (high = +84.0C, crit = +100.0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +37.0C  (high = +84.0C, crit = +100.0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +27.0C  (high = +84.0C, crit = +100.0C)

  Thank you for your wonderful program.

  Yu.
--8323328-1967347543-1277892207=:25622
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=GA_P55_US3L
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.1006301403080.25622@localhost.localdomain>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=GA_P55_US3L

IyBHaWdhYml0ZSBQNTUtVVMzTCAocmV2IDE6MCwgQklPUyBGMSkNCiMgDQoN
CmNoaXAgIml0ODcyMC0qIg0KDQojIFZvbHRhZ2VzDQoNCiAgICBsYWJlbCAg
aW4wICAiVkNvcmUxIiAgICAgICAgIyBvaw0KICAgIGxhYmVsICBpbjEgICJE
RFIxNVYiICAgICAgICAjIG9rDQogICAgbGFiZWwgIGluMiAgIiszLjNWIiAg
ICAgICAgICMgb2sNCiAgICBsYWJlbCAgaW4zICAiKzVWIiAgICAgICAgICAg
IyBvaw0KIyAgICBpZ25vcmUgaW40ICAgICAgICAgICAgICAgICAjID8/IGNv
cnJlbGF0ZXMgd2l0aCBsb2FkX2F2L3RlbXAzL2ZhbjEgWzA7Mi40XQ0KICAg
IGxhYmVsICBpbjUgICIrMTJWIiAgICAgICAgICAjIG9rDQojICAgIGlnbm9y
ZSBpbjYgICAgICAgICAgICAgICAgICMgPz8gY29ycmVsYXRlcyB3aXRoIGxv
YWRfYXYvdGVtcDMvZmFuMSBbMDswLjNdDQogICAgbGFiZWwgIGluNyAgIi0x
MlYiICAgICAgICAgICMgb2ssIGJ1dCB0aGlzIGlzIGEgZ3Vlc3MNCiAgICBs
YWJlbCAgaW44ICAiVkJhdCINCg0KICAgIGNvbXB1dGUgaW4zICAoKDYuOC8x
MCkrMSkqQCAsIEAvKCg2LjgvMTApKzEpDQogICAgY29tcHV0ZSBpbjUgICgo
MjgvMTApKzEpKkAgICwgQC8oKDI4LzEwKSsxKQ0KICAgIGNvbXB1dGUgaW43
ICAoLTU2LzEwKSpAICAgICAsIEAvKC01Ni8xMCkgICAgICAjIHRoaXMgaXMg
YSBndWVzcw0KDQojICAgVklEIFZvbHRhZ2UgUmFuZ2UgZm9yIGNvcmUtaTUg
NzUwIA0KIyAgIChodHRwOi8vYXJrLmludGVsLmNvbS9Qcm9kdWN0LmFzcHg/
aWQ9NDI5MTUpDQogICAgc2V0IGluMF9taW4gIDAuNjUNCiAgICBzZXQgaW4w
X21heCAgMS40MA0KDQogICAgc2V0IGluMV9taW4gIDEuNCAgICAgICAgICAg
ICMgZGVwZW5kcyBmcm9tIEJJT1Mgc2V0dGluZ3MNCiAgICBzZXQgaW4xX21h
eCAgMS42ICAgICAgICAgICAgIyBjb3JyZWN0IGlmIGl0IGlzIHdyb25nDQoN
CiAgICBzZXQgaW4yX21pbiAgMy4zICogMC45NQ0KICAgIHNldCBpbjJfbWF4
ICAzLjMgKiAxLjA1DQoNCiAgICBzZXQgaW4zX21pbiAgICA1ICogMC45NQ0K
ICAgIHNldCBpbjNfbWF4ICAgIDUgKiAxLjA1DQoNCiAgICBzZXQgaW41X21p
biAgIDEyICogMC45NQ0KICAgIHNldCBpbjVfbWF4ICAgMTIgKiAxLjA1DQoN
CiAgICBzZXQgaW43X21pbiAgIC0xMiAqIDAuOTANCiAgICBzZXQgaW43X21h
eCAgIC0xMiAqIDEuMTANCg0KIyAgICBzZXQgaW40X21heCAgIDQuMDggDQoj
ICAgIHNldCBpbjZfbWF4ICAgNC4wOCANCiMgVGhlIGNoaXAgZG9lcyBub3Qg
c3VwcG9ydCBpbjggbWluL21heA0KDQojIFRlbXBlcmF0dXJlcw0KIw0KIyBz
ZWUgbWFuIHNlbnNvcnMuY29uZiBmb3IgYXZhaWxhYmxlIHRoZXJtYWwgc2Vu
c29yIHR5cGVzLg0KIyANCiMgICBzZXQgdGVtcDFfdHlwZSA0DQoNCiAgICBs
YWJlbCAgdGVtcDEgICAiUENIIFRlbXAiICAgIyBQQ0ggaXMgdGhlIHNvdXRo
IGJyaWRnZSANCiAgICBpZ25vcmUgdGVtcDINCiAgICBsYWJlbCAgdGVtcDMg
ICAiQ1BVIFRlbXAiDQoNCiAgICBzZXQgdGVtcDFfbWF4ICA1MA0KICAgIHNl
dCB0ZW1wM19tYXggIDcwDQoNCiMgRmFucw0KDQojIFRoZSBtYXRoZXJib2Fy
ZCBoYXMgY29ubmVjdG9yczogY3B1X2Zhbiwgc3lzX2ZhbjEvMiwgcHdyX2Zh
bg0KIyBjYXNlIGZhbiA9PSBzeXNfZmFuMQ0KDQogICAgbGFiZWwgIGZhbjEg
IkNQVSBGYW4iDQogICAgaWdub3JlIGZhbjINCiAgICBpZ25vcmUgZmFuMw0K
ICAgIGxhYmVsICBmYW40ICJDYXNlIEZhbiINCg0KICAgIHNldCBmYW4xX21p
biAxMDAwDQogICAgc2V0IGZhbjRfbWluIDANCg0K

--8323328-1967347543-1277892207=:25622
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--8323328-1967347543-1277892207=:25622--
