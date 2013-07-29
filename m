From: Harald Judt <h.judt@gmx.at>
Date: Mon, 29 Jul 2013 02:24:53 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <51F5D275.7070102@gmx.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060302060705010308080502"
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302060705010308080502
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Am 29.07.2013 00:28, schrieb Guenter Roeck:
> On 07/28/2013 01:43 PM, Harald Judt wrote:
>> Hi,
>>
>> Am 22.10.2012 23:40, schrieb Guenter Roeck:
>>> On Mon, Oct 22, 2012 at 05:03:45PM +0200, Harald Judt wrote:
>>>> Hi,
>>>>
>>>> After resuming from suspend or hibernation, the Vbat value is
>>>> reported to be 0.0. Before that, it reported the correct value.
>>>> Min/max values are wrong too.
>>>>
>>>> Linux-3.6.2, ASRock Z77 Extreme4 BIOS v1.80.
>>>>
>>>> Before suspend:
>>>> nct6776-isa-0290
>>>> Adapter: ISA adapter
>>>> Vcore:         +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>>> in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>> AVCC:          +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>>> +3.3V:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>>> in4:           +1.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>> in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>> 3VSB:          +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>>> Vbat:          +3.31 V  (min =3D  +2.70 V, max =3D  +3.63 V)
>>>> fan1:            0 RPM  (min =3D    0 RPM)  ALARM
>>>> fan2:         1289 RPM  (min =3D    0 RPM)  ALARM
>>>> fan3:          724 RPM  (min =3D    0 RPM)  ALARM
>>>> fan4:          661 RPM  (min =3D    0 RPM)  ALARM
>>>> fan5:         1076 RPM  (min =3D    0 RPM)  ALARM
>>>> SYSTIN:        +37.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  AL=
ARM
>>>> sensor =3D thermistor
>>>> CPUTIN:        +28.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>>> thermistor
>>>> AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>>> thermistor
>>>> PECI Agent 0:  +32.0=B0C
>>>> cpu0_vid:     +0.000 V
>>>> intrusion0:   ALARM
>>>> intrusion1:   ALARM
>>>>
>>>> After resuming:
>>>> nct6776-isa-0290
>>>> Adapter: ISA adapter
>>>> Vcore:         +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>>> in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>> AVCC:          +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>> +3.3V:         +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>> in4:           +1.03 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>> in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>> 3VSB:          +3.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>> Vbat:          +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
>>>> fan1:            0 RPM  (min =3D    0 RPM)  ALARM
>>>> fan2:         1271 RPM  (min =3D    0 RPM)  ALARM
>>>> fan3:          734 RPM  (min =3D    0 RPM)  ALARM
>>>> fan4:          673 RPM  (min =3D    0 RPM)  ALARM
>>>> fan5:         1093 RPM  (min =3D    0 RPM)  ALARM
>>>> SYSTIN:        +36.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  AL=
ARM
>>>> sensor =3D thermistor
>>>> CPUTIN:        +26.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>>> thermistor
>>>> AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>>> thermistor
>>>> PECI Agent 0:  +30.0=B0C
>>>> cpu0_vid:     +0.000 V
>>>> intrusion0:   ALARM
>>>> intrusion1:   ALARM
>>>>
>>>> Reloading the module helps. Of course, a fresh boot too ;-)
>>>>
>>> The driver doesn't implement suspend/resume support, so it is not very
>>> surprising that the limits get lost - and it looks like vbat monitoring
>>> is disabled by default, so that gets lost as well.
>>>
>>> Someone would have to submit a patch to add suspend/resume support to
>>> the driver ... any takers out there ?
>>>
>>> Thanks,
>>> Guenter
>>
>> A while ago, support for suspend/resume has been added and this issue
>> was fixed and values are now preserved during suspend/resume.
>>
>> 3300fb4f88688029fff8dfb9ec0734f6e4cba3e7 hwmon: (w83627ehf) Force
>> initial bank selection
>> 7e630bb55a52cfaa35011c0ebc2efc96f13e5135 hwmon: (w83627ehf) Add support
>> for suspend
>>
>> But now with kernel 3.11-rc2, I noticed it only works in case of
>> suspend/resume, not hibernate/resume. I'm not sure this worked properly
>> with kernel 3.6.2 with the patch applied, though I think it did, but I
>> don't have that version available for verification at the moment. Of
>> course, I could test if necessary. Perhaps there is more to do for
>> hibernate/resume than for suspend/resume?
>>
> It should not require anything special, and at first glance the code
> seems to be ok. Maybe hibernate (now) results in some secondary changes
> which we don't take into account.
>=20
> It would be great if you can download
>     http://roeck-us.net/linux/bin/superiotool
> and run "sudo ./superiotool -d -e" before hibernation and after resume
> and send me the results.
>=20
> Thanks,
> Guenter

Ok, I've switched to the nct6775 driver, didn't know there was a new one
;-) Unfortunately, the same behaviour. I have installed superiotool-6637
from the gentoo repository, I hope that does the job too. I compiled
nct6775, did modprobe -r w83627ehf, modprobe nct6775.
Sensors output:

Before hibernation:
-------------------------------------------------------------------
nct6776-isa-0290
Adapter: ISA adapter
Vcore:          +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:            +1.82 V  (min =3D  +1.71 V, max =3D  +1.89 V)
AVCC:           +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:          +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:            +1.07 V  (min =3D  +1.00 V, max =3D  +1.50 V)
in5:            +1.68 V  (min =3D  +1.50 V, max =3D  +1.89 V)
in6:            +0.92 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:           +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:           +3.31 V  (min =3D  +2.70 V, max =3D  +3.63 V)
fan1:             0 RPM  (min =3D    0 RPM)
fan2:          1337 RPM  (min =3D    0 RPM)
fan3:           742 RPM  (min =3D    0 RPM)
fan4:           661 RPM  (min =3D    0 RPM)
fan5:          1077 RPM  (min =3D    0 RPM)
SYSTIN:         +42.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM =
 sensor
=3D thermistor
CPUTIN:         +35.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D
thermistor
AUXTIN:         +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D
thermistor
PECI Agent 0:   +37.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
                         (crit =3D +98.0=B0C)
PCH_CHIP_TEMP:   +0.0=B0C
PCH_CPU_TEMP:    +0.0=B0C
PCH_MCH_TEMP:    +0.0=B0C
intrusion0:    ALARM
intrusion1:    OK
-------------------------------------------------------------------

After resuming from hibernation:
-------------------------------------------------------------------
nct6776-isa-0290
Adapter: ISA adapter
Vcore:          +1.24 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:            +1.82 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:           +3.33 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
+3.3V:          +3.33 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in4:            +1.09 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:            +1.67 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in6:            +0.93 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:           +3.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
Vbat:           +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
fan1:             0 RPM  (min =3D    0 RPM)  ALARM
fan2:          1339 RPM  (min =3D    0 RPM)  ALARM
fan3:           744 RPM  (min =3D    0 RPM)  ALARM
fan4:           657 RPM  (min =3D    0 RPM)  ALARM
fan5:          1100 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:         +43.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM =
 sensor
=3D thermistor
CPUTIN:         +37.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D
thermistor
AUXTIN:         +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D
thermistor
PECI Agent 0:   +43.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
                         (crit =3D +98.0=B0C)
PCH_CHIP_TEMP:   +0.0=B0C
PCH_CPU_TEMP:    +0.0=B0C
PCH_MCH_TEMP:    +0.0=B0C
intrusion0:    ALARM
intrusion1:    OK
-------------------------------------------------------------------


modprobe -r nct6775, modprobe nct6775, sensors -s to restore functionality.

Before suspending:
-------------------------------------------------------------------
nct6776-isa-0290
Adapter: ISA adapter
Vcore:          +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:            +1.82 V  (min =3D  +1.71 V, max =3D  +1.89 V)
AVCC:           +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:          +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:            +1.10 V  (min =3D  +1.00 V, max =3D  +1.50 V)
in5:            +1.68 V  (min =3D  +1.50 V, max =3D  +1.89 V)
in6:            +0.94 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:           +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:           +3.33 V  (min =3D  +2.70 V, max =3D  +3.63 V)
fan1:             0 RPM  (min =3D    0 RPM)
fan2:          1345 RPM  (min =3D    0 RPM)
fan3:           731 RPM  (min =3D    0 RPM)
fan4:           655 RPM  (min =3D    0 RPM)
fan5:          1083 RPM  (min =3D    0 RPM)
SYSTIN:         +45.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM =
 sensor
=3D thermistor
CPUTIN:         +36.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D
thermistor
AUXTIN:         +31.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D
thermistor
PECI Agent 0:   +38.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
                         (crit =3D +98.0=B0C)
PCH_CHIP_TEMP:   +0.0=B0C
PCH_CPU_TEMP:    +0.0=B0C
PCH_MCH_TEMP:    +0.0=B0C
intrusion0:    ALARM
intrusion1:    OK
-------------------------------------------------------------------

After resuming from S3:
-------------------------------------------------------------------
nct6776-isa-0290
Adapter: ISA adapter
Vcore:          +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:            +1.82 V  (min =3D  +1.71 V, max =3D  +1.89 V)
AVCC:           +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:          +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:            +1.10 V  (min =3D  +1.00 V, max =3D  +1.50 V)
in5:            +1.67 V  (min =3D  +1.50 V, max =3D  +1.89 V)
in6:            +0.94 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:           +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:           +3.33 V  (min =3D  +2.70 V, max =3D  +3.63 V)
fan1:             0 RPM  (min =3D    0 RPM)
fan2:          1336 RPM  (min =3D    0 RPM)
fan3:           744 RPM  (min =3D    0 RPM)
fan4:           656 RPM  (min =3D    0 RPM)
fan5:          1103 RPM  (min =3D    0 RPM)
SYSTIN:         +45.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM =
 sensor
=3D thermistor
CPUTIN:         +36.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D
thermistor
AUXTIN:         +31.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D
thermistor
PECI Agent 0:   +45.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
                         (crit =3D +98.0=B0C)
PCH_CHIP_TEMP:   +0.0=B0C
PCH_CPU_TEMP:    +0.0=B0C
PCH_MCH_TEMP:    +0.0=B0C
intrusion0:    ALARM
intrusion1:    OK
-------------------------------------------------------------------


Superiotool output is attached.

Note that I can do "sensors -s", but that won't reset/reenable some
values like vbat. The only way to get it back working is rmmod/modprobe.
It seems like the code that runs properly at resume after suspend simply
is not executed after resuming from hibernation. Maybe I should put some
debug output in there to verify...

Harald

--=20
`Experience is the best teacher.'

PGP Key ID: 0xB29C7F8F

--------------060302060705010308080502
Content-Type: text/plain; charset=UTF-8;
 name="01-superiotool-before-hibernate.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="01-superiotool-before-hibernate.out"

superiotool r4.0-2514-gf419483
Found Nuvoton NCT6776F (C) (id=0xc333) at 0x2e
Register dump:
idx 10 11 13 14 16 17 18 19  1a 1b 1c 1d 1e 1f 20 21  22 23 24 25 26 27 28 2a  2b 2c 2d 2e 2f
val ff ff ff ff ff ff ff ff  f8 0e 00 00 ff ff c3 33  ff 00 5c 00 00 d0 00 62  00 80 00 00 01
def ff ff 00 00 ff ff ff ff  f0 78 00 00 ff ff c3 33  ff 00 64 00 MM 00 00 c0  00 81 00 00 MM
LDN 0x00 (FDC)
idx 30 60 61 70 74 f0 f1 f2  f4 f5
val 00 03 f0 06 02 0e 00 ff  00 00
def 01 03 f0 06 02 0e 00 ff  00 00
LDN 0x01 (Parallel Port)
idx 30 60 61 70 74 f0
val 00 03 78 07 04 3f
def 01 03 78 07 04 3f
LDN 0x02 (UART A)
idx 30 60 61 70 f0 f2
val 01 03 f8 04 00 00
def 01 03 f8 04 00 00
LDN 0x03 (UART B, IR)
idx 30 60 61 70 f0 f1 f2
val 00 02 f8 03 00 00 00
def 01 02 f8 03 00 00 00
LDN 0x05 (Keyboard Controller)
idx 30 60 61 62 63 70 72 f0
val 01 00 60 00 64 01 0c 83
def 00 00 00 00 00 00 00 83
LDN 0x06 (CIR)
idx 30 60 61 70 f0 f1 f2 f3
val 00 00 00 00 08 09 32 00
def 00 00 00 00 08 09 32 00
LDN 0x07 (GPIO6, GPIO7, GPIO8, GPIO9)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ec ed ee  f4 f5 f6 f7 f8
val 00 ff f3 00 fb ff ff ff  ff ff ff ff ff 00 ff ff  ff ff ff ff ff
def 03 ff 00 00 00 ef 00 00  00 ff 00 00 00 00 00 00  ff 00 00 00 00
LDN 0x08 (WDT1, GPIO0, GPIO1, GPIOA)
idx 30 60 61 e0 e1 e2 e3 e4  f0 f1 f2 f3 f4 f5 f6 f7
val 00 00 00 ff ff ff ff ff  b0 b1 00 00 00 ff 00 ff
def 02 00 00 ff 00 00 00 ef  ff 00 00 00 00 00 00 00
LDN 0x09 (GPIO2, GPIO3, GPIO4, GPIO5)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ee f0 f1  f2 f4 f5 f6 f7 fe
val b6 ff 2c 00 00 ff ff ff  ff 00 00 ff 00 00 ff 6c  00 ff 00 00 00 00
def 04 df 00 00 00 ff 00 00  00 00 00 00 00 00 ff 00  00 ff 00 00 00 00
LDN 0x0a (ACPI)
idx e0 e1 e2 e3 e4 e5 e6 e7  e9 ee f0 f2 f3 f4 f6 f7  fe
val 01 00 00 01 20 02 4c 00  00 00 20 5c 00 00 00 c0  00
def 01 00 00 00 00 02 1c 00  00 00 00 00 00 00 00 c0  00
LDN 0x0b (Hardware Monitor, Front Panel LED)
idx 30 60 61 62 63 70 e0 e1  e2 f0 f1 f2 f5 f6 f7 f8  f9 fa
val e1 02 90 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
def 00 00 00 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
LDN 0x0d (VID)
idx e0 e1 e2 e3 e4 e5 e6 e9  ee ef f0 f4 f5
val 00 00 00 00 00 00 00 00  88 00 00 00 00
def 00 00 00 00 00 00 00 00  88 00 00 00 00
LDN 0x0e (CIR WAKE-UP)
idx 30 60 61 70
val 00 02 50 00
def 00 00 00 00
LDN 0x0f (GPIO Push-Pull or Open-drain)
idx e0 e1 e2 e3 e4 e5 e6 e7  e8 e9 f0 f1 f2
val ff df ff fe f6 ff ff d3  ff 9f 00 00 00
def ff df ff fe f6 ff ff d3  ff 9f 00 00 00
LDN 0x14 (SVID)
idx e0 e1 e3 e4
val 00 80 00 00
def 00 80 00 00
LDN 0x16 (Deep Sleep)
idx 30 e0 e1 e2
val 68 20 04 05
def 20 20 04 05
LDN 0x17 (GPIOA)
idx e0 e1 e2 e3 e4 e5
val ff ff ff ff 01 ff
def 01 00 00 00 01 00
Bank 0:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 04 ff 04 b1 00 ff ff ff ff ff ff ff ff ff ff ff 
01: 04 ff 00 00 00 00 ff ff 40 00 00 00 00 86 00 00 
02: 78 e6 d1 d1 8a d2 77 2e ff ff ff da 00 ec d6 e3 
03: ba e3 ba bc 7d ec bc 00 00 00 00 ff ff ff ff ff 
04: 03 00 50 ff ff 00 3f ff 2d ff ff ff 18 05 00 a3 
05: ff ff ff ff ff ff ff ff c1 ff ff ff ff 01 00 ff 
06: 30 ff ff ff ff 01 00 ff ff ff ff ff ff ff ff ff 
07: 00 0a 00 2e 00 26 80 1e 80 ff ff ff ff ff ff ff 
08: ff 03 1f 0f ff 3c 3c 3c 00 00 00 00 00 00 00 00 
09: 0a 00 00 00 00 0a 0a 0a 0a aa ef 80 ff 40 46 c4 
0a: 0e 01 00 00 ff 00 00 ff 00 00 80 66 66 06 01 01 
0b: 00 00 00 00 00 00 3e 00 1c 00 00 04 d8 c0 c4 ff 
0c: 01 00 00 00 00 00 00 00 00 1e 02 ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 1:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 01 00 00 0a 0a 01 01 3c ff ff ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 19 23 2d 37 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 7f ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff a4 00 ff ff ff ff ff ff ff 01 ff 
05: 24 80 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 2:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 8c 32 12 0a 0a b1 ff 60 ff b1 ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 28 32 3c 46 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 7f ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff 44 05 ff ff ff ff ff ff ff 02 ff 
05: 1e 80 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 3:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 03 00 00 0a 0a 01 01 3c ff ff ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 19 23 2d 37 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 3c ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff dc 02 ff ff ff ff ff ff ff 03 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 4:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff 
02: ff ff ff 96 64 96 64 e1 96 ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: 3f 00 01 ff ff ff ff ff ff ff ff ff ff ff 04 ff 
05: 00 13 ff ff 00 00 00 ff 00 10 10 10 09 ff ff ff 
06: ff 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 5:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff ff 00 00 00 00 ff ff ff ff ff ff ff 00 00 ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 05 ff 
05: d9 d0 40 ff e3 ba e3 a9 ff ff ff ff ff ff ff ff 
06: 00 00 00 00 00 00 07 00 01 ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 6:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff 01 02 03 01 01 01 ff 00 00 00 2e 2e 2e 00 ff 
03: ff 1f 1f 0f 39 12 3f 1a 26 18 ff 1f ff 1f ff 1f 
04: ff 1f ff 1f 02 02 02 ff ff ff ff ff ff ff 06 ff 
05: 7f 7f 7f 7f 7f 7f 00 a4 05 3c 02 dc 02 95 04 40 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: 7f 7f 50 4b 04 7f 7f 50 4b 04 7f 7f 50 4b 04 ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 7:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff 95 02 10 00 00 00 00 00 62 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 f1 2f f8 80 f8 80 f8 80 01 
02: 26 02 06 00 00 00 ef b4 00 ef 00 00 00 00 00 00 
03: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 07 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

--------------060302060705010308080502
Content-Type: text/plain; charset=UTF-8;
 name="02-superiotool-after-resume-from-hibernate.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="02-superiotool-after-resume-from-hibernate.out"

superiotool r4.0-2514-gf419483
Found Nuvoton NCT6776F (C) (id=0xc333) at 0x2e
Register dump:
idx 10 11 13 14 16 17 18 19  1a 1b 1c 1d 1e 1f 20 21  22 23 24 25 26 27 28 2a  2b 2c 2d 2e 2f
val ff ff ff ff ff ff ff ff  f8 0e 00 00 ff ff c3 33  ff 00 5c 00 00 d0 00 62  00 80 00 00 01
def ff ff 00 00 ff ff ff ff  f0 78 00 00 ff ff c3 33  ff 00 64 00 MM 00 00 c0  00 81 00 00 MM
LDN 0x00 (FDC)
idx 30 60 61 70 74 f0 f1 f2  f4 f5
val 00 03 f0 06 02 0e 00 ff  00 00
def 01 03 f0 06 02 0e 00 ff  00 00
LDN 0x01 (Parallel Port)
idx 30 60 61 70 74 f0
val 00 03 78 07 04 3f
def 01 03 78 07 04 3f
LDN 0x02 (UART A)
idx 30 60 61 70 f0 f2
val 01 03 f8 04 00 00
def 01 03 f8 04 00 00
LDN 0x03 (UART B, IR)
idx 30 60 61 70 f0 f1 f2
val 00 02 f8 03 00 00 00
def 01 02 f8 03 00 00 00
LDN 0x05 (Keyboard Controller)
idx 30 60 61 62 63 70 72 f0
val 01 00 60 00 64 01 0c 83
def 00 00 00 00 00 00 00 83
LDN 0x06 (CIR)
idx 30 60 61 70 f0 f1 f2 f3
val 00 00 00 00 08 09 32 00
def 00 00 00 00 08 09 32 00
LDN 0x07 (GPIO6, GPIO7, GPIO8, GPIO9)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ec ed ee  f4 f5 f6 f7 f8
val 00 ff f7 00 ff ff ff ff  ff ff ff ff ff 00 ff ff  ff ff ff ff ff
def 03 ff 00 00 00 ef 00 00  00 ff 00 00 00 00 00 00  ff 00 00 00 00
LDN 0x08 (WDT1, GPIO0, GPIO1, GPIOA)
idx 30 60 61 e0 e1 e2 e3 e4  f0 f1 f2 f3 f4 f5 f6 f7
val 00 00 00 ff ff ff ff ff  b0 b1 00 b1 00 ff 00 ff
def 02 00 00 ff 00 00 00 ef  ff 00 00 00 00 00 00 00
LDN 0x09 (GPIO2, GPIO3, GPIO4, GPIO5)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ee f0 f1  f2 f4 f5 f6 f7 fe
val b6 ff 2c 00 2c ff ff ff  ff 6c 00 ff 00 00 ff 6c  00 ff 00 00 00 00
def 04 df 00 00 00 ff 00 00  00 00 00 00 00 00 ff 00  00 ff 00 00 00 00
LDN 0x0a (ACPI)
idx e0 e1 e2 e3 e4 e5 e6 e7  e9 ee f0 f2 f3 f4 f6 f7  fe
val 01 00 00 01 20 02 4c 00  00 00 20 5c 00 00 00 c0  00
def 01 00 00 00 00 02 1c 00  00 00 00 00 00 00 00 c0  00
LDN 0x0b (Hardware Monitor, Front Panel LED)
idx 30 60 61 62 63 70 e0 e1  e2 f0 f1 f2 f5 f6 f7 f8  f9 fa
val e1 02 90 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
def 00 00 00 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
LDN 0x0d (VID)
idx e0 e1 e2 e3 e4 e5 e6 e9  ee ef f0 f4 f5
val 00 00 00 00 00 00 00 00  88 00 00 00 00
def 00 00 00 00 00 00 00 00  88 00 00 00 00
LDN 0x0e (CIR WAKE-UP)
idx 30 60 61 70
val 00 00 00 00
def 00 00 00 00
LDN 0x0f (GPIO Push-Pull or Open-drain)
idx e0 e1 e2 e3 e4 e5 e6 e7  e8 e9 f0 f1 f2
val ff df ff fe f6 ff ff d3  ff 9f 00 00 00
def ff df ff fe f6 ff ff d3  ff 9f 00 00 00
LDN 0x14 (SVID)
idx e0 e1 e3 e4
val 00 80 00 00
def 00 80 00 00
LDN 0x16 (Deep Sleep)
idx 30 e0 e1 e2
val 68 20 04 05
def 20 20 04 05
LDN 0x17 (GPIOA)
idx e0 e1 e2 e3 e4 e5
val ff ff ff ff 01 ff
def 01 00 00 00 01 00
Bank 0:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 04 ff 04 b1 00 ff ff ff ff ff ff ff ff ff ff ff 
01: 04 ff 00 00 00 00 ff ff 40 00 00 00 00 87 00 00 
02: 7a e6 d1 d1 8a d2 77 2e ff ff ff da 00 00 00 00 
03: 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff 
04: 03 de 5f ff ff 00 3f ff 2d ff ff ff 18 05 00 a3 
05: ff ff ff ff ff ff ff ff c1 ff ff ff ff 00 00 ff 
06: a2 ff ff ff ff 01 00 ff ff ff ff ff ff ff ff ff 
07: 00 0a 00 2e 00 27 00 1e 80 ff ff ff ff ff ff ff 
08: ff 03 1f 0f ff 3c 3c 3c 00 00 00 00 00 00 00 00 
09: 0a 00 00 00 00 0a 0a 0a 0a aa ef 80 ff 40 46 c4 
0a: 0e 01 00 00 ff 00 00 ff 00 00 80 66 66 06 01 01 
0b: 00 00 00 00 00 00 3e 00 1c 00 00 04 88 40 c4 ff 
0c: 01 00 00 00 00 00 00 00 00 0c 01 ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 1:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 01 00 00 0a 0a 01 01 3c ff ff ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 19 23 2d 37 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 7f ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff a4 00 ff ff ff ff ff ff ff 01 ff 
05: 25 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 2:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 8c 32 12 0a 0a b1 ff 60 ff b1 ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 28 32 3c 46 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 7f ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff 43 05 ff ff ff ff ff ff ff 02 ff 
05: 1e 80 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 3:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 03 00 00 0a 0a 01 01 3c ff ff ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 19 23 2d 37 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 3c ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff dd 02 ff ff ff ff ff ff ff 03 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 4:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff 
02: ff ff ff 96 64 96 64 e1 96 ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: 3f 00 01 ff ff ff ff ff ff ff ff ff ff ff 04 ff 
05: 31 13 ff ff 00 00 00 ff 00 de 1d b1 09 ff ff ff 
06: ff 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 5:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff ff 00 00 00 00 ff ff ff ff ff ff ff 00 00 ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 05 ff 
05: d9 00 00 ff 00 00 00 00 ff ff ff ff ff ff ff ff 
06: 00 00 00 00 00 00 07 01 01 ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 6:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff 01 02 03 01 01 01 ff 00 00 00 2e 2e 2e 00 ff 
03: ff 1f 1f 0a 39 11 40 02 26 16 00 00 00 00 00 00 
04: 00 00 00 00 02 02 02 ff ff ff ff ff ff ff 06 ff 
05: 7f 7f 7f 7f 7f 7f 00 a4 05 43 02 dd 02 92 04 42 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: 7f 7f 50 4b 04 7f 7f 50 4b 04 7f 7f 50 4b 04 ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 7:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff 95 02 10 00 00 00 00 00 62 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 f1 57 f8 80 f8 80 f8 80 01 
02: 27 01 06 00 00 00 ef be 00 ef 00 00 00 00 00 00 
03: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 07 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

--------------060302060705010308080502
Content-Type: text/plain; charset=UTF-8;
 name="03-superiotool-before-suspend.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="03-superiotool-before-suspend.out"

superiotool r4.0-2514-gf419483
Found Nuvoton NCT6776F (C) (id=0xc333) at 0x2e
Register dump:
idx 10 11 13 14 16 17 18 19  1a 1b 1c 1d 1e 1f 20 21  22 23 24 25 26 27 28 2a  2b 2c 2d 2e 2f
val ff ff ff ff ff ff ff ff  f8 0e 00 00 ff ff c3 33  ff 00 5c 00 00 d0 00 62  00 80 00 00 01
def ff ff 00 00 ff ff ff ff  f0 78 00 00 ff ff c3 33  ff 00 64 00 MM 00 00 c0  00 81 00 00 MM
LDN 0x00 (FDC)
idx 30 60 61 70 74 f0 f1 f2  f4 f5
val 00 03 f0 06 02 0e 00 ff  00 00
def 01 03 f0 06 02 0e 00 ff  00 00
LDN 0x01 (Parallel Port)
idx 30 60 61 70 74 f0
val 00 03 78 07 04 3f
def 01 03 78 07 04 3f
LDN 0x02 (UART A)
idx 30 60 61 70 f0 f2
val 01 03 f8 04 00 00
def 01 03 f8 04 00 00
LDN 0x03 (UART B, IR)
idx 30 60 61 70 f0 f1 f2
val 00 02 f8 03 00 00 00
def 01 02 f8 03 00 00 00
LDN 0x05 (Keyboard Controller)
idx 30 60 61 62 63 70 72 f0
val 01 00 60 00 64 01 0c 83
def 00 00 00 00 00 00 00 83
LDN 0x06 (CIR)
idx 30 60 61 70 f0 f1 f2 f3
val 00 00 00 00 08 09 32 00
def 00 00 00 00 08 09 32 00
LDN 0x07 (GPIO6, GPIO7, GPIO8, GPIO9)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ec ed ee  f4 f5 f6 f7 f8
val 00 ff f7 00 f7 ff ff ff  ff ff ff ff ff 00 ff ff  ff ff ff ff ff
def 03 ff 00 00 00 ef 00 00  00 ff 00 00 00 00 00 00  ff 00 00 00 00
LDN 0x08 (WDT1, GPIO0, GPIO1, GPIOA)
idx 30 60 61 e0 e1 e2 e3 e4  f0 f1 f2 f3 f4 f5 f6 f7
val 00 00 00 ff ff ff ff ff  b0 b1 00 00 00 ff 00 ff
def 02 00 00 ff 00 00 00 ef  ff 00 00 00 00 00 00 00
LDN 0x09 (GPIO2, GPIO3, GPIO4, GPIO5)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ee f0 f1  f2 f4 f5 f6 f7 fe
val b6 ff 2c 00 00 ff ff ff  ff 00 00 ff 00 00 ff 6c  00 ff 00 00 00 00
def 04 df 00 00 00 ff 00 00  00 00 00 00 00 00 ff 00  00 ff 00 00 00 00
LDN 0x0a (ACPI)
idx e0 e1 e2 e3 e4 e5 e6 e7  e9 ee f0 f2 f3 f4 f6 f7  fe
val 01 00 00 01 20 02 4c 00  00 00 20 5c 00 00 00 c0  00
def 01 00 00 00 00 02 1c 00  00 00 00 00 00 00 00 c0  00
LDN 0x0b (Hardware Monitor, Front Panel LED)
idx 30 60 61 62 63 70 e0 e1  e2 f0 f1 f2 f5 f6 f7 f8  f9 fa
val e1 02 90 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
def 00 00 00 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
LDN 0x0d (VID)
idx e0 e1 e2 e3 e4 e5 e6 e9  ee ef f0 f4 f5
val 00 00 00 00 00 00 00 00  88 00 00 00 00
def 00 00 00 00 00 00 00 00  88 00 00 00 00
LDN 0x0e (CIR WAKE-UP)
idx 30 60 61 70
val 00 02 50 00
def 00 00 00 00
LDN 0x0f (GPIO Push-Pull or Open-drain)
idx e0 e1 e2 e3 e4 e5 e6 e7  e8 e9 f0 f1 f2
val ff df ff fe f6 ff ff d3  ff 9f 00 00 00
def ff df ff fe f6 ff ff d3  ff 9f 00 00 00
LDN 0x14 (SVID)
idx e0 e1 e3 e4
val 00 80 00 00
def 00 80 00 00
LDN 0x16 (Deep Sleep)
idx 30 e0 e1 e2
val 68 20 04 05
def 20 20 04 05
LDN 0x17 (GPIOA)
idx e0 e1 e2 e3 e4 e5
val ff ff ff ff 01 ff
def 01 00 00 00 01 00
Bank 0:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 04 ff 04 b1 00 ff ff ff ff ff ff ff ff ff ff ff 
01: 04 ff 00 00 00 00 ff ff 40 00 00 00 00 87 00 00 
02: 79 e6 d1 d1 8a d2 76 2d ff ff ff da 00 ec d6 e3 
03: ba e3 ba bc 7d ec bc 00 00 00 00 ff ff ff ff ff 
04: 03 0e 55 ff ff 00 3f ff 2d ff ff ff 18 05 00 a3 
05: ff ff ff ff ff ff ff ff c1 ff ff ff ff 01 00 ff 
06: 30 ff ff ff ff 01 00 ff ff ff ff ff ff ff ff ff 
07: 00 0a 00 2d 80 26 80 1f 00 ff ff ff ff ff ff ff 
08: ff 03 1f 0f ff 3c 3c 3c 00 00 00 00 00 00 00 00 
09: 0a 00 00 00 00 0a 0a 0a 0a aa ef 80 ff 40 46 c4 
0a: 0e 01 00 00 ff 00 00 ff 00 00 80 66 66 06 01 01 
0b: 00 00 00 00 00 00 3d 00 1c 00 00 04 6e c0 c4 ff 
0c: 01 00 00 00 00 00 00 00 00 10 01 ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 1:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 01 00 00 0a 0a 01 01 3c ff ff ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 19 23 2d 37 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 7f ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff a4 00 ff ff ff ff ff ff ff 01 ff 
05: 24 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 2:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 8c 32 12 0a 0a b1 ff 60 ff b1 ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 28 32 3c 46 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 7f ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff 43 05 ff ff ff ff ff ff ff 02 ff 
05: 1f 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 3:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 03 00 00 0a 0a 01 01 3c ff ff ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 19 23 2d 37 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 3c ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff eb 02 ff ff ff ff ff ff ff 03 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 4:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff 
02: ff ff ff 96 64 96 64 e1 96 ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: 3f 00 01 ff ff ff ff ff ff ff ff ff ff ff 04 ff 
05: 03 13 ff ff 00 00 00 ff 00 10 10 10 09 ff ff ff 
06: ff 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 5:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff ff 00 00 00 00 ff ff ff ff ff ff ff 00 00 ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 05 ff 
05: d9 d0 40 ff e3 ba e3 a9 ff ff ff ff ff ff ff ff 
06: 00 00 00 00 00 00 07 00 01 ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 6:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff 01 02 03 0c 01 01 ff 00 00 00 26 2d 2d 07 ff 
03: ff 1f 1f 0a 38 0f 40 06 26 03 ff 1f ff 1f ff 1f 
04: ff 1f ff 1f 02 02 02 ff ff ff ff ff ff ff 06 ff 
05: 7f 7f 7f 7f 7f 7f 00 a4 05 43 02 eb 02 91 04 53 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: 7f 7f 50 4b 04 7f 7f 50 4b 04 7f 7f 50 4b 04 ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 7:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff 95 02 10 00 00 00 00 00 62 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 f1 37 f8 80 f8 80 f8 80 01 
02: 26 03 06 00 00 00 ef 4b 00 ef 00 00 00 00 00 00 
03: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 07 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

--------------060302060705010308080502
Content-Type: text/plain; charset=UTF-8;
 name="04-superiotool-after-resume-from-suspend.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="04-superiotool-after-resume-from-suspend.out"

superiotool r4.0-2514-gf419483
Found Nuvoton NCT6776F (C) (id=0xc333) at 0x2e
Register dump:
idx 10 11 13 14 16 17 18 19  1a 1b 1c 1d 1e 1f 20 21  22 23 24 25 26 27 28 2a  2b 2c 2d 2e 2f
val ff ff ff ff ff ff ff ff  f8 0e 00 00 ff ff c3 33  ff 00 5c 00 00 d0 00 62  00 80 00 00 01
def ff ff 00 00 ff ff ff ff  f0 78 00 00 ff ff c3 33  ff 00 64 00 MM 00 00 c0  00 81 00 00 MM
LDN 0x00 (FDC)
idx 30 60 61 70 74 f0 f1 f2  f4 f5
val 00 03 f0 06 02 0e 00 ff  00 00
def 01 03 f0 06 02 0e 00 ff  00 00
LDN 0x01 (Parallel Port)
idx 30 60 61 70 74 f0
val 00 03 78 07 04 3f
def 01 03 78 07 04 3f
LDN 0x02 (UART A)
idx 30 60 61 70 f0 f2
val 01 03 f8 04 00 00
def 01 03 f8 04 00 00
LDN 0x03 (UART B, IR)
idx 30 60 61 70 f0 f1 f2
val 00 02 f8 03 00 00 00
def 01 02 f8 03 00 00 00
LDN 0x05 (Keyboard Controller)
idx 30 60 61 62 63 70 72 f0
val 01 00 60 00 64 01 0c 83
def 00 00 00 00 00 00 00 83
LDN 0x06 (CIR)
idx 30 60 61 70 f0 f1 f2 f3
val 00 00 00 00 08 09 32 00
def 00 00 00 00 08 09 32 00
LDN 0x07 (GPIO6, GPIO7, GPIO8, GPIO9)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ec ed ee  f4 f5 f6 f7 f8
val 00 ff fb 00 fb ff ff ff  ff ff ff ff ff 00 ff ff  ff ff ff ff ff
def 03 ff 00 00 00 ef 00 00  00 ff 00 00 00 00 00 00  ff 00 00 00 00
LDN 0x08 (WDT1, GPIO0, GPIO1, GPIOA)
idx 30 60 61 e0 e1 e2 e3 e4  f0 f1 f2 f3 f4 f5 f6 f7
val 00 00 00 ff ff ff ff ff  b0 b1 00 b1 00 ff 00 ff
def 02 00 00 ff 00 00 00 ef  ff 00 00 00 00 00 00 00
LDN 0x09 (GPIO2, GPIO3, GPIO4, GPIO5)
idx 30 e0 e1 e2 e3 e4 e5 e6  e7 e8 e9 ea eb ee f0 f1  f2 f4 f5 f6 f7 fe
val b6 ff 2c 00 2c ff ff ff  ff 6c 00 ff 00 00 ff 6c  00 ff 00 00 00 00
def 04 df 00 00 00 ff 00 00  00 00 00 00 00 00 ff 00  00 ff 00 00 00 00
LDN 0x0a (ACPI)
idx e0 e1 e2 e3 e4 e5 e6 e7  e9 ee f0 f2 f3 f4 f6 f7  fe
val 01 00 00 01 20 02 4c 00  00 00 20 5c 00 00 00 c0  00
def 01 00 00 00 00 02 1c 00  00 00 00 00 00 00 00 c0  00
LDN 0x0b (Hardware Monitor, Front Panel LED)
idx 30 60 61 62 63 70 e0 e1  e2 f0 f1 f2 f5 f6 f7 f8  f9 fa
val e1 02 90 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
def 00 00 00 00 00 00 7f 7f  ff 00 00 00 10 00 87 47  00 00
LDN 0x0d (VID)
idx e0 e1 e2 e3 e4 e5 e6 e9  ee ef f0 f4 f5
val 00 00 00 00 00 00 00 00  88 00 00 00 00
def 00 00 00 00 00 00 00 00  88 00 00 00 00
LDN 0x0e (CIR WAKE-UP)
idx 30 60 61 70
val 00 02 50 00
def 00 00 00 00
LDN 0x0f (GPIO Push-Pull or Open-drain)
idx e0 e1 e2 e3 e4 e5 e6 e7  e8 e9 f0 f1 f2
val ff df ff fe f6 ff ff d3  ff 9f 00 00 00
def ff df ff fe f6 ff ff d3  ff 9f 00 00 00
LDN 0x14 (SVID)
idx e0 e1 e3 e4
val 00 80 00 00
def 00 80 00 00
LDN 0x16 (Deep Sleep)
idx 30 e0 e1 e2
val 68 20 04 05
def 20 20 04 05
LDN 0x17 (GPIOA)
idx e0 e1 e2 e3 e4 e5
val ff ff ff ff 01 ff
def 01 00 00 00 01 00
Bank 0:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 04 ff 04 b1 00 ff ff ff ff ff ff ff ff ff ff ff 
01: 04 ff 00 00 00 00 ff ff 40 00 00 00 00 87 00 00 
02: 79 e6 d1 d1 89 d2 76 2d ff ff ff da 00 ec d6 e3 
03: ba e3 ba bc 7d ec bc 00 00 00 00 ff ff ff ff ff 
04: 03 de 5f ff ff 00 3f ff 2d ff ff ff 18 05 00 a3 
05: ff ff ff ff ff ff ff ff c1 ff ff ff ff 01 00 ff 
06: 30 ff ff ff ff 01 00 ff ff ff ff ff ff ff ff ff 
07: 00 0a 00 2d 80 26 00 1f 00 ff ff ff ff ff ff ff 
08: ff 03 1f 0f ff 3c 3c 3c 00 00 00 00 00 00 00 00 
09: 0a 00 00 00 00 0a 0a 0a 0a aa ef 80 ff 40 46 c4 
0a: 0e 01 00 00 ff 00 00 ff 00 00 80 66 66 06 01 01 
0b: 00 00 00 00 00 00 3d 00 1c 00 00 34 28 c0 c4 ff 
0c: 01 00 00 00 00 00 00 00 00 0d 03 ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 1:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 01 00 00 0a 0a 01 01 3c ff ff ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 19 23 2d 37 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 7f ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff a4 00 ff ff ff ff ff ff ff 01 ff 
05: 24 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 2:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 8c 32 12 0a 0a b1 ff 60 ff b1 ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 28 32 3c 46 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 7f ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff 3c 05 ff ff ff ff ff ff ff 02 ff 
05: 1f 00 00 4b 00 50 00 ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 3:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 03 00 00 0a 0a 01 01 3c ff ff ff ff 00 ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: 00 19 23 2d 37 ff ff 8c aa c8 e6 ff ff ff ff ff 
03: ff 00 ff ff 00 3c ff ff 00 01 00 00 00 00 00 00 
04: ff ff ff ff ff eb 02 ff ff ff ff ff ff ff 03 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 4:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff 
02: ff ff ff 96 64 96 64 e1 96 ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: 3f 00 01 ff ff ff ff ff ff ff ff ff ff ff 04 ff 
05: 31 13 ff ff 00 00 00 ff 00 10 10 10 09 ff ff ff 
06: ff 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 5:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff ff 00 00 00 00 ff ff ff ff ff ff ff 00 00 ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
03: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 05 ff 
05: d9 d0 40 ff e3 ba e3 a9 ff ff ff ff ff ff ff ff 
06: 00 00 00 00 00 00 07 01 01 ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 6:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
01: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02: ff 01 02 03 01 01 01 ff 00 00 00 2d 2d 2d 07 ff 
03: ff 1f 1f 0f 38 0e 40 02 26 02 ff 1f ff 1f ff 1f 
04: ff 1f ff 1f 02 02 02 ff ff ff ff ff ff ff 06 ff 
05: 7f 7f 7f 7f 7f 7f 00 a4 05 3c 02 eb 02 92 04 54 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: 7f 7f 50 4b 04 7f 7f 50 4b 04 7f 7f 50 4b 04 ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
Bank 7:
    00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
00: ff 95 02 10 00 00 00 00 00 62 00 00 00 00 00 00 
01: 00 00 00 00 00 00 00 f1 11 f8 80 f8 80 f8 80 01 
02: 26 01 06 00 00 00 ef 9b 00 ef 00 00 00 00 00 00 
03: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff 
04: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 07 ff 
05: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
06: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
07: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
08: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
09: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0a: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0b: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0c: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0d: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0e: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0f: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

--------------060302060705010308080502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060302060705010308080502--
