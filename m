From: Lu Zhihe <tombowfly@gmail.com>
Date: Tue, 13 Oct 2009 13:43:04 +0000
Subject: [lm-sensors] Fwd: [Module] hwmon: GM/GME965 GM45 and more chips IGP
Message-Id: <73511e6c0910130643s5a72db45q9f6995a7aa93ace9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

---------- Forwarded message ----------
From: Lu Zhihe <tombowfly@gmail.com>
Date: 2009/10/13
Subject: Re: [lm-sensors] [Module] hwmon: GM/GME965 GM45 and more
chips IGP thermal report
To: Jean Delvare <khali@linux-fr.org>


Hi Jean,

2009/10/10 Jean Delvare <khali@linux-fr.org>:
> Hi Lu,
>> From: Lu Zhihe <tombowfly@gmail.com>
>>
>> Subject: [PATCH] sensors-detect add gm965temp detected for lm-sensors
>>
>> Signed-off-by: Lu Zhihe <tombowfly@gmail.com>
>>
>> ---
>>
>> --- prog/detect/sensors-detect.orig =A0 2009-10-09 21:43:12.000000000 +0=
000
>> +++ prog/detect/sensors-detect =A0 =A0 =A0 =A02009-10-09 21:50:13.000000=
000 +0000
>> @@ -147,6 +147,16 @@ $revision =3D~ s/ \([^()]*\)//;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 procid =A0=3D> "Intel SCH",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 driver =A0=3D> "i2c-isch",
>> =A0 =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 vendid =A0=3D> 0x8086,
>> + =A0 =A0 =A0 =A0 =A0 =A0 devid =A0 =3D> 0x2a00,
>> + =A0 =A0 =A0 =A0 =A0 =A0 procid =A0=3D> "Intel GM965",
>> + =A0 =A0 =A0 =A0 =A0 =A0 driver =A0=3D> "gm965temp",
>> + =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 vendid =A0=3D> 0x8086,
>> + =A0 =A0 =A0 =A0 =A0 =A0 devid =A0 =3D> 0x2a10,
>> + =A0 =A0 =A0 =A0 =A0 =A0 procid =A0=3D> "Intel GME965",
>> + =A0 =A0 =A0 =A0 =A0 =A0 driver =A0=3D> "gm965temp",
>> + =A0 =A0 }, {
>
> This part is wrong: these chips are not I2C/SMBus masters!

=A0 =A0 Yes, I miss the I2C/SMBus Comment, and make a mistake. Fix it on ne=
w patch.

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 vendid =A0=3D> 0x1106,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 devid =A0 =3D> 0x3040,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 procid =A0=3D> "VIA Technologies VT82C586B A=
pollo ACPI",
>> @@ -1860,6 +1870,10 @@ use vars qw(@cpu_ids);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 driver =3D> "i5k_amb",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 detect =3D> \&intel_amb_detect,
>> =A0 =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 name =3D> "Intel GM/GME965 thermal sensor",
>> + =A0 =A0 =A0 =A0 =A0 =A0 driver =3D> "gm965temp",
>> + =A0 =A0 =A0 =A0 =A0 =A0 detect =3D> \&intel_gm965_detect,
>> + =A0 =A0 }, {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D> "VIA C7 thermal and voltage sensor=
s",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 driver =3D> "c7temp",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 detect =3D> \&c7temp_detect,
>> @@ -5301,6 +5315,15 @@ sub intel_amb_detect
>> =A0 =A0 =A0 return;
>> =A0}
>>
>> +sub intel_gm965_detect
>> +{
>> + =A0 =A0 =A0 =A0if ((exists $pci_list{'8086:2a00'}) || =A0# Intel GM965
>> + =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:2a10'})) { =A0# Intel G=
ME965
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 9;
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0return;
>> +}
>> +
>
> This part is correct, however we want to add all the other chips
> supported by your driver, right? Please send an updated patch with all
> the chips. It's OK to have a single entry in @cpu_ids if you want, but
> all PCI IDs must be listed in intel_gm965_detect().

=A0 I am not sure gm965temp could work for all the gm965+ =A0chipsets,
while, I just add them in this patch.
Only GM965/GME965 chipsets are tested and works. GM45 tested on Lenovo
T400 does't work, it always report 0xFF on the TR1 register. =A0Tobias
got some simliar tested result, while, it may be work on other
machine. Many Desktop chipsets G3x and G4x =A0don't test at all.

>
> Thanks,
> --
> Jean Delvare
>

From: Lu Zhihe <tombowfly@gmail.com>
Subject: [PATCH] sensors-detect add gm965temp detected for lm-sensors 3.1.1
Signed-off-by: Lu Zhihe <tombowfly@gmail.com>

---

--- lm-sensors.svn.orig/prog/detect/sensors-detect =A0 =A0 =A02009-10-09
21:43:12.000000000 +0000
+++ lm-sensors.svn/prog/detect/sensors-detect =A0 2009-10-13
21:23:33.000000000 +0000
@@ -1860,6 +1860,10 @@ use vars qw(@cpu_ids);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0driver =3D> "i5k_amb",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detect =3D> \&intel_amb_detect,
=A0 =A0 =A0 =A0}, {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 name =3D> "Intel GM/GME965 thermal sensor",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 driver =3D> "gm965temp",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 detect =3D> \&intel_gm965_detect,
+ =A0 =A0 =A0 }, {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name =3D> "VIA C7 thermal and voltage sensor=
s",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0driver =3D> "c7temp",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detect =3D> \&c7temp_detect,
@@ -5301,6 +5305,24 @@ sub intel_amb_detect
=A0 =A0 =A0 =A0return;
=A0}

+sub intel_gm965_detect
+{
+ =A0 =A0 =A0 =A0if ((exists $pci_list{'8086:2a00'}) || =A0# Intel GM965
+ =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:2a10'}) || =A0# Intel GME9=
65
+ =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:2a40'}) || =A0# Intel GM45=
, Follow
up chipsets are untested
+ =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:29b0'}) || =A0# Intel Q35
+ =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:29c0'}) || =A0# Intel G33
+ =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:29d0'}) || =A0# Intel Q33
+ =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:2e10'}) || =A0# Intel Q45
+ =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:2e20'}) || =A0# Intel G45
+ =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:2e30'}) || =A0# Intel G41
+ =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:2e40'}) || =A0# Intel B43_=
BASE
+ =A0 =A0 =A0 =A0 =A0 =A0(exists $pci_list{'8086:2e90'})) { =A0# Intel B43_=
SOFT_SKU
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 9;
+ =A0 =A0 =A0 =A0}
+ =A0 =A0 =A0 =A0return;
+}
+
=A0sub coretemp_detect
=A0{
=A0 =A0 =A0 =A0my $probecpu;

---
Thx

Lu Zhihe



--=20
Thx

Lu Zhihe

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
