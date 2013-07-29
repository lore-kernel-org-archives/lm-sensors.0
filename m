From: Harald Judt <h.judt@gmx.at>
Date: Mon, 29 Jul 2013 15:27:35 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <51F689E7.1060201@gmx.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020202070806020409070403"
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020202070806020409070403
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Am 29.07.2013 08:58, schrieb Guenter Roeck:
> On 07/28/2013 07:47 PM, Harald Judt wrote:
>> Am 29.07.2013 04:24, schrieb Harald Judt:
>>> Am 29.07.2013 00:28, schrieb Guenter Roeck:
>>>> On 07/28/2013 01:43 PM, Harald Judt wrote:
>>>>> Hi,
>>>>>
>>>>> Am 22.10.2012 23:40, schrieb Guenter Roeck:
>>>>>> On Mon, Oct 22, 2012 at 05:03:45PM +0200, Harald Judt wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> After resuming from suspend or hibernation, the Vbat value is
>>>>>>> reported to be 0.0. Before that, it reported the correct value.
>>>>>>> Min/max values are wrong too.
>>>>>>>
>>>>>>> Linux-3.6.2, ASRock Z77 Extreme4 BIOS v1.80.
>>>>>>>
>>>>>>> Before suspend:
>>>>>>> nct6776-isa-0290
>>>>>>> Adapter: ISA adapter
>>>>>>> Vcore:         +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>>>>>> in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>>>>> AVCC:          +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>>>>>> +3.3V:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>>>>>> in4:           +1.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>>>>> in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>>>>> 3VSB:          +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>>>>>> Vbat:          +3.31 V  (min =3D  +2.70 V, max =3D  +3.63 V)
>>>>>>> fan1:            0 RPM  (min =3D    0 RPM)  ALARM
>>>>>>> fan2:         1289 RPM  (min =3D    0 RPM)  ALARM
>>>>>>> fan3:          724 RPM  (min =3D    0 RPM)  ALARM
>>>>>>> fan4:          661 RPM  (min =3D    0 RPM)  ALARM
>>>>>>> fan5:         1076 RPM  (min =3D    0 RPM)  ALARM
>>>>>>> SYSTIN:        +37.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C) =
 ALARM
>>>>>>> sensor =3D thermistor
>>>>>>> CPUTIN:        +28.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
 sensor =3D
>>>>>>> thermistor
>>>>>>> AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
 sensor =3D
>>>>>>> thermistor
>>>>>>> PECI Agent 0:  +32.0=B0C
>>>>>>> cpu0_vid:     +0.000 V
>>>>>>> intrusion0:   ALARM
>>>>>>> intrusion1:   ALARM
>>>>>>>
>>>>>>> After resuming:
>>>>>>> nct6776-isa-0290
>>>>>>> Adapter: ISA adapter
>>>>>>> Vcore:         +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>>>>>> in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>>>>> AVCC:          +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>>>>> +3.3V:         +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>>>>> in4:           +1.03 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>>>>> in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>>>>> 3VSB:          +3.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>>>>>> Vbat:          +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
>>>>>>> fan1:            0 RPM  (min =3D    0 RPM)  ALARM
>>>>>>> fan2:         1271 RPM  (min =3D    0 RPM)  ALARM
>>>>>>> fan3:          734 RPM  (min =3D    0 RPM)  ALARM
>>>>>>> fan4:          673 RPM  (min =3D    0 RPM)  ALARM
>>>>>>> fan5:         1093 RPM  (min =3D    0 RPM)  ALARM
>>>>>>> SYSTIN:        +36.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C) =
 ALARM
>>>>>>> sensor =3D thermistor
>>>>>>> CPUTIN:        +26.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
 sensor =3D
>>>>>>> thermistor
>>>>>>> AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
 sensor =3D
>>>>>>> thermistor
>>>>>>> PECI Agent 0:  +30.0=B0C
>>>>>>> cpu0_vid:     +0.000 V
>>>>>>> intrusion0:   ALARM
>>>>>>> intrusion1:   ALARM
>>>>>>>
>>>>>>> Reloading the module helps. Of course, a fresh boot too ;-)
>>>>>>>
>>>>>> The driver doesn't implement suspend/resume support, so it is not
>>>>>> very
>>>>>> surprising that the limits get lost - and it looks like vbat
>>>>>> monitoring
>>>>>> is disabled by default, so that gets lost as well.
>>>>>>
>>>>>> Someone would have to submit a patch to add suspend/resume support to
>>>>>> the driver ... any takers out there ?
>>>>>>
>>>>>> Thanks,
>>>>>> Guenter
>>>>>
>>>>> A while ago, support for suspend/resume has been added and this issue
>>>>> was fixed and values are now preserved during suspend/resume.
>>>>>
>>>>> 3300fb4f88688029fff8dfb9ec0734f6e4cba3e7 hwmon: (w83627ehf) Force
>>>>> initial bank selection
>>>>> 7e630bb55a52cfaa35011c0ebc2efc96f13e5135 hwmon: (w83627ehf) Add
>>>>> support
>>>>> for suspend
>>>>>
>>>>> But now with kernel 3.11-rc2, I noticed it only works in case of
>>>>> suspend/resume, not hibernate/resume. I'm not sure this worked
>>>>> properly
>>>>> with kernel 3.6.2 with the patch applied, though I think it did, but I
>>>>> don't have that version available for verification at the moment. Of
>>>>> course, I could test if necessary. Perhaps there is more to do for
>>>>> hibernate/resume than for suspend/resume?
>>>>>
>>>> It should not require anything special, and at first glance the code
>>>> seems to be ok. Maybe hibernate (now) results in some secondary changes
>>>> which we don't take into account.
>>>>
>>>> It would be great if you can download
>>>>      http://roeck-us.net/linux/bin/superiotool
>>>> and run "sudo ./superiotool -d -e" before hibernation and after resume
>>>> and send me the results.
>>>>
>>>> Thanks,
>>>> Guenter
>>>
>>> Ok, I've switched to the nct6775 driver, didn't know there was a new one
>>> ;-) Unfortunately, the same behaviour. I have installed superiotool-6637
>>> from the gentoo repository, I hope that does the job too. I compiled
>>> nct6775, did modprobe -r w83627ehf, modprobe nct6775.
>>> Sensors output:
>>>
>>> Before hibernation:
>>> -------------------------------------------------------------------
>>> nct6776-isa-0290
>>> Adapter: ISA adapter
>>> Vcore:          +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>> in1:            +1.82 V  (min =3D  +1.71 V, max =3D  +1.89 V)
>>> AVCC:           +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> +3.3V:          +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> in4:            +1.07 V  (min =3D  +1.00 V, max =3D  +1.50 V)
>>> in5:            +1.68 V  (min =3D  +1.50 V, max =3D  +1.89 V)
>>> in6:            +0.92 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> 3VSB:           +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> Vbat:           +3.31 V  (min =3D  +2.70 V, max =3D  +3.63 V)
>>> fan1:             0 RPM  (min =3D    0 RPM)
>>> fan2:          1337 RPM  (min =3D    0 RPM)
>>> fan3:           742 RPM  (min =3D    0 RPM)
>>> fan4:           661 RPM  (min =3D    0 RPM)
>>> fan5:          1077 RPM  (min =3D    0 RPM)
>>> SYSTIN:         +42.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  AL=
ARM  sensor
>>> =3D thermistor
>>> CPUTIN:         +35.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>> thermistor
>>> AUXTIN:         +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>> thermistor
>>> PECI Agent 0:   +37.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
>>>                           (crit =3D +98.0=B0C)
>>> PCH_CHIP_TEMP:   +0.0=B0C
>>> PCH_CPU_TEMP:    +0.0=B0C
>>> PCH_MCH_TEMP:    +0.0=B0C
>>> intrusion0:    ALARM
>>> intrusion1:    OK
>>> -------------------------------------------------------------------
>>>
>>> After resuming from hibernation:
>>> -------------------------------------------------------------------
>>> nct6776-isa-0290
>>> Adapter: ISA adapter
>>> Vcore:          +1.24 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>> in1:            +1.82 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> AVCC:           +3.33 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> +3.3V:          +3.33 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> in4:            +1.09 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> in5:            +1.67 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> in6:            +0.93 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> 3VSB:           +3.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> Vbat:           +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
>>> fan1:             0 RPM  (min =3D    0 RPM)  ALARM
>>> fan2:          1339 RPM  (min =3D    0 RPM)  ALARM
>>> fan3:           744 RPM  (min =3D    0 RPM)  ALARM
>>> fan4:           657 RPM  (min =3D    0 RPM)  ALARM
>>> fan5:          1100 RPM  (min =3D    0 RPM)  ALARM
>>> SYSTIN:         +43.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  AL=
ARM  sensor
>>> =3D thermistor
>>> CPUTIN:         +37.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>> thermistor
>>> AUXTIN:         +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>> thermistor
>>> PECI Agent 0:   +43.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
>>>                           (crit =3D +98.0=B0C)
>>> PCH_CHIP_TEMP:   +0.0=B0C
>>> PCH_CPU_TEMP:    +0.0=B0C
>>> PCH_MCH_TEMP:    +0.0=B0C
>>> intrusion0:    ALARM
>>> intrusion1:    OK
>>> -------------------------------------------------------------------
>>>
>>>
>>> modprobe -r nct6775, modprobe nct6775, sensors -s to restore
>>> functionality.
>>>
>>> Before suspending:
>>> -------------------------------------------------------------------
>>> nct6776-isa-0290
>>> Adapter: ISA adapter
>>> Vcore:          +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>> in1:            +1.82 V  (min =3D  +1.71 V, max =3D  +1.89 V)
>>> AVCC:           +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> +3.3V:          +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> in4:            +1.10 V  (min =3D  +1.00 V, max =3D  +1.50 V)
>>> in5:            +1.68 V  (min =3D  +1.50 V, max =3D  +1.89 V)
>>> in6:            +0.94 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> 3VSB:           +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> Vbat:           +3.33 V  (min =3D  +2.70 V, max =3D  +3.63 V)
>>> fan1:             0 RPM  (min =3D    0 RPM)
>>> fan2:          1345 RPM  (min =3D    0 RPM)
>>> fan3:           731 RPM  (min =3D    0 RPM)
>>> fan4:           655 RPM  (min =3D    0 RPM)
>>> fan5:          1083 RPM  (min =3D    0 RPM)
>>> SYSTIN:         +45.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  AL=
ARM  sensor
>>> =3D thermistor
>>> CPUTIN:         +36.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>> thermistor
>>> AUXTIN:         +31.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>> thermistor
>>> PECI Agent 0:   +38.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
>>>                           (crit =3D +98.0=B0C)
>>> PCH_CHIP_TEMP:   +0.0=B0C
>>> PCH_CPU_TEMP:    +0.0=B0C
>>> PCH_MCH_TEMP:    +0.0=B0C
>>> intrusion0:    ALARM
>>> intrusion1:    OK
>>> -------------------------------------------------------------------
>>>
>>> After resuming from S3:
>>> -------------------------------------------------------------------
>>> nct6776-isa-0290
>>> Adapter: ISA adapter
>>> Vcore:          +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>> in1:            +1.82 V  (min =3D  +1.71 V, max =3D  +1.89 V)
>>> AVCC:           +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> +3.3V:          +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> in4:            +1.10 V  (min =3D  +1.00 V, max =3D  +1.50 V)
>>> in5:            +1.67 V  (min =3D  +1.50 V, max =3D  +1.89 V)
>>> in6:            +0.94 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> 3VSB:           +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> Vbat:           +3.33 V  (min =3D  +2.70 V, max =3D  +3.63 V)
>>> fan1:             0 RPM  (min =3D    0 RPM)
>>> fan2:          1336 RPM  (min =3D    0 RPM)
>>> fan3:           744 RPM  (min =3D    0 RPM)
>>> fan4:           656 RPM  (min =3D    0 RPM)
>>> fan5:          1103 RPM  (min =3D    0 RPM)
>>> SYSTIN:         +45.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  AL=
ARM  sensor
>>> =3D thermistor
>>> CPUTIN:         +36.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>> thermistor
>>> AUXTIN:         +31.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D
>>> thermistor
>>> PECI Agent 0:   +45.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
>>>                           (crit =3D +98.0=B0C)
>>> PCH_CHIP_TEMP:   +0.0=B0C
>>> PCH_CPU_TEMP:    +0.0=B0C
>>> PCH_MCH_TEMP:    +0.0=B0C
>>> intrusion0:    ALARM
>>> intrusion1:    OK
>>> -------------------------------------------------------------------
>>>
>>>
>>> Superiotool output is attached.
>>>
>>> Note that I can do "sensors -s", but that won't reset/reenable some
>>> values like vbat. The only way to get it back working is rmmod/modprobe.
>>> It seems like the code that runs properly at resume after suspend simply
>>> is not executed after resuming from hibernation. Maybe I should put some
>>> debug output in there to verify...
>>
>> And indeed, the resume code is not run on hibernate/resume. I've place
>> two lines in there for debugging (see the small patch attached). The
>> lines are printed at suspend/resume, but not at hibernate/resume. I
>> guess this is not a problem with the nct6775 driver then?
>>
> I don't know; I'll have to have a look into the kernel itself. Maybe it
> is on purpose, though it evades me why that would be the case.
>=20
> Question: Does the suspend code run on hibernation ? There are separate
> callbacks for suspend/resume vs. hibernate/wakeup; the latter are
> freeze/thaw. I thought suspend/resume would be called if freeze/thaw is
> not defined, but maybe that is not or no longer the case.
>=20
> Thanks,
> Guenter

No, the suspend code did not run on hibernation, nor did the resume
code. The documentation in Documentation/power/devices.txt does not
say anything about the suspend/resume code being used for hibernation;
Indeed it seems one has to treat that as a separate case because it's
a more complicated process. The attached, rather trivial patch fixes
this on my system. Using "thaw" however, the resume function would not
be called, so I had to use "restore" which is analogous to the resume
function when leaving hibernation. I'm not sure if one does not have
to hook up a thaw function too (maybe so that it's called in case of
error, but if it fails there may not be anything that can be done
about it). So I think those two entries should suffice.

Harald

--=20
`Experience is the best teacher.'

PGP Key ID: 0xB29C7F8F

--------------020202070806020409070403
Content-Type: text/x-patch;
 name="0001-hwmon-nct6775-Add-support-for-hibernate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-hwmon-nct6775-Add-support-for-hibernate.patch"

From c3961cf2fa1d6975b9bcffeb746c57bda09e7489 Mon Sep 17 00:00:00 2001
From: Harald Judt <h.judt@gmx.at>
Date: Mon, 29 Jul 2013 17:00:27 +0200
Subject: hwmon: (nct6775) Add support for hibernate

---
 drivers/hwmon/nct6775.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 99cec18..b66bc74 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4056,6 +4056,8 @@ static int nct6775_resume(struct device *dev)
 static const struct dev_pm_ops nct6775_dev_pm_ops = {
 	.suspend = nct6775_suspend,
 	.resume = nct6775_resume,
+	.freeze = nct6775_suspend,
+	.restore = nct6775_resume
 };
 
 #define NCT6775_DEV_PM_OPS	(&nct6775_dev_pm_ops)
-- 
1.8.3.2


--------------020202070806020409070403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020202070806020409070403--
