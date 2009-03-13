From: <Wsong@nuvoton.com>
Date: Fri, 13 Mar 2009 01:28:15 +0000
Subject: Re: [lm-sensors] NEW Nuvoton w83795 hw chip driver
Message-Id: <29CFBC9A3FDC81418F5FACEEC8970E0033F30D@ntshml01.nuvoton.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9A37A.ECCB7126"
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9A37A.ECCB7126
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Jean,

Thank you for your response.

I named main driver file as "wb83795.c" just for fit the Makefile. =
Please change its name to fit other drivers in kernel.

The attach file is the i2cdump result.=20

In fact I have made some subversions for kernel 2.6.5 (Suse 9), kernel =
2.6.9 (RHEL 4), kernel 2.6.21 and kernel 2.6.27. You can contact with me =
if you need them.


Best Regards,
wsong

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]=20
Sent: 2009=C4=EA3=D4=C212=C8=D5 21:06
To: PS23 WSONG
Cc: lm-sensors@lm-sensors.org; PS23 WMWU; PS00 LCChen; PS23 JGONG
Subject: Re: [lm-sensors] NEW Nuvoton w83795 hw chip driver

Hi Wei,

On Tue, 3 Mar 2009 16:20:15 +0800, Wsong@nuvoton.com wrote:
> Dear lm-sensor group,
>=20
> I am glad to submit to you the driver for Nuvoton W83795G/ADG hw =
monitor chip.=20
>=20
> The W83795G/ADG chip information are show at here:
> =
http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/ComputerIC/Har=
dwareMonitor/HWMonitorforDesktopAndServer/

I have added an entry for that chip to our wiki Devices page. Thanks a
lot for contributing code for your hardware, this is very appreciated.

> Driver files list:
> The attach file "wb83795.c" is the main driver file. This driver =
passed test on kernel 2.6.28.7.

Shouldn't this rather be w83795.c? This would be consistent with the
other driver names and with your sensors-detect patch.

> The attach file "Makefile" is used for compile the driver.
>=20
> Patch files for lm-sensors 3.0.3:
>=20
> The attach file "795_sensor3.conf" is the 795 related lines for =
sensor3.conf. But the exact names and settings may be changed for the =
motherboards.
>=20
> The attach file "DESC" is the list of sys files which 795 driver would =
create.
>=20
> The attach file "sensors-detect.3.0.3.patch" add detect 795 chip for =
"sensor-detect" tool in lm-sensors 3.0.3 package.

I have adjusted this patch so that it applies on top of 3.1.0 (there
have been a lot of changes in sensors-detect between 3.0.3 and 3.1.0.)
Can you please send me a dump of your W83795 chip so that I can test
the code before I commit it? You can obtain such a dump using the
i2c-dev kernel driver and "i2cdump" from the i2c-tools package:

# modprobe i2c-dev
# i2cdump 0 0x2d b

Replace 0 with the actual I2C bus number your chip sits on and 0x2d
with the actual I2C address of the chip. Remember to first unload the
w83795 driver if it is loaded.

> Until now, it seems there is not a motherboard based on W83795G/ADG in =
the market, and I am sure not the 795 SPEC could be share to you or not.
>=20
> Please contact me if you need any help, want to know any information =
or have some other questions.

Unfortunately I will not have the time to do more. Maybe later when
there are actual motherboards with this chip and users start asking for
support...

--=20
Jean Delvare


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The privileged confidential information contained in this email is =
intended for use only by the addressees as indicated by the original =
sender of this email. If you are not the addressee indicated in this =
email or are not responsible for delivery of the email to such  a =
person, please kindly reply to the sender indicating this fact and =
delete all copies of it from your computer and network server =
immediately. Your cooperation is highly appreciated. It is advised that =
any unauthorized use of confidential information of Nuvoton is strictly =
prohibited; and any information in this email irrelevant to the official =
business of Nuvoton shall be deemed as neither given nor endorsed by =
Nuvoton.

------_=_NextPart_001_01C9A37A.ECCB7126
Content-Type: text/plain;
	name="repo5.txt"
Content-Transfer-Encoding: base64
Content-Description: repo5.txt
Content-Disposition: attachment;
	filename="repo5.txt"

bGludXgtcmVpNjp+ICMgaTJjZHVtcCAwIDB4MmYgYiAwIDANCldBUk5JTkchIFRoaXMgcHJvZ3Jh
bSBjYW4gY29uZnVzZSB5b3VyIEkyQyBidXMsIGNhdXNlIGRhdGEgbG9zcyBhbmQgd29yc2UhDQpJ
IHdpbGwgcHJvYmUgZmlsZSAvZGV2L2kyYy0wLCBhZGRyZXNzIDB4MmYsIG1vZGUgYnl0ZQ0KQ29u
dGludWU/IFtZL25dIHkNCiAgICAgMCAgMSAgMiAgMyAgNCAgNSAgNiAgNyAgOCAgOSAgYSAgYiAg
YyAgZCAgZSAgZiAgICAwMTIzNDU2Nzg5YWJjZGVmDQowMDogODAgNTUgZmYgNzggM2YgYTAgZmYg
MDAgMGYgMDAgMGYgZmYgMDAgMDAgMDAgMDAgICAgP1UueD8/Li4/Lj8uLi4uLg0KMTA6IDdkIDM0
IGJmIGJlIDAwIGNjIGM3IDdlIDAwIDAwIDAwIDg5IDg4IDg2IDgzIGMxICAgIH00Pz8uPz9+Li4u
Pz8/Pz8NCjIwOiBjMSA4MCA4MCA5NiA5OCAyMyAxNiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwZiBm
ZiAgICA/Pz8/PyM/Li4uLi4uLj8uDQozMDogZmYgZmYgMTIgZmYgZmYgZmYgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgZmYgZmYgZmYgICAgLi4/Li4uLi4uLi4uLi4uLg0KNDA6IDkwIGYyIDAwIDMwIDAw
IGVlIDAwIDAwIDAwIDQwIDAwIGZmIDAwIDdmIDNmIGZmICAgID8/LjAuPy4uLkAuLi4/Py4NCjUw
OiAwMCAwMCAwMCAwMCAwMCAwMCBmZiBmZiA4MSAwMCAwMyAwMCAwMCAwMCAwMCAwMCAgICAuLi4u
Li4uLj8uPy4uLi4uDQo2MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgNjQgNjQg
ZmYgZmYgZmYgICAgLi4uLi4uLi4uLi5kZC4uLg0KNzA6IGFmIDU3IGFmIDU3IGNlIGE4IGNlIDg5
IGNlIDg5IGFmIDMyIGFmIDMyIDcyIDQ2ICAgID9XP1c/Pz8/Pz8/Mj8yckYNCjgwOiBmZiAwMCBm
ZiAwMCBmZiAwMCA5NiA3ZCA5NiA3ZCA5NiA3ZCA5NiA0ZiA1MCBiYSAgICAuLi4uLi4/fT99P30/
T1A/DQo5MDogMjkgMmEgM2YgMDAgMDAgMDAgNjQgNWYgNTUgNTAgNjQgNWYgNTUgNTAgNjQgNWYg
ICAgKSo/Li4uZF9VUGRfVVBkXw0KYTA6IDU1IDUwIDY0IDVmIDU1IDUwIDVhIDU3IDU1IDUyIDVh
IDU3IDU1IDUyIDVhIDU3ICAgIFVQZF9VUFpXVVJaV1VSWlcNCmIwOiA1NSA1MiA1NCA0ZiA1NSA1
MCBmZiBmZiBkMiBkMiBkMiBkMiBkMiBkMiBmZiBmZiAgICBVUlRPVVAuLj8/Pz8/Py4uDQpjMDog
ZmYgZmYgZmYgZmYgZWUgZmYgZmYgZmYgZWUgZWUgZWUgZmYgZmYgZmYgZmYgZmYgICAgLi4uLj8u
Li4/Pz8uLi4uLg0KZDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDIyIDI0IDBhIDYwIDAw
IDAwIDAwICAgIC4uLi4uLi4uLiIkP2AuLi4NCmUwOiAwMCAwMCAwMCAwMCAwMCAwMCBiYiBjMCAw
OSAwOSAwOSAwOSAwOSAyMiAyMiAwMiAgICAuLi4uLi4/Pz8/Pz8/IiI/DQpmMDogZmYgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMGYgZmYgNTEgYWYgNWMgNzkgNTAgICAgLi4uLi4uLi4uPy5RP1x5
UA0KDQoNCg0KbGludXgtcmVpNjp+ICMgaTJjZHVtcCAwIDB4MmYgYiAxIDANCldBUk5JTkchIFRo
aXMgcHJvZ3JhbSBjYW4gY29uZnVzZSB5b3VyIEkyQyBidXMsIGNhdXNlIGRhdGEgbG9zcyBhbmQg
d29yc2UhDQpJIHdpbGwgcHJvYmUgZmlsZSAvZGV2L2kyYy0wLCBhZGRyZXNzIDB4MmYsIG1vZGUg
Ynl0ZQ0KUHJvYmluZyBiYW5rIDEgdXNpbmcgYmFuayByZWdpc3RlciAweDAwLg0KQ29udGludWU/
IFtZL25dIHkNCiAgICAgMCAgMSAgMiAgMyAgNCAgNSAgNiAgNyAgOCAgOSAgYSAgYiAgYyAgZCAg
ZSAgZiAgICAwMTIzNDU2Nzg5YWJjZGVmDQowMDogODEgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgICAgPy4uLi4uLi4uLi4uLi4uLg0KMTA6IGZmIGZmIGZmIGZm
IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmICAgIC4uLi4uLi4uLi4uLi4uLi4N
CjIwOiBjMSAwOCAxMCA1MCA3OSA1YSAwMCAyNCAwMCAwMCAwMCAwMCBhMCA4ZSA1NCA0YiAgICA/
Pz9QeVouJC4uLi4/P1RLDQozMDogM2YgNmEgMTMgZWMgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYg
ZmYgZmYgZmYgMDAgICAgP2o/Py4uLi4uLi4uLi4uLg0KNDA6IDAzIDAzIDA3IDA3IDA3IDA3IDA3
IDA3IDA3IDA3IDA3IDA3IDA3IDA3IDA3IDA3ICAgID8/Pz8/Pz8/Pz8/Pz8/Pz8NCjUwOiAwNyAw
MyAwNyAwNyAwNyAwNyAwNyAwNyAwNyAwNyAwNyAwNyAwNyAwNyAwNyAwNyAgICA/Pz8/Pz8/Pz8/
Pz8/Pz8/DQo2MDogMDcgMDcgMDcgMDcgMDcgMDcgMDcgMDcgMDcgMDMgMDMgMDMgMDMgMDMgMDMg
MDMgICAgPz8/Pz8/Pz8/Pz8/Pz8/Pw0KNzA6IDAzIDA3IDIzIGZmIGZmIGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmIGZmIGZmIGZmICAgID8/Iy4uLi4uLi4uLi4uLi4NCjgwOiAwMSAwMiAwNCAwNSAw
NiAwNyAwOCAwOSAwYSAwYiAwYyAwZCAwZSAwZiAxMCAxMSAgICA/Pz8/Pz8/Pz8/Pz8/Pz8/DQo5
MDogMTIgMDMgMDEgMDIgMDMgMjEgNDMgNjUgODcgYTkgY2IgZWQgMjEgNDMgNjUgMjEgICAgPz8/
Pz8hQ2U/Pz8/IUNlIQ0KYTA6IDQzIDY1IDg3IDE3IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmICAgIENlPz8uLi4uLi4uLi4uLi4NCmIwOiAwMCAxMSAxMiAxMCBmZiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAgICAuPz8/Li4uLi4uLi4uLi4uDQpjMDogZmYgZmYg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgICAgLi4uLi4uLi4uLi4u
Li4uLg0KZDA6IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZm
ICAgIC4uLi4uLi4uLi4uLi4uLi4NCmUwOiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZiAgICAuLi4uLi4uLi4uLi4uLi4uDQpmMDogZmYgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMGYgZmYgNTEgYWYgNWMgNzkgNTAgICAgLi4uLi4uLi4uPy5RP1x5UA0KDQoN
Cg0KbGludXgtcmVpNjp+ICMgaTJjZHVtcCAwIDB4MmYgYiAyIDANCldBUk5JTkchIFRoaXMgcHJv
Z3JhbSBjYW4gY29uZnVzZSB5b3VyIEkyQyBidXMsIGNhdXNlIGRhdGEgbG9zcyBhbmQgd29yc2Uh
DQpJIHdpbGwgcHJvYmUgZmlsZSAvZGV2L2kyYy0wLCBhZGRyZXNzIDB4MmYsIG1vZGUgYnl0ZQ0K
UHJvYmluZyBiYW5rIDIgdXNpbmcgYmFuayByZWdpc3RlciAweDAwLg0KQ29udGludWU/IFtZL25d
IHkNCiAgICAgMCAgMSAgMiAgMyAgNCAgNSAgNiAgNyAgOCAgOSAgYSAgYiAgYyAgZCAgZSAgZiAg
ICAwMTIzNDU2Nzg5YWJjZGVmDQowMDogODIgMDAgMDMgMDMgMDAgMDAgMDAgMDAgM2YgMTEgMTEg
MDAgNDAgMDEgMDEgMDIgICAgPy4/Py4uLi4/Pz8uQD8/Pw0KMTA6IDRjIDRjIDRkIDRkIDRkIDRk
IDRkIDRkIDg0IDg1IDg1IDg1IDg1IDg1IDg1IDg1ICAgIExMTU1NTU1NPz8/Pz8/Pz8NCjIwOiAz
MCAzMCAzMCAzMCAzMCAzMCAzMCAzMCAxMCAxMCAxMCAxMCAxMCAxMCAxMCAxMCAgICAwMDAwMDAw
MD8/Pz8/Pz8/DQozMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgZmYgZmYgZmYgZmYgZmYgZmYg
ZmYgZmYgICAgLi4uLi4uLi4uLi4uLi4uLg0KNDA6IDYwIDAwIDYwIDAwIDYwIDAwIDYwIDAwIDYw
IDAwIDYwIDAwIDYwIDAwIDYwIDAwICAgIGAuYC5gLmAuYC5gLmAuYC4NCjUwOiAxMCBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAgICA/Li4uLi4uLi4uLi4uLi4u
DQo2MDogMjggMjggMjggMjggMjggMjggZmYgZmYgNGMgNGMgNjAgNjAgNjAgNjAgZmYgZmYgICAg
KCgoKCgoLi5MTGBgYGAuLg0KNzA6IDAwIDAwIDAwIDAwIDAwIDAwIGZmIGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmIGZmICAgIC4uLi4uLi4uLi4uLi4uLi4NCjgwOiAxYiAxYiAxYiAxYiAxYiAyZiA0
YiBmZiA0YyA0YyA0YyA0YyA0YyA4MCBmZiBmZiAgICA/Pz8/Py9LLkxMTExMPy4uDQo5MDogMWIg
MWIgMWIgMWIgMWIgMmYgNGIgZmYgNGMgNGMgNGMgNGMgNGMgODAgZmYgZmYgICAgPz8/Pz8vSy5M
TExMTD8uLg0KYTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZm
IGZmICAgIC4uLi4uLi4uLi4uLi4uLi4NCmIwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZiBmZiAgICAuLi4uLi4uLi4uLi4uLi4uDQpjMDogMWIgMWIgMWIgMWIg
MWIgMmYgNGIgZmYgNGMgNGMgNGMgNGMgNGMgODAgZmYgZmYgICAgPz8/Pz8vSy5MTExMTD8uLg0K
ZDA6IDFiIDFiIDFiIDFiIDFiIDJmIDRiIGZmIDRjIDRjIDRjIDRjIDRjIDgwIGZmIGZmICAgID8/
Pz8/L0suTExMTEw/Li4NCmUwOiAwMCAwMCA4MCA4MCA4MCA4MCA4MCA4MCA4MCA4MCBmZiBmZiBm
ZiBmZiBmZiBmZiAgICAuLj8/Pz8/Pz8/Li4uLi4uDQpmMDogZmYgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMGYgZmYgNTEgYWYgNWMgNzkgNTAgICAgLi4uLi4uLi4uPy5RP1x5UA0KDQoNCg0KbGlu
dXgtcmVpNjp+ICMgaTJjZHVtcCAwIDB4MmYgYiAzIDANCldBUk5JTkchIFRoaXMgcHJvZ3JhbSBj
YW4gY29uZnVzZSB5b3VyIEkyQyBidXMsIGNhdXNlIGRhdGEgbG9zcyBhbmQgd29yc2UhDQpJIHdp
bGwgcHJvYmUgZmlsZSAvZGV2L2kyYy0wLCBhZGRyZXNzIDB4MmYsIG1vZGUgYnl0ZQ0KUHJvYmlu
ZyBiYW5rIDMgdXNpbmcgYmFuayByZWdpc3RlciAweDAwLg0KQ29udGludWU/IFtZL25dIHkNCiAg
ICAgMCAgMSAgMiAgMyAgNCAgNSAgNiAgNyAgOCAgOSAgYSAgYiAgYyAgZCAgZSAgZiAgICAwMTIz
NDU2Nzg5YWJjZGVmDQowMDogODMgMDAgMDMgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYg
ZmYgZmYgZmYgICAgPy4/Li4uLi4uLi4uLi4uLg0KMTA6IDI1IDAwIDIyIDgxIGZmIDAzIGZmIDAw
IDAwIDAxIDAwIDQwIDAwIDAwIGZmIGZmICAgICUuIj8uPy4uLj8uQC4uLi4NCjIwOiA1NSA1NSA1
MCA1MCA1MCA1MCA1MCA1MCBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAgICBVVVBQUFBQUC4uLi4u
Li4uDQozMDogMDAgMDAgMDAgMDAgMDAgMDAgMjAgMDAgMDEgMDAgMDEgZmYgZmYgZmYgZmYgZmYg
ICAgLi4uLi4uIC4/Lj8uLi4uLg0KNDA6IGYwIDZjIDgwIDAwIGY4IDgwIGY4IDgwIGY4IDgwIGY4
IDgwIGY4IDgwIGY4IDgwICAgID9sPy4/Pz8/Pz8/Pz8/Pz8NCjUwOiBmOCA4MCBmOCA4MCBmOCA4
MCBmOCA4MCBmOCA4MCBmOCA4MCBmOCA4MCBmOCA4MCAgICA/Pz8/Pz8/Pz8/Pz8/Pz8/DQo2MDog
ZjkgMDAgZjkgMDAgZjkgMDAgZjkgMDAgZjkgMDAgZjkgMDAgZjkgMDAgZjkgMDAgICAgPy4/Lj8u
Py4/Lj8uPy4/Lg0KNzA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIGZmIGZm
IGZmIGZmICAgIC4uLi4uLi4uLi4uLi4uLi4NCjgwOiAwMCAwMCAwMCAwMCAwMCA0MCBmZiBmZiBm
OSAwMCAwMCBmZiBmZiBmZiBmZiBmZiAgICAuLi4uLkAuLj8uLi4uLi4uDQo5MDogMDIgMTcgMDAg
MGEgMDAgMDAgMDAgZWYgNDIgOTAgZWYgZmYgZmYgZmYgZmYgZmYgICAgPz8uPy4uLj9CPz8uLi4u
Lg0KYTA6IDEwIDE5IDAwIDAwIDAxIDAxIDAwIDAwIDAwIDAwIGNmIDAwIGZmIGZmIGZmIGZmICAg
ID8/Li4/Py4uLi4/Li4uLi4NCmIwOiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiAgICAuLi4uLi4uLi4uLi4uLi4uDQpjMDogZmYgZmYgZmYgZmYgZmYgZmYg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgICAgLi4uLi4uLi4uLi4uLi4uLg0KZDA6IGZm
IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmICAgIC4uLi4uLi4u
Li4uLi4uLi4NCmUwOiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBm
ZiBmZiAgICAuLi4uLi4uLi4uLi4uLi4uDQpmMDogZmYgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MGYgZmYgNTEgYWYgNWMgNzkgNTAgICAgLi4uLi4uLi4uPy5RP1x5UA0KDQoNCg0KDQoNCg==

------_=_NextPart_001_01C9A37A.ECCB7126
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------_=_NextPart_001_01C9A37A.ECCB7126--
