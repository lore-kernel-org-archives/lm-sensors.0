From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 28 Jul 2013 22:28:33 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <51F59B11.5050505@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 07/28/2013 01:43 PM, Harald Judt wrote:
> Hi,
>
> Am 22.10.2012 23:40, schrieb Guenter Roeck:
>> On Mon, Oct 22, 2012 at 05:03:45PM +0200, Harald Judt wrote:
>>> Hi,
>>>
>>> After resuming from suspend or hibernation, the Vbat value is
>>> reported to be 0.0. Before that, it reported the correct value.
>>> Min/max values are wrong too.
>>>
>>> Linux-3.6.2, ASRock Z77 Extreme4 BIOS v1.80.
>>>
>>> Before suspend:
>>> nct6776-isa-0290
>>> Adapter: ISA adapter
>>> Vcore:         +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>> in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> AVCC:          +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> +3.3V:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> in4:           +1.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> 3VSB:          +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> Vbat:          +3.31 V  (min =3D  +2.70 V, max =3D  +3.63 V)
>>> fan1:            0 RPM  (min =3D    0 RPM)  ALARM
>>> fan2:         1289 RPM  (min =3D    0 RPM)  ALARM
>>> fan3:          724 RPM  (min =3D    0 RPM)  ALARM
>>> fan4:          661 RPM  (min =3D    0 RPM)  ALARM
>>> fan5:         1076 RPM  (min =3D    0 RPM)  ALARM
>>> SYSTIN:        +37.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALA=
RM
>>> sensor =3D thermistor
>>> CPUTIN:        +28.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
>>> thermistor
>>> AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
>>> thermistor
>>> PECI Agent 0:  +32.0=B0C
>>> cpu0_vid:     +0.000 V
>>> intrusion0:   ALARM
>>> intrusion1:   ALARM
>>>
>>> After resuming:
>>> nct6776-isa-0290
>>> Adapter: ISA adapter
>>> Vcore:         +0.97 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>> in1:           +1.84 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> AVCC:          +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> +3.3V:         +3.34 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> in4:           +1.03 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> in5:           +1.68 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> 3VSB:          +3.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> Vbat:          +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
>>> fan1:            0 RPM  (min =3D    0 RPM)  ALARM
>>> fan2:         1271 RPM  (min =3D    0 RPM)  ALARM
>>> fan3:          734 RPM  (min =3D    0 RPM)  ALARM
>>> fan4:          673 RPM  (min =3D    0 RPM)  ALARM
>>> fan5:         1093 RPM  (min =3D    0 RPM)  ALARM
>>> SYSTIN:        +36.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALA=
RM
>>> sensor =3D thermistor
>>> CPUTIN:        +26.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
>>> thermistor
>>> AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
>>> thermistor
>>> PECI Agent 0:  +30.0=B0C
>>> cpu0_vid:     +0.000 V
>>> intrusion0:   ALARM
>>> intrusion1:   ALARM
>>>
>>> Reloading the module helps. Of course, a fresh boot too ;-)
>>>
>> The driver doesn't implement suspend/resume support, so it is not very
>> surprising that the limits get lost - and it looks like vbat monitoring
>> is disabled by default, so that gets lost as well.
>>
>> Someone would have to submit a patch to add suspend/resume support to
>> the driver ... any takers out there ?
>>
>> Thanks,
>> Guenter
>
> A while ago, support for suspend/resume has been added and this issue
> was fixed and values are now preserved during suspend/resume.
>
> 3300fb4f88688029fff8dfb9ec0734f6e4cba3e7 hwmon: (w83627ehf) Force
> initial bank selection
> 7e630bb55a52cfaa35011c0ebc2efc96f13e5135 hwmon: (w83627ehf) Add support
> for suspend
>
> But now with kernel 3.11-rc2, I noticed it only works in case of
> suspend/resume, not hibernate/resume. I'm not sure this worked properly
> with kernel 3.6.2 with the patch applied, though I think it did, but I
> don't have that version available for verification at the moment. Of
> course, I could test if necessary. Perhaps there is more to do for
> hibernate/resume than for suspend/resume?
>
It should not require anything special, and at first glance the code
seems to be ok. Maybe hibernate (now) results in some secondary changes
which we don't take into account.

It would be great if you can download
	http://roeck-us.net/linux/bin/superiotool
and run "sudo ./superiotool -d -e" before hibernation and after resume
and send me the results.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
