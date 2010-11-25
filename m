From: Andrea Rizzolo <andrea.rizzolo@gmail.com>
Date: Thu, 25 Nov 2010 08:38:46 +0000
Subject: Re: [lm-sensors] ASRock board W83677HG-I
Message-Id: <AANLkTin13pDMgBqFUMekW27NonDMs4jYhqoHuPbbvRTj@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4434973186579294939=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1274168639.7859.20.camel@eee51>
In-Reply-To: <1274168639.7859.20.camel@eee51>
To: lm-sensors@vger.kernel.org

--===============4434973186579294939==
Content-Type: multipart/alternative; boundary=000e0cd6ade0c724040495dc88a9

--000e0cd6ade0c724040495dc88a9
Content-Type: text/plain; charset=UTF-8

*bump*
Hi, any update? I have the same chip on my Intel DH57JG motherboard and I'm
playing with w83627ehf driver (2.6.36). if I load it with force_id=0xa510,
running sensors gives me some apparently working output:

w83667hg-isa-0680
Adapter: ISA adapter
Vcore:       +0.93 V  (min =  +0.00 V, max =  +1.74 V)
in1:         +0.77 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
AVCC:        +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
+3.3V:       +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in4:         +1.26 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in5:         +0.78 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
3VSB:        +3.36 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
Vbat:        +3.30 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
fan1:          0 RPM  (min =    0 RPM, div = 2)  ALARM
fan2:          0 RPM  (min =    0 RPM, div = 2)  ALARM
fan3:          0 RPM  (min =    0 RPM, div = 2)  ALARM
fan5:          0 RPM  (min =    0 RPM, div = 2)  ALARM
temp1:       +29.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor =
diode
temp2:       +30.5 C  (high = +80.0 C, hyst = +75.0 C)  sensor = diode
temp3:       +23.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
cpu0_vid:   +2.050 V

Greets, Andrea

--000e0cd6ade0c724040495dc88a9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

KmJ1bXAqPGJyPkhpLCBhbnkgdXBkYXRlPyBJIGhhdmUgdGhlIHNhbWUgY2hpcCBvbiBteSBJbnRl
bCBESDU3SkcgbW90aGVyYm9hcmQgYW5kIEkmIzM5O20gcGxheWluZyB3aXRoIHc4MzYyN2VoZiBk
cml2ZXIgKDIuNi4zNikuIGlmIEkgbG9hZCBpdCB3aXRoIGZvcmNlX2lkPTB4YTUxMCwgcnVubmlu
ZyBzZW5zb3JzIGdpdmVzIG1lIHNvbWUgYXBwYXJlbnRseSB3b3JraW5nIG91dHB1dDo8YnI+Cjxi
cj53ODM2NjdoZy1pc2EtMDY4MDxicj5BZGFwdGVyOiBJU0EgYWRhcHRlcjxicj5WY29yZTrCoMKg
wqDCoMKgwqAgKzAuOTMgVsKgIChtaW4gPcKgICswLjAwIFYsIG1heCA9wqAgKzEuNzQgVinCoMKg
IDxicj5pbjE6wqDCoMKgwqDCoMKgwqDCoCArMC43NyBWwqAgKG1pbiA9wqAgKzAuMDAgViwgbWF4
ID3CoCArMC4wMCBWKcKgwqAgQUxBUk08YnI+QVZDQzrCoMKgwqDCoMKgwqDCoCArMy40MSBWwqAg
KG1pbiA9wqAgKzAuMDAgViwgbWF4ID3CoCArMC4wMCBWKcKgwqAgQUxBUk08YnI+CiszLjNWOsKg
wqDCoMKgwqDCoCArMy40MSBWwqAgKG1pbiA9wqAgKzAuMDAgViwgbWF4ID3CoCArMC4wMCBWKcKg
wqAgQUxBUk08YnI+aW40OsKgwqDCoMKgwqDCoMKgwqAgKzEuMjYgVsKgIChtaW4gPcKgICswLjAw
IFYsIG1heCA9wqAgKzAuMDAgVinCoMKgIEFMQVJNPGJyPmluNTrCoMKgwqDCoMKgwqDCoMKgICsw
Ljc4IFbCoCAobWluID3CoCArMC4wMCBWLCBtYXggPcKgICswLjAwIFYpwqDCoCBBTEFSTTxicj4z
VlNCOsKgwqDCoMKgwqDCoMKgICszLjM2IFbCoCAobWluID3CoCArMC4wMCBWLCBtYXggPcKgICsw
LjAwIFYpwqDCoCBBTEFSTTxicj4KVmJhdDrCoMKgwqDCoMKgwqDCoCArMy4zMCBWwqAgKG1pbiA9
wqAgKzAuMDAgViwgbWF4ID3CoCArMC4wMCBWKcKgwqAgQUxBUk08YnI+ZmFuMTrCoMKgwqDCoMKg
wqDCoMKgwqAgMCBSUE3CoCAobWluID3CoMKgwqAgMCBSUE0sIGRpdiA9IDIpwqAgQUxBUk08YnI+
ZmFuMjrCoMKgwqDCoMKgwqDCoMKgwqAgMCBSUE3CoCAobWluID3CoMKgwqAgMCBSUE0sIGRpdiA9
IDIpwqAgQUxBUk08YnI+ZmFuMzrCoMKgwqDCoMKgwqDCoMKgwqAgMCBSUE3CoCAobWluID3CoMKg
wqAgMCBSUE0sIGRpdiA9IDIpwqAgQUxBUk08YnI+CmZhbjU6wqDCoMKgwqDCoMKgwqDCoMKgIDAg
UlBNwqAgKG1pbiA9wqDCoMKgIDAgUlBNLCBkaXYgPSAyKcKgIEFMQVJNPGJyPnRlbXAxOsKgwqDC
oMKgwqDCoCArMjkuMCBDwqAgKGhpZ2ggPcKgICswLjAgQywgaHlzdCA9wqAgKzAuMCBDKcKgIEFM
QVJNwqAgc2Vuc29yID0gZGlvZGU8YnI+dGVtcDI6wqDCoMKgwqDCoMKgICszMC41IEPCoCAoaGln
aCA9ICs4MC4wIEMsIGh5c3QgPSArNzUuMCBDKcKgIHNlbnNvciA9IGRpb2RlPGJyPnRlbXAzOsKg
wqDCoMKgwqDCoCArMjMuMCBDwqAgKGhpZ2ggPSArODAuMCBDLCBoeXN0ID0gKzc1LjAgQynCoCBz
ZW5zb3IgPSB0aGVybWlzdG9yPGJyPgpjcHUwX3ZpZDrCoMKgICsyLjA1MCBWPGJyPjxicj5HcmVl
dHMsIEFuZHJlYTxicj48YnI+Cg==
--000e0cd6ade0c724040495dc88a9--


--===============4434973186579294939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4434973186579294939==--
