From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 22 Sep 2013 21:23:18 +0000
Subject: Re: [lm-sensors] Config of P9X79 WS motherboard and its nct6776-isa-0290 sensor
Message-Id: <523F5FC6.1090301@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALmZR2OS2drgwx9wvfocsmWwgqWQcg0WKFd0_DAYokUT4i9+Xg@mail.gmail.com>
In-Reply-To: <CALmZR2OS2drgwx9wvfocsmWwgqWQcg0WKFd0_DAYokUT4i9+Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 09/22/2013 12:51 PM, Kent Larsson wrote:
> Thanks for offering to help! I'll make this my pet project for a while. :=
-)
>
[ Side note: Please don't top-post ]

> Actually I had not been using acpi_enforce_resources=3Dlax, but I *think*=
 I
> am using it now. I included the parameter at boot:
>
>      I root@debianstick:~# cat /proc/cmdline
>      BOOT_IMAGE=3D/boot/vmlinuz-3.2.0-4-amd64
> root=3DUUID=3D771651f1-c1a2-47af-a7ee-96a0c7bbfc51 ro quiet
> acpi_enforce_resources=3Dlax
>
> But at the same time acpi_enforce_resources isn't included when I "Display
> all currently available" (I interpret it as "possible with the current
> kernel") using sysctl (which might be a bit odd?):
>
>      root@debianstick:~# sysctl --all | grep acpi
>      kernel.acpi_video_flags =3D 0
>
> Am I doing something wrong when I try to set the acpi_enforce_resources=
=3Dlax
> kernel parameter?
>
You should see that in /proc/cmdline. The above shows module parameters,
which is different.

> Unfortunately the sensors output looks the same with the
> acpi_enforce_resources=3Dlax kernel paremeter, if I am setting it correct=
ly.
> The sensors output looks the same both before and after running
> sensors-detect again.
>
> My GNU/Linux knowledge has lots of holes. How would I try the asus_atk0110
> driver with lm-sensors? I assume (but please correct me) that it simply
> means that it's a kernel module which I should load.
>
> I didn't have asus_atk0110 loaded at first:
>
>      root@debianstick:~# lsmod | grep asus
>      asus_wmi               18726  1 eeepc_wmi
>      sparse_keymap          12760  1 asus_wmi
>      rfkill                 19012  1 asus_wmi
>      wmi                    13243  3 asus_wmi,mxm_wmi,nouveau
>
> And got an error when I tried loading it when using
> acpi_enforce_resources=3Dlax as described above:
>
>      root@debianstick:~# modprobe asus_atk0110
>      ERROR: could not insert 'asus_atk0110': Device or resource busy
>
> It had a corresponding syslog entry:
>
>      Sep 22 19:50:21 debianstick kernel: [ 8208.492660] asus_atk0110:
> Resources not safely usable due to acpi_enforce_resources kernel parameter
>
> Does that mean that acpi_enforce_resources kernel is set to something oth=
er
> than lax?
>
No, it means that you specified it. It tells you exactly what is wrong:
You can not load the asus_atk0110 module if acpi_enforce_resources is set
to lax, and you can not load the nct6776 module if it is _not_ set to lax,
at least not if ACPI reserves the resources for itself (which is usually
the case on ASUS boards).

You can not load both; it is either-or.

> I tried modprobe asus_atk0110 after removing the modules coretemp and
> w83627ehf from /etc/modules and rebooting while still having
> acpi_enforce_resources=3Dlax set as described above, but that didn't help.
>
Again, that won't work.

> However, if I reboot and skip adding the argument
> acpi_enforce_resources=3Dlax to the linux... line in Grub it loads. Howev=
er,
> it only gives me this output:
>
> root@debianstick:~# sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +38.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
> Core 0:         +37.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
> Core 1:         +37.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
> Core 2:         +35.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
> Core 3:         +39.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
> Core 4:         +36.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
> Core 5:         +35.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>
> nouveau-pci-0100
> Adapter: PCI adapter
> temp1:        +48.0=B0C  (high =3D +100.0=B0C, crit =3D +110.0=B0C)
>
> If I reboot with all three modules in /etc/modules (asus_atk0110, coretemp
> and w83627ehf) I get the same output as without asus_atk0110.
>
>      test@debianstick:~$ sensors
>      coretemp-isa-0000
>      Adapter: ISA adapter
>      Physical id 0:  +39.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>      Core 0:         +35.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>      Core 1:         +38.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>      Core 2:         +35.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>      Core 3:         +37.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>      Core 4:         +36.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>      Core 5:         +35.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>
>      nouveau-pci-0100
>      Adapter: PCI adapter
>      temp1:        +48.0=B0C  (high =3D +100.0=B0C, crit =3D +110.0=B0C)
>
>      nct6776-isa-0290
>      Adapter: ISA adapter
>      Vcore:         +0.81 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>      in1:           +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>      AVCC:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>      +3.3V:         +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>      in4:           +1.01 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>      in5:           +2.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>      3VSB:          +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>      Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.63 V)
>      fan1:         1002 RPM  (min =3D    0 RPM)  ALARM
>      fan2:         1477 RPM  (min =3D    0 RPM)  ALARM
>      fan3:            0 RPM  (min =3D    0 RPM)  ALARM
>      fan4:            0 RPM  (min =3D    0 RPM)  ALARM
>      fan5:            0 RPM  (min =3D    0 RPM)  ALARM
>      SYSTIN:        +36.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  =
ALARM  sensor
> =3D thermistor
>      CPUTIN:        +41.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  =
sensor =3D CPU
> diode
>      AUXTIN:        +31.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  =
sensor =3D
> thermistor
>      PECI Agent 0:  +28.0=B0C
>      cpu0_vid:     +1.708 V
>      intrusion0:   OK
>      intrusion1:   ALARM
>
> I think I have completed step [1] now, if the kernel parameter was set the
> right way?
>
Do you see any kernel log message in the latter case, or when you try to lo=
ad
asus_atk0110 when acpi_enforce_resources is not set ?

Either case, it might help if you can send me a copy of the DSDT.

> For step [2] I'll try to set a resonable minimum fan speed for the used
> fans. It's a bit odd that it says the minimum is 0 but still thinks that
> for example fan1 is in ALARM state even though it's RPM is 1002. I also am

That is really a bug in the driver. The value programmed into the chip
is not initialized after reset which causes the ALARM bit to be set.
I fixed that in the nct56775 driver if I remember correctly.
I did not bother fixing it in the w83627ehf driver since it only happens
if the minimum limit is not set, and we'll remove support for nct6775/nct67=
76
from the w83627ehf driver in the near future anyway.

> a bit curious to how setting the minimum fan speed could help getting the
> RPM for the fans with 0 RPM? But of course I'll go further and try that
> anyway if I didn't mess something upp setting the kernel parameter talked
> about above.
>
The NCT677x chips sometimes behave in unexpected ways and may not provide
fan readings unless they are "primed".

Any chance you can switch to the nct6775 driver ? That would give us a bett=
er
baseline.

Thanks,
Guenter

> Best regards, Kent
>
>
>
> On Sat, Sep 21, 2013 at 7:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
>> On 09/21/2013 05:31 AM, Kent Larsson wrote:
>>
>>> Hi!
>>>
>>> I have a P9X79 WS motherboard and am having some problems with the
>>> nct6776-isa-0290 sensor. I'll start with most serious problem (where
>>> Google
>>> didn't turn up anything promising), 2 out of 4 fans are reported as 0 R=
PM,
>>> even though they are running.
>>>
>>> I am running Debian stable which has sensors version 3.3.2 with libsens=
ors
>>> version 3.3.2. I am using the latest kernel in Debian stable at the time
>>> of
>>> writing, uname -a prints:
>>> Linux cow 3.2.0-4-amd64 #1 SMP Debian 3.2.46-1+deb7u1 x86_64 GNU/Linux
>>>
>>> I have executed sensors-detect and loaded the suggested kernel modules.
>>> The
>>> sensors command prints:
>>>
>>> ----/ sensors output start /-----
>>>
>>> coretemp-isa-0000
>>> Adapter: ISA adapter
>>> Physical id 0:  +39.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>>> Core 0:         +35.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>>> Core 1:         +39.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>>> Core 2:         +36.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>>> Core 3:         +37.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>>> Core 4:         +36.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>>> Core 5:         +35.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
>>>
>>> nouveau-pci-0100
>>> Adapter: PCI adapter
>>> temp1:        +48.0=B0C  (high =3D +100.0=B0C, crit =3D +110.0=B0C)
>>>
>>> nct6776-isa-0290
>>> Adapter: ISA adapter
>>> Vcore:         +0.81 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>>> in1:           +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> AVCC:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> +3.3V:         +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> in4:           +1.01 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> in5:           +2.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>>> 3VSB:          +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>>> Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.63 V)
>>> fan1:          978 RPM  (min =3D    0 RPM)  ALARM
>>> fan2:         1508 RPM  (min =3D    0 RPM)  ALARM
>>> fan3:            0 RPM  (min =3D    0 RPM)  ALARM
>>> fan4:            0 RPM  (min =3D    0 RPM)  ALARM
>>> fan5:            0 RPM  (min =3D    0 RPM)  ALARM
>>> SYSTIN:        +37.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALA=
RM  sensor =3D
>>> thermistor
>>> CPUTIN:        +41.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D CPU
>>> diode
>>> AUXTIN:        +31.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor =3D
>>> thermistor
>>> PECI Agent 0:  +32.0=B0C
>>> cpu0_vid:     +1.708 V
>>> intrusion0:   OK
>>> intrusion1:   ALARM
>>>
>>> ----/ sensors output end /-----
>>>
>>> As you can see there are no "div" in any of the output, which I underst=
and
>>> means that changing the divisor won't help?
>>>
>>> I have screenshots of my BIOS (upgraded to latest version) and an
>>> annotated
>>> picture of the actual machine inside here:
>>> http://forums.debian.net/**viewtopic.php?f=3D10&t=3D107523&p=3D**512640=
#p512640<http://forums.debian.net/viewtopic.php?f=3D10&t=3D107523&p=3D51264=
0#p512640>
>>>
>>> That link also contains sensors-detect output and my complete
>>> /etc/sensors3.conf as I thought they were a bit too large to post in th=
is
>>> message. Let me know if that conclusion was wrong, in which case I'm so=
rry
>>> and I'll paste them here.
>>>
>>> I am willing to help out any way I can to improve lm-sensors support for
>>> my
>>> motherboard. It's supposed to be a nice motherboard, so improved
>>> compatibility would hopefully be of value for lots of users.
>>>
>>> Thank you for reading this post! I would greatly appreciate some help a=
s I
>>> am pretty dumbfounded when it comes to this problem.
>>>
>>>
>> The NCT6776 does not have fan divisor registers.
>>
>> Couple of things to try:
>>
>> 1) Try using the asus_atk0110 driver. ASUS exports environmental data
>> through ACPI,
>>     so that is the preferred method to get the the information for ASUS
>> boards.
>>     [ Which makes me wonder. Do you have "acpi_enforce_resources=3Dlax"
>> configured
>>       your boot command line ? ]
>>     If that does not work, please send a copy of /sys/firmware/acpi/tabl=
es/
>> **DSDT.
>> 2) Try setting the minimum fan speed to something reasonable. Odd, thoug=
h,
>> that
>>     the BIOS reports minimum speeds but the driver reports 0.
>> 3) Try using other fan connectors. I understand the board has a total of=
 6
>> connectors.
>>     Since the chip can only monitor a total of 5 fan inputs, it is possi=
ble
>> that ASUS
>>     uses a multiplexer to be able to read the speed of two of the fans.
>> Since we don't
>>     know about that, it won't work for us.
>> 4) Install and use the driver from https://github.com/groeck/**nct6775<h=
ttps://github.com/groeck/nct6775>
>> .
>>
>> We can go from there if nothing of the above works. Next step would be to
>> dump all
>> registers from the SuperIO chip.
>>
>> Guenter
>>
>>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
