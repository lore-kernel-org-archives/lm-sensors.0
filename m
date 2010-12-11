From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Sat, 11 Dec 2010 07:02:02 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <50880.75.142.173.238.1292050922.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juerg,

> Hi Jeff,
>
>>> Ah. I just realized that the SCH5127 has another voltage input that
>>> the other dme1737 clones don't have but which isn't exposed through
>>> the driver. Register 0x1f, nominal 1.5V, max 2.0V.
>>
>> Ah ah! Very interesting. It could be where Jeff's mysterious +1.5V is
>> connected! Could you write a patch adding support?
>
> Attached is a modified driver with support for Vtrip monitoring (1.5V,
> in7). Could you give it a try and let me know how it goes? The new
> driver should expose the following new sysfs files: in7_input,
> in7_min, in7_max, in7_alarm. No user-level scaling is required. The
> nominal voltage is 1.5V.
>
> Thanks
> ...Juerg
>

I successfully compiled the module. Then I removed the old module with
"modprobe -r dme1737". Next I copied the new "dme1737.ko" module into the
proper location in "/lib/modules/`uname -r`/kernel/drivers/hwmon" and set
the proper permissions with "chmod"; FC14 uses permissions of '744'. Now I
installed the kernel module with "modprobe -v dme1737" and the Console
printed the following:

insmod /lib/modules/2.6.35.9-64.fc14.x86_64/kernel/drivers/hwmon/hwmon-vid.=
ko
insmod /lib/modules/2.6.35.9-64.fc14.x86_64/kernel/drivers/hwmon/dme1737.ko

So far so good.....

Now I ran "sensors" without any changes to my "/etc/sensors.d/local.conf"
file.

[root@anas-01 ~]# sensors
sch5127-isa-0870
Adapter: ISA adapter
in0:         +1.78 V  (min =3D  +0.00 V, max =3D  +3.32 V)
Vccp:        +1.19 V  (min =3D  +1.08 V, max =3D  +1.32 V)
VCC:         +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
in3:         +1.14 V  (min =3D  +0.00 V, max =3D  +1.49 V)
in4:         +1.48 V  (min =3D  +0.00 V, max =3D  +1.49 V)
VTR:         +3.33 V  (min =3D  +2.97 V, max =3D  +3.63 V)
VBAT:        +3.24 V  (min =3D  +2.70 V, max =3D  +3.30 V)
in7:         +0.72 V  (min =3D  +1.99 V, max =3D  +0.25 V)
Side Fan:   1884 RPM  (min =3D  700 RPM)
MCH Fan:    5027 RPM  (min =3D 4500 RPM)
CPU Temp:    +40.1=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
SYS Temp:    +32.9=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)

For the record I have "blacklisted" the 'coretemp' module on this machine
as it reports strange temp values (anything from ~9C to ~15C and those are
too cold) for an Intel Atom 230 CPU (per "/proc/cpuinfo": CPU family 6,
model 28, stepping 2) compared to the "CPU Temp" value reported by
'sensors'.

"in7" is now reported but it will require a "compute (@ * 2), (@ / 2)"
line in my "/etc/sensors.d/local.conf" to provide a reasonable value of
1.44: 0.72 * 2 =3D 1.44, which is close enough to the BIOS reported +1.5V
value.

Both "in3" and "in4" are "unknowns" to me. I know they will be external
voltage inputs to the SCH5127, but it's a guess as to what is being
measured. I located a "service guide" for the Acer H340, but it is useless
in this regard. The same judgement applies to "in0". the remaining inputs
are marked per the kernel documentation notes written by Juerg.

Checking the BIOS screen for this machine shows the "V+1.5" reading out a
steady ~1.5V.

Also, a comment for Jean. I pulled the CMOS battery and booted the
machine...before making this kernel module change. I did not see any
change in the BIOS reported value for "VBAT" and "sensors" did not see any
reported change; BIOS reported +3.20V and "sensors" reported +3.24V.
Perhaps Acer makes that measurement ahead of the CMOS battery on the "+"
voltage line? I wonder why. Or perhaps I don't understand what "VBAT" is
supposed to measure.

Finally, for good measure I ran "depmod -a" and rebooted the machine. The
'updated' dme1737.ko module is correctly loaded on reboot.

Dec 11 00:59:00 anas-01 kernel: [   24.137243] dme1737 dme1737.2160: Found
a SCH5127 chip at 0x0870
Dec 11 00:59:00 anas-01 kernel: [   24.167411] dme1737 dme1737.2160:
Optional features: pwm3=3Dyes, pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dno,=
 fan5=3Dno,
fan6=3Dno.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
