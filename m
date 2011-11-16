From: Eddi De Pieri <eddi@depieri.net>
Date: Wed, 16 Nov 2011 16:18:20 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <CAKdnbx4bo94K-7VoQt+dn6fm=suiMWaKEsE3rC__KHsQejHLWQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="f46d04428cb8f6dd2204b1dc74ab"
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
To: lm-sensors@vger.kernel.org

--f46d04428cb8f6dd2204b1dc74ab
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Finally I get W83795ADG working on my proliant microserver

The patch is based on i2c-amd756-s4882.c and adapted for sb800 southbus.

Karsten, please try it too...

root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -l
i2c-0=A0=A0 smbus=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus piix4 adapter (SDA0)=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus adapter
i2c-1=A0=A0 smbus=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus piix4 adapter (SDA2)=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus adapter
i2c-2=A0=A0 smbus=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus piix4 adapter (SDA3)=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus adapter
i2c-3=A0=A0 smbus=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus piix4 adapter (SDA4)=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SMBus adapter
root@proliant:/usr/src/lm-sensors/eddi#

yes SDA1 is reserved... so i can't multiplex it

root@proliant:/usr/src/lm-sensors/eddi# sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:=A0=A0=A0=A0=A0=A0 +24.5=B0C=A0 (high =3D +70.0=B0C, crit =3D +100.0=
=B0C)

w83795adg-i2c-1-2f
Adapter: SMBus piix4 adapter (SDA2)
in0:=A0=A0=A0=A0=A0=A0=A0=A0 +1.02 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +2.=
05 V)
in1:=A0=A0=A0=A0=A0=A0=A0=A0 +1.52 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +2.=
05 V)
in2:=A0=A0=A0=A0=A0=A0=A0=A0 +1.10 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +2.=
05 V)
in3:=A0=A0=A0=A0=A0=A0=A0=A0 +0.89 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +2.=
05 V)
in12:=A0=A0=A0=A0=A0=A0=A0 +3.35 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +6.14=
 V)
in13:=A0=A0=A0=A0=A0=A0=A0 +3.28 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +6.14=
 V)
fan1:=A0=A0=A0=A0=A0=A0=A0 703 RPM=A0 (min =3D=A0 329 RPM)
temp1:=A0=A0=A0=A0=A0=A0 +23.0=B0C=A0 (high =3D +109.0=B0C, hyst =3D +109.0=
=B0C)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crit =3D +=
109.0=B0C, hyst =3D +109.0=B0C)=A0 sensor =3D thermal diode
temp2:=A0=A0=A0=A0=A0=A0 +33.2=B0C=A0 (high =3D +105.0=B0C, hyst =3D +105.0=
=B0C)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crit =3D +=
105.0=B0C, hyst =3D +105.0=B0C)=A0 sensor =3D thermal diode
temp5:=A0=A0=A0=A0=A0=A0 +14.0=B0C=A0 (high =3D +39.0=B0C, hyst =3D +39.0=
=B0C)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crit =3D +=
44.0=B0C, hyst =3D +44.0=B0C)=A0 sensor =3D thermistor
beep_enable:disabled

jc42-i2c-0-18
Adapter: SMBus piix4 adapter (SDA0)
temp1:=A0=A0=A0=A0=A0=A0 +20.5=B0C=A0 (low=A0 =3D=A0 +0.0=B0C, high =3D=A0 =
+0.0=B0C)=A0 ALARM
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crit =3D=
=A0 +0.0=B0C, hyst =3D=A0 +0.0=B0C)=A0 ALARM


root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 0
=A0=A0=A0=A0 0=A0 1=A0 2=A0 3=A0 4=A0 5=A0 6=A0 7=A0 8=A0 9=A0 a=A0 b=A0 c=
=A0 d=A0 e=A0 f
00:=A0=A0=A0=A0=A0=A0=A0=A0=A0 -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 1
=A0=A0=A0=A0 0=A0 1=A0 2=A0 3=A0 4=A0 5=A0 6=A0 7=A0 8=A0 9=A0 a=A0 b=A0 c=
=A0 d=A0 e=A0 f
00:=A0=A0=A0=A0=A0=A0=A0=A0=A0 -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- 61 -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 2
=A0=A0=A0=A0 0=A0 1=A0 2=A0 3=A0 4=A0 5=A0 6=A0 7=A0 8=A0 9=A0 a=A0 b=A0 c=
=A0 d=A0 e=A0 f
00:=A0=A0=A0=A0=A0=A0=A0=A0=A0 -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

root@proliant:/usr/src/lm-sensors/eddi# i2cdetect -y 3
=A0=A0=A0=A0 0=A0 1=A0 2=A0 3=A0 4=A0 5=A0 6=A0 7=A0 8=A0 9=A0 a=A0 b=A0 c=
=A0 d=A0 e=A0 f
00:=A0=A0=A0=A0=A0=A0=A0=A0=A0 -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

pay attention that the msleep seems to be really needed...

Regards, Eddi

On Tue, Aug 16, 2011 at 9:26 AM, Eddi De Pieri <eddi@depieri.net> wrote:
>
> Hi Jean...
>
> The bios show fan rpm and temperature. Since my own proliant microserver =
lacks of ipmi card, I doubt the bios give me the results using ipmi call.
>
> The HP Proliant Microserver chipset (SB820M) have a multiplexed smbus lik=
e your.
>
>
> http://support.amd.com/it/Embedded_TechDocs/47283_sb820m_ds_pub_2.00.pdf
>
> Here is technical document from amd...
>
>
> at p52/53 they say:
>
> (1) The SDA1 and SCL1 SMBus interface is dedicated for ASF devices only. =
It should not be used to
> connect to any other devices.
> (2) There are only two SMBus controllers. The SCL1/SDA1 pair is controlle=
d by SMBus controller 1.
>
>
> SCL0/SDA0, SCL2/SDA2, SCL3/SDA3 and SCL4/SDA4 are multiplexed pins that a=
re all controlled by
> SMBus controller 0, and only 1 pair of those pins can be active at any ti=
me.
>
> I can't understand how to enable 2, 3 and 4 muxed bus..
>
>
> If you consolidate a solution for i2c-i801.c I hope we can be replicated =
for i2c-piix4.c too..
>
>
>
>
> Hi Karsten,
>
> On Fri, 22 Oct 2010 16:04:10 +0200, karsten at maxi-dsl.de wrote:
> > hi Jean,
> > > The w83795 driver uses the same detection mechanism used in
>
>
> > > sensors-detect. So if sensors-detect doesn't see your chip, I am not
> > > surprised that the driver didn't either.
> >
> > > The full output of sensors-detect is needed to diagnose your problem
>
>
> > > further. It could be that your SMBus controller isn't supported, or
> > > maybe you are supposed to access the chip through IPMI.
> >
> > IPMI is probably the key..
>
>
> >
> >  From the sensors-detect output:
> > "Warning: the required module ipmisensors is not currently installed
> > on your system. If it is built into the kernel then it's OK.
>
>
> > Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> > driver availability" (full ouput attached)
> >
>
> > I did see the output before, but didn't really understand the
>
> > implications (IPMI seems to be an alternative way of accessing the
> > monitoring chips?)
>
> Yes. The strength of IPMI access is that it can be used remotely too,
> for example from a BMC plugged into your system.
>
>
>
> > The suggested ipmisensors driver however does not seem to be available,=
 right?
> > (http://lm-sensors.org/wiki/Devices says "(2004-12-12)  Port to Linux
>
>
> > 2.6 in progress by Yani Ioannou")
>
> That project is essentially dead. At the time being, the best way to
> retrieve IPMI-based sensor values is using "ipmitool sensor". The
> drawback is that this isn't integrated with libsensors, so the usually
>
>
> monitoring applications won't work.
>
> If you have a BMC or are otherwise already using IPMI on your machine,
> just use ipmitool and you're done.
>
> If not, then it might be worth trying ipmitool once, and then try
>
>
> sensors-detect again. There is a small chance that, once ipmitool
> managed to access the monitoring device, sensors-detect will see it. My
> own mainboard which has a W83795ADG chip has a multiplexed SMBus, and I
> can only see the W83795ADG in sensors-detect when the multiplexer is
>
>
> set properly. Otherwise I would see the memory modules, which _do_
> appear in your sensors-detect output. So maybe your board has a
> multiplexed SMBus too.
>
> If the trick doesn't work, you may want to try the new jc42 driver
>
>
> which can monitor the temperature of some DDR3 memory modules. I
> suspect your memory modules have such sensors. A more recent version of
> sensors-detect would confirm that:
>   http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>
>
>
> I also see that sensors-detect suggested to use the k10temp driver,
> which your kernel doesn't have. You can try the standalone flavor of
> the drivers which I maintain at:
>   http://khali.linux-fr.org/devel/misc/k10temp/
>
>
> The accuracy of the CPU internal sensors is limited, but that's still
> better than nothing.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>
>

--f46d04428cb8f6dd2204b1dc74ab
Content-Type: application/octet-stream; 
	name="proliant-microserver-n36l.diff"
Content-Disposition: attachment; filename="proliant-microserver-n36l.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gv2j5ltw0

ZGlmZiAtdSAtTiAtciAyLjYuMzIub3JpZy9pMmMtcGlpeDQuYyAyLjYuMzIvaTJjLXBpaXg0LmMK
LS0tIDIuNi4zMi5vcmlnL2kyYy1waWl4NC5jCTIwMTEtMTEtMTYgMTc6MDc6MDMuMDAwMDAwMDAw
ICswMTAwCisrKyAyLjYuMzIvaTJjLXBpaXg0LmMJMjAxMS0xMS0xNiAxNToyMToxNy4wMDAwMDAw
MDAgKzAxMDAKQEAgLTk3LDcgKzk3LDggQEAKIHN0YXRpYyB1bnNpZ25lZCBzaG9ydCBwaWl4NF9z
bWJhOwogc3RhdGljIGludCBzcnZyd29ya3NfY3NiNV9kZWxheTsKIHN0YXRpYyBzdHJ1Y3QgcGNp
X2RyaXZlciBwaWl4NF9kcml2ZXI7Ci1zdGF0aWMgc3RydWN0IGkyY19hZGFwdGVyIHBpaXg0X2Fk
YXB0ZXI7CitzdHJ1Y3QgaTJjX2FkYXB0ZXIgcGlpeDRfYWRhcHRlcjsKK0VYUE9SVF9TWU1CT0xf
R1BMKHBpaXg0X2FkYXB0ZXIpOwogCiBzdGF0aWMgc3RydWN0IGRtaV9zeXN0ZW1faWQgX19kZXZp
bml0ZGF0YSBwaWl4NF9kbWlfYmxhY2tsaXN0W10gPSB7CiAJewpAQCAtMjQ2LDEwICsyNDcsMjIg
QEAKIAkJCSIweCV4IGFscmVhZHkgaW4gdXNlIVxuIiwgc21iYV9pZHgpOwogCQlyZXR1cm4gLUVC
VVNZOwogCX0KLQlvdXRiX3Aoc21iX2VuLCBzbWJhX2lkeCk7Ci0Jc21iYV9lbl9sbyA9IGluYl9w
KHNtYmFfaWR4ICsgMSk7Ci0Jb3V0Yl9wKHNtYl9lbiArIDEsIHNtYmFfaWR4KTsKLQlzbWJhX2Vu
X2hpID0gaW5iX3Aoc21iYV9pZHggKyAxKTsKKwlvdXRiX3Aoc21iX2VuLCBzbWJhX2lkeCk7IAkJ
Ly9zZWxlemlvbm8gaWwgcmVnaXN0cm8gMHgyYworCXNtYmFfZW5fbG8gPSBpbmJfcChzbWJhX2lk
eCArIDEpOwkvL2xlZ2dvIGlsIGRhdG8gTCBkZWwgcmVnaXN0cm8gMHgyYworCW91dGJfcChzbWJf
ZW4gKyAxLCBzbWJhX2lkeCk7CQkvL3NlbGV6aW9ubyBpbCByZWdpc3RybyAweDJjICsgMQorCXNt
YmFfZW5faGkgPSBpbmJfcChzbWJhX2lkeCArIDEpOwkvL2xlZ2dvIGlsIGRhdG8gSCBkZWwgcmVn
aXN0cm8gMHgyYworCisJb3V0Yl9wKHNtYl9lbiwgc21iYV9pZHgpOyAJCS8vc2VsZXppb25vIGls
IHJlZ2lzdHJvIDB4MmMKKwlvdXRiX3Aoc21iYV9lbl9sbyAmIDB4RjkgLCBzbWJhX2lkeCArIDEp
OyAvL3NlbGV6aW9ubyBsYSBwb3J0YSAwIDAwIDAKKwlvdXRiX3Aoc21iX2VuICsgMSwgc21iYV9p
ZHgpOwkJLy9zZWxlemlvbm8gaWwgcmVnaXN0cm8gMHgyYyArIDEKKwlvdXRiX3Aoc21iYV9lbl9o
aSwgc21iYV9pZHggKyAxKTsKKworCW91dGJfcChzbWJfZW4sIHNtYmFfaWR4KTsgCQkvL3NlbGV6
aW9ubyBpbCByZWdpc3RybyAweDJjCisJc21iYV9lbl9sbyA9IGluYl9wKHNtYmFfaWR4ICsgMSk7
CS8vbGVnZ28gaWwgZGF0byBMIGRlbCByZWdpc3RybyAweDJjCisJb3V0Yl9wKHNtYl9lbiArIDEs
IHNtYmFfaWR4KTsJCS8vc2VsZXppb25vIGlsIHJlZ2lzdHJvIDB4MmMgKyAxCisJc21iYV9lbl9o
aSA9IGluYl9wKHNtYmFfaWR4ICsgMSk7CS8vbGVnZ28gaWwgZGF0byBIIGRlbCByZWdpc3RybyAw
eDJjCisKKwogCXJlbGVhc2VfcmVnaW9uKHNtYmFfaWR4LCAyKTsKIAogCWlmICgoc21iYV9lbl9s
byAmIDEpID09IDApIHsKQEAgLTI1OCw2ICsyNzEsOCBAQAogCQlyZXR1cm4gLUVOT0RFVjsKIAl9
CiAKKwlkZXZfaW5mbygmUElJWDRfZGV2LT5kZXYsIlNlbGVjdGVkIERlZmF1bHQgU21idXMgUG9y
dCAweCV4IiwgKHNtYmFfZW5fbG8gJiAweDYpID4+IDEpOworCiAJcGlpeDRfc21iYSA9ICgoc21i
YV9lbl9oaSA8PCA4KSB8IHNtYmFfZW5fbG8pICYgMHhmZmUwOwogCWlmIChhY3BpX2NoZWNrX3Jl
Z2lvbihwaWl4NF9zbWJhLCBTTUJJT1NJWkUsIHBpaXg0X2RyaXZlci5uYW1lKSkKIAkJcmV0dXJu
IC1FTk9ERVY7CkBAIC00NjYsNyArNDgxLDcgQEAKIAkuZnVuY3Rpb25hbGl0eQk9IHBpaXg0X2Z1
bmMsCiB9OwogCi1zdGF0aWMgc3RydWN0IGkyY19hZGFwdGVyIHBpaXg0X2FkYXB0ZXIgPSB7Citz
dHJ1Y3QgaTJjX2FkYXB0ZXIgcGlpeDRfYWRhcHRlciA9IHsKIAkub3duZXIJCT0gVEhJU19NT0RV
TEUsCiAJLmNsYXNzCQk9IEkyQ19DTEFTU19IV01PTiB8IEkyQ19DTEFTU19TUEQsCiAJLmFsZ28J
CT0gJnNtYnVzX2FsZ29yaXRobSwKZGlmZiAtdSAtTiAtciAyLjYuMzIub3JpZy9pMmMtcGlpeDQt
bjM2bC5jIDIuNi4zMi9pMmMtcGlpeDQtbjM2bC5jCi0tLSAyLjYuMzIub3JpZy9pMmMtcGlpeDQt
bjM2bC5jCTE5NzAtMDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyAyLjYuMzIvaTJj
LXBpaXg0LW4zNmwuYwkyMDExLTExLTE2IDE2OjAyOjAxLjAwMDAwMDAwMCArMDEwMApAQCAtMCww
ICsxLDI0NyBAQAorLyoKKyAqIGkyYy1waWl4NC1uMzZsLmMgLSBpMmMtcGlpeDQgZXh0cmFzIGZv
ciB0aGUgSFAgcHJvbGlhbnQgbWljcm9zZXJ2ZXIgbjM2bCBtb3RoZXJib2FyZAorICoKKyAqIENv
cHlyaWdodCAoQykgMjAwNCwgMjAwOCBKZWFuIERlbHZhcmUgPGtoYWxpQGxpbnV4LWZyLm9yZz4K
KyAqIENvcHlyaWdodCAoQykgMjAxMSAgRWRkaSBEZSBQaWVyaSA8ZWRkaUBkZXBpZXJpLm5ldD4K
KyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1
dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqIHRoZSBGcmVlIFNvZnR3YXJl
IEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAoYXQg
eW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBk
aXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICogYnV0IFdJ
VEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YK
KyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4g
IFNlZSB0aGUKKyAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMu
CisgKgorICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UKKyAqIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdy
aXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCisgKiBGb3VuZGF0aW9uLCBJbmMuLCA2NzUgTWFzcyBB
dmUsIENhbWJyaWRnZSwgTUEgMDIxMzksIFVTQS4KKyAqLworIAorLyoKKyAqIFdlIHNlbGVjdCB0
aGUgY2hhbm5lbHMgYnkgc2VuZGluZyBjb21tYW5kcyB0byB0aGUgc2I4MDAgc291dGhidXMKKyAq
IHRoZSBzZWxlY3Rpb24gYml0CisgKiBodHRwOi8vc3VwcG9ydC5hbWQuY29tL3VzL0VtYmVkZGVk
X1RlY2hEb2NzLzQ1NDgyLnBkZgorICogIFNtYnVzMEVuIC0gUlcg4oCTIDE2IGJpdHMgLSBbUE1f
UmVnOiAyQ2hdCisgKiAgRmllbGQgTmFtZSBCaXRzIERlZmF1bHQgRGVzY3JpcHRpb24KKyAqICBT
bUJ1czBFbiAwIDBiIFNldCB0byAxIHRvIGVuYWJsZSBTTUJVUzAgZnVuY3Rpb24gYW5kIGRlY29k
aW5nLgorICogIFNtQnVzMFNlbCAyOjEgMDBiIFNtQnVzIHBvcnQgc2VsZWN0aW9uIHdoZW4gUE1f
UmVnIDJGaCBiaXQgMCBpcyBzZXQgdG8gMAorICogIDAwOiBQb3J0IDAKKyAqICAwMTogUG9ydCAy
CisgKiAgMTA6IFBvcnQgMworICogIDExOiBQb3J0IDQKKyAqLworCisjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CisjaW5jbHVkZSA8bGludXgvc2xh
Yi5oPgorI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9pMmMuaD4KKyNp
bmNsdWRlIDxsaW51eC9tdXRleC5oPgorI2luY2x1ZGUgPGFzbS9pby5oPgorCitleHRlcm4gc3Ry
dWN0IGkyY19hZGFwdGVyIHBpaXg0X2FkYXB0ZXI7CisKK3N0YXRpYyBzdHJ1Y3QgaTJjX2FkYXB0
ZXIgKm4zNmxfYWRhcHRlcjsKK3N0YXRpYyBzdHJ1Y3QgaTJjX2FsZ29yaXRobSAqbjM2bF9hbGdv
OworCisvKiBXcmFwcGVyIGFjY2VzcyBmdW5jdGlvbnMgZm9yIG11bHRpcGxleGVkIFNNQnVzICov
CitzdGF0aWMgREVGSU5FX01VVEVYKHBpaXg0X2xvY2spOworCisvKiBXZSByZW1lbWJlciB0aGUg
bGFzdCB1c2VkIGNoYW5uZWxzIGNvbWJpbmF0aW9uIHNvIGFzIHRvIG9ubHkgc3dpdGNoCisgICBj
aGFubmVscyB3aGVuIGl0IGlzIHJlYWxseSBuZWVkZWQuIFRoaXMgZ3JlYXRseSByZWR1Y2VzIHRo
ZSBTTUJ1cworICAgb3ZlcmhlYWQsIGJ1dCBhbHNvIGFzc3VtZXMgdGhhdCBub2JvZHkgd2lsbCBi
ZSB3cml0aW5nIHRvIHRoZSBQQ0E5NTU2CisgICBpbiBvdXIgYmFjay4gKi8KK3N0YXRpYyB1OCBs
YXN0X2NoYW5uZWxzOworCitzdGF0aWMgaW5saW5lIHMzMiBwaWl4NF9hY2Nlc3NfY2hhbm5lbChz
dHJ1Y3QgaTJjX2FkYXB0ZXIgKiBhZGFwLCB1MTYgYWRkciwKKwkJCQkJdW5zaWduZWQgc2hvcnQg
ZmxhZ3MsIGNoYXIgcmVhZF93cml0ZSwKKwkJCQkJdTggY29tbWFuZCwgaW50IHNpemUsCisJCQkJ
CXVuaW9uIGkyY19zbWJ1c19kYXRhICogZGF0YSwKKwkJCQkJdTggY2hhbm5lbHMpCit7CisJaW50
IGVycm9yOworCXVuc2lnbmVkIHNob3J0IHNtYmFfaWR4ID0gMHhjZDY7CisJdTggc21iYV9lbl9s
bywgc21iYV9lbl9oaSwgc21iX2VuID0gMHgyYzsKKworCW11dGV4X2xvY2soJnBpaXg0X2xvY2sp
OworCisJaWYgKGxhc3RfY2hhbm5lbHMgIT0gY2hhbm5lbHMpIHsKKwkJdW5pb24gaTJjX3NtYnVz
X2RhdGEgbXBseGRhdGE7CisJCW1wbHhkYXRhLmJ5dGUgPSBjaGFubmVsczsKKworCQkvKiBEZXRl
cm1pbmUgdGhlIGFkZHJlc3Mgb2YgdGhlIFNNQnVzIGFyZWFzICovCisJCWlmICghcmVxdWVzdF9y
ZWdpb24oc21iYV9pZHgsIDIsICJzbWJhX2lkeCIpKSB7CisJCQlkZXZfZXJyKCZwaWl4NF9hZGFw
dGVyLmRldiwgIlNNQnVzIGJhc2UgYWRkcmVzcyBpbmRleCByZWdpb24gIgorCQkJCSIweCV4IGFs
cmVhZHkgaW4gdXNlIVxuIiwgc21iYV9pZHgpOworCQkJcmV0dXJuIC1FQlVTWTsKKwkJfQorCisJ
CW91dGJfcChzbWJfZW4sIHNtYmFfaWR4KTsgCQkvL3NlbGV6aW9ubyBpbCByZWdpc3RybyAweDJj
CisJCXNtYmFfZW5fbG8gPSBpbmJfcChzbWJhX2lkeCArIDEpOwkvL2xlZ2dvIGlsIGRhdG8gTCBk
ZWwgcmVnaXN0cm8gMHgyYworCQlvdXRiX3Aoc21iX2VuICsgMSwgc21iYV9pZHgpOwkJLy9zZWxl
emlvbm8gaWwgcmVnaXN0cm8gMHgyYyArIDEKKwkJc21iYV9lbl9oaSA9IGluYl9wKHNtYmFfaWR4
ICsgMSk7CS8vbGVnZ28gaWwgZGF0byBIIGRlbCByZWdpc3RybyAweDJjCisJCisJCW1zbGVlcCg1
MCk7CisJCW91dGJfcChzbWJfZW4sIHNtYmFfaWR4KTsgCQkvL3NlbGV6aW9ubyBpbCByZWdpc3Ry
byAweDJjCisJCW91dGJfcCgoc21iYV9lbl9sbyAmIDB4RjkgKSsgKCBjaGFubmVscyA8PCAxKSAs
IHNtYmFfaWR4ICsgMSk7IC8vc2VsZXppb25vIGxhIHBvcnRhIDAgMDAgMAorCQlvdXRiX3Aoc21i
X2VuICsgMSwgc21iYV9pZHgpOwkJLy9zZWxlemlvbm8gaWwgcmVnaXN0cm8gMHgyYyArIDEKKwkJ
b3V0Yl9wKHNtYmFfZW5faGksIHNtYmFfaWR4ICsgMSk7CisKKwkJbXNsZWVwKDUwKTsKKworCQly
ZWxlYXNlX3JlZ2lvbihzbWJhX2lkeCwgMik7CisKKwkJZGV2X2luZm8oJnBpaXg0X2FkYXB0ZXIu
ZGV2LCJTZWxlY3RlZCBTbWJ1cyBQb3J0IDB4JXgiLCAoc21iYV9lbl9sbyAmIDB4NikgPj4gMSk7
CisKKwkJbGFzdF9jaGFubmVscyA9IGNoYW5uZWxzOworCisJfQorCQorCWVycm9yID0gcGlpeDRf
YWRhcHRlci5hbGdvLT5zbWJ1c194ZmVyKGFkYXAsIGFkZHIsIGZsYWdzLCByZWFkX3dyaXRlLAor
CQkJCQkgICAgICBjb21tYW5kLCBzaXplLCBkYXRhKTsKKworCisJbXV0ZXhfdW5sb2NrKCZwaWl4
NF9sb2NrKTsKKwlyZXR1cm4gZXJyb3I7Cit9CisKK3N0YXRpYyBzMzIgcGlpeDRfYWNjZXNzX3Zp
cnQwKHN0cnVjdCBpMmNfYWRhcHRlciAqIGFkYXAsIHUxNiBhZGRyLAorCQkJICAgICAgIHVuc2ln
bmVkIHNob3J0IGZsYWdzLCBjaGFyIHJlYWRfd3JpdGUsCisJCQkgICAgICAgdTggY29tbWFuZCwg
aW50IHNpemUsCisJCQkgICAgICAgdW5pb24gaTJjX3NtYnVzX2RhdGEgKiBkYXRhKQoreworCXJl
dHVybiBwaWl4NF9hY2Nlc3NfY2hhbm5lbChhZGFwLCBhZGRyLCBmbGFncywgcmVhZF93cml0ZSwg
Y29tbWFuZCwKKwkJCQkgICAgIHNpemUsIGRhdGEsIDApOworfQorCitzdGF0aWMgczMyIHBpaXg0
X2FjY2Vzc192aXJ0MShzdHJ1Y3QgaTJjX2FkYXB0ZXIgKiBhZGFwLCB1MTYgYWRkciwKKwkJCSAg
ICAgICB1bnNpZ25lZCBzaG9ydCBmbGFncywgY2hhciByZWFkX3dyaXRlLAorCQkJICAgICAgIHU4
IGNvbW1hbmQsIGludCBzaXplLAorCQkJICAgICAgIHVuaW9uIGkyY19zbWJ1c19kYXRhICogZGF0
YSkKK3sKKwlyZXR1cm4gcGlpeDRfYWNjZXNzX2NoYW5uZWwoYWRhcCwgYWRkciwgZmxhZ3MsIHJl
YWRfd3JpdGUsIGNvbW1hbmQsCisJCQkJICAgICBzaXplLCBkYXRhLCAxKTsKK30KKworc3RhdGlj
IHMzMiBwaWl4NF9hY2Nlc3NfdmlydDIoc3RydWN0IGkyY19hZGFwdGVyICogYWRhcCwgdTE2IGFk
ZHIsCisJCQkgICAgICAgdW5zaWduZWQgc2hvcnQgZmxhZ3MsIGNoYXIgcmVhZF93cml0ZSwKKwkJ
CSAgICAgICB1OCBjb21tYW5kLCBpbnQgc2l6ZSwKKwkJCSAgICAgICB1bmlvbiBpMmNfc21idXNf
ZGF0YSAqIGRhdGEpCit7CisJcmV0dXJuIHBpaXg0X2FjY2Vzc19jaGFubmVsKGFkYXAsIGFkZHIs
IGZsYWdzLCByZWFkX3dyaXRlLCBjb21tYW5kLAorCQkJCSAgICAgc2l6ZSwgZGF0YSwgMik7Cit9
CisKK3N0YXRpYyBzMzIgcGlpeDRfYWNjZXNzX3ZpcnQzKHN0cnVjdCBpMmNfYWRhcHRlciAqIGFk
YXAsIHUxNiBhZGRyLAorCQkJICAgICAgIHVuc2lnbmVkIHNob3J0IGZsYWdzLCBjaGFyIHJlYWRf
d3JpdGUsCisJCQkgICAgICAgdTggY29tbWFuZCwgaW50IHNpemUsCisJCQkgICAgICAgdW5pb24g
aTJjX3NtYnVzX2RhdGEgKiBkYXRhKQoreworCXJldHVybiBwaWl4NF9hY2Nlc3NfY2hhbm5lbChh
ZGFwLCBhZGRyLCBmbGFncywgcmVhZF93cml0ZSwgY29tbWFuZCwKKwkJCQkgICAgIHNpemUsIGRh
dGEsIDMpOworfQorCitzdGF0aWMgaW50IF9faW5pdCBwaWl4NF9uMzZsX2luaXQodm9pZCkKK3sK
KwlpbnQgaSwgZXJyb3I7CisKKwlpZiAoIXBpaXg0X2FkYXB0ZXIuZGV2LnBhcmVudCkKKwkJcmV0
dXJuIC1FTk9ERVY7CisKKwlwcmludGsoS0VSTl9JTkZPICJDb25maWd1cmUgdGhlIEFNRCBTQjgw
MCBNdWx0aXBsZXhlclxuIik7CisKKwkvKiBVbnJlZ2lzdGVyIHBoeXNpY2FsIGJ1cyAqLworCWVy
cm9yID0gaTJjX2RlbF9hZGFwdGVyKCZwaWl4NF9hZGFwdGVyKTsKKwlpZiAoZXJyb3IpIHsKKwkJ
ZGV2X2VycigmcGlpeDRfYWRhcHRlci5kZXYsICJQaHlzaWNhbCBidXMgcmVtb3ZhbCBmYWlsZWRc
biIpOworCQlnb3RvIEVSUk9SMDsKKwl9CisKKwlwcmludGsoS0VSTl9JTkZPICJFbmFibGluZyBT
TUJ1cyBtdWx0aXBsZXhpbmcgZm9yIEhwIFByb2xpYW50IE1pY3Jvc2VydmVyIE4zNmxcbiIpOwor
CS8qIERlZmluZSB0aGUgNCB2aXJ0dWFsIGFkYXB0ZXJzIGFuZCBhbGdvcml0aG1zIHN0cnVjdHVy
ZXMgKi8KKwlpZiAoIShuMzZsX2FkYXB0ZXIgPSBremFsbG9jKDUgKiBzaXplb2Yoc3RydWN0IGky
Y19hZGFwdGVyKSwKKwkJCQkgICAgICBHRlBfS0VSTkVMKSkpIHsKKwkJZXJyb3IgPSAtRU5PTUVN
OworCQlnb3RvIEVSUk9SMTsKKwl9CisJaWYgKCEobjM2bF9hbGdvID0ga3phbGxvYyg1ICogc2l6
ZW9mKHN0cnVjdCBpMmNfYWxnb3JpdGhtKSwKKwkJCQkgICBHRlBfS0VSTkVMKSkpIHsKKwkJZXJy
b3IgPSAtRU5PTUVNOworCQlnb3RvIEVSUk9SMjsKKwl9CisKKwkvKiBGaWxsIGluIHRoZSBuZXcg
c3RydWN0dXJlcyAqLworCW4zNmxfYWxnb1swXSA9ICoocGlpeDRfYWRhcHRlci5hbGdvKTsKKwlu
MzZsX2FsZ29bMF0uc21idXNfeGZlciA9IHBpaXg0X2FjY2Vzc192aXJ0MDsKKwluMzZsX2FkYXB0
ZXJbMF0gPSBwaWl4NF9hZGFwdGVyOworCXNucHJpbnRmKG4zNmxfYWRhcHRlclswXS5uYW1lLCBz
aXplb2YobjM2bF9hZGFwdGVyWzBdLm5hbWUpLAorCQkgIlNNQnVzIHBpaXg0IGFkYXB0ZXIgKFNE
QTApIik7CisJbjM2bF9hZGFwdGVyWzBdLmFsZ28gPSBuMzZsX2FsZ287CisJbjM2bF9hZGFwdGVy
WzBdLmRldi5wYXJlbnQgPSBwaWl4NF9hZGFwdGVyLmRldi5wYXJlbnQ7CisJZm9yIChpID0gMTsg
aSA8IDQ7IGkrKykgeworCQluMzZsX2FsZ29baV0gPSAqKHBpaXg0X2FkYXB0ZXIuYWxnbyk7CisJ
CW4zNmxfYWRhcHRlcltpXSA9IHBpaXg0X2FkYXB0ZXI7CisJCXNucHJpbnRmKG4zNmxfYWRhcHRl
cltpXS5uYW1lLCBzaXplb2YobjM2bF9hZGFwdGVyW2ldLm5hbWUpLAorCQkJICJTTUJ1cyBwaWl4
NCBhZGFwdGVyIChTREElZCkiLCBpICsgMSk7CisJCW4zNmxfYWRhcHRlcltpXS5hbGdvID0gbjM2
bF9hbGdvK2k7CisJCW4zNmxfYWRhcHRlcltpXS5kZXYucGFyZW50ID0gcGlpeDRfYWRhcHRlci5k
ZXYucGFyZW50OworCX0KKwluMzZsX2FsZ29bMV0uc21idXNfeGZlciA9IHBpaXg0X2FjY2Vzc192
aXJ0MTsKKwluMzZsX2FsZ29bMl0uc21idXNfeGZlciA9IHBpaXg0X2FjY2Vzc192aXJ0MjsKKwlu
MzZsX2FsZ29bM10uc21idXNfeGZlciA9IHBpaXg0X2FjY2Vzc192aXJ0MzsKKworCS8qIFJlZ2lz
dGVyIHZpcnR1YWwgYWRhcHRlcnMgKi8KKwlmb3IgKGkgPSAwOyBpIDwgNDsgaSsrKSB7CisJCWVy
cm9yID0gaTJjX2FkZF9hZGFwdGVyKG4zNmxfYWRhcHRlcitpKTsKKwkJaWYgKGVycm9yKSB7CisJ
CQlwcmludGsoS0VSTl9FUlIgImkyYy1waWl4NC1uMzZsOiAiCisJCQkgICAgICAgIlZpcnR1YWwg
YWRhcHRlciAlZCByZWdpc3RyYXRpb24gIgorCQkJICAgICAgICJmYWlsZWQsIG1vZHVsZSBub3Qg
aW5zZXJ0ZWRcbiIsIGkpOworCQkJZm9yIChpLS07IGkgPj0gMDsgaS0tKQorCQkJCWkyY19kZWxf
YWRhcHRlcihuMzZsX2FkYXB0ZXIraSk7CisJCQlnb3RvIEVSUk9SMzsKKwkJfQorCX0KKworCXJl
dHVybiAwOworCitFUlJPUjM6CisJa2ZyZWUobjM2bF9hbGdvKTsKKwluMzZsX2FsZ28gPSBOVUxM
OworRVJST1IyOgorCWtmcmVlKG4zNmxfYWRhcHRlcik7CisJbjM2bF9hZGFwdGVyID0gTlVMTDsK
K0VSUk9SMToKKwkvKiBSZXN0b3JlIHBoeXNpY2FsIGJ1cyAqLworCWkyY19hZGRfYWRhcHRlcigm
cGlpeDRfYWRhcHRlcik7CitFUlJPUjA6CisJcmV0dXJuIGVycm9yOworfQorCitzdGF0aWMgdm9p
ZCBfX2V4aXQgcGlpeDRfbjM2bF9leGl0KHZvaWQpCit7CisJaWYgKG4zNmxfYWRhcHRlcikgewor
CQlpbnQgaTsKKworCQlmb3IgKGkgPSAwOyBpIDwgNTsgaSsrKQorCQkJaTJjX2RlbF9hZGFwdGVy
KG4zNmxfYWRhcHRlcitpKTsKKwkJa2ZyZWUobjM2bF9hZGFwdGVyKTsKKwkJbjM2bF9hZGFwdGVy
ID0gTlVMTDsKKwl9CisJa2ZyZWUobjM2bF9hbGdvKTsKKwluMzZsX2FsZ28gPSBOVUxMOworCisJ
LyogUmVzdG9yZSBwaHlzaWNhbCBidXMgKi8KKwlpZiAoaTJjX2FkZF9hZGFwdGVyKCZwaWl4NF9h
ZGFwdGVyKSkKKwkJcHJpbnRrKEtFUk5fRVJSICJpMmMtcGlpeDQtbjM2bDogIgorCQkgICAgICAg
IlBoeXNpY2FsIGJ1cyByZXN0b3JhdGlvbiBmYWlsZWRcbiIpOworfQorCitNT0RVTEVfQVVUSE9S
KCJFZGRpIERlIFBpZXJpIDxlZGRpQGRlcGllcmkubmV0Iik7CitNT0RVTEVfREVTQ1JJUFRJT04o
Im4zNmwgU01CdXMgbXVsdGlwbGV4aW5nIik7CitNT0RVTEVfTElDRU5TRSgiR1BMIik7CisKK21v
ZHVsZV9pbml0KHBpaXg0X24zNmxfaW5pdCk7Cittb2R1bGVfZXhpdChwaWl4NF9uMzZsX2V4aXQp
Owo=
--f46d04428cb8f6dd2204b1dc74ab
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--f46d04428cb8f6dd2204b1dc74ab--
