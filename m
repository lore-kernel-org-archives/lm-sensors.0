From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Mon, 13 Dec 2010 04:02:13 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <49288.75.142.173.238.1292212933.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

> Hi Jeff,
>
> On Sat, 11 Dec 2010 01:02:02 -0600 (CST), Jeff Rickman wrote:
>> > Attached is a modified driver with support for Vtrip monitoring (1.5V,
>> > in7). Could you give it a try and let me know how it goes? The new
>> > driver should expose the following new sysfs files: in7_input,
>> > in7_min, in7_max, in7_alarm. No user-level scaling is required. The
>> > nominal voltage is 1.5V.
>>
>> I successfully compiled the module. Then I removed the old module with
>> "modprobe -r dme1737". Next I copied the new "dme1737.ko" module into
>> the
>> proper location in "/lib/modules/`uname -r`/kernel/drivers/hwmon" and
>> set
>> the proper permissions with "chmod"; FC14 uses permissions of '744'. Now
>> I
>> installed the kernel module with "modprobe -v dme1737" and the Console
>> printed the following:
>>
>> insmod
>> /lib/modules/2.6.35.9-64.fc14.x86_64/kernel/drivers/hwmon/hwmon-vid.ko
>> insmod
>> /lib/modules/2.6.35.9-64.fc14.x86_64/kernel/drivers/hwmon/dme1737.ko
>>
>> So far so good.....
>>
>> Now I ran "sensors" without any changes to my
>> "/etc/sensors.d/local.conf"
>> file.
>>
>> [root@anas-01 ~]# sensors
>> sch5127-isa-0870
>> Adapter: ISA adapter
>> in0:         +1.78 V  (min =3D  +0.00 V, max =3D  +3.32 V)
>> Vccp:        +1.19 V  (min =3D  +1.08 V, max =3D  +1.32 V)
>> VCC:         +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>> in3:         +1.14 V  (min =3D  +0.00 V, max =3D  +1.49 V)
>> in4:         +1.48 V  (min =3D  +0.00 V, max =3D  +1.49 V)
>> VTR:         +3.33 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>> VBAT:        +3.24 V  (min =3D  +2.70 V, max =3D  +3.30 V)
>> in7:         +0.72 V  (min =3D  +1.99 V, max =3D  +0.25 V)
>> Side Fan:   1884 RPM  (min =3D  700 RPM)
>> MCH Fan:    5027 RPM  (min =3D 4500 RPM)
>> CPU Temp:    +40.1=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
>> SYS Temp:    +32.9=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
>>
>> For the record I have "blacklisted" the 'coretemp' module on this
>> machine
>> as it reports strange temp values (anything from ~9C to ~15C and those
>> are
>> too cold) for an Intel Atom 230 CPU (per "/proc/cpuinfo": CPU family 6,
>> model 28, stepping 2) compared to the "CPU Temp" value reported by
>> 'sensors'.
>>
>> "in7" is now reported but it will require a "compute (@ * 2), (@ / 2)"
>> line in my "/etc/sensors.d/local.conf" to provide a reasonable value of
>> 1.44: 0.72 * 2 =3D 1.44, which is close enough to the BIOS reported +1.5V
>> value.
>
> Close enough? I wouldn't say that. Which value does the BIOS report
> exactly?

During 1 test run I kept the system "in the BIOS" on the "Hardware
Monitor" screen for almost an hour. The voltages never changed. I suspect
the vendor isn't reporting any measured voltages here; could be "static"
voltage values. As for the "V+1.5" value in the BIOS, it never changed
from "1.50". Never. Only the System Fan Speed (LM_Sensors 'Fan1'), CPU
Temp, and SYS Temp values ever change on this screen.

>
> BTW, you never clearly reported all exact voltage values reported by the
> BIOS. This would help a lot.

As displayed "in order" from the "Hardware Monitor" screen:

V+1.5 =3D 1.50 V
5VTR  =3D 4.90 V
VBAT  =3D 3.20 V
V+5   =3D 5 V
Vccp  =3D 1.20 V
VCC   =3D 3.30 V
VTR   =3D 3.30 V

>
> If you stay in the BIOS long enough to spot more than one value for
> each voltage, this can help deduce scaling factors.

As I write this email now, none of the voltages ever change, not even by
1/100 (0.01) of a Volt while sitting in the BIOS for almost an hour. I
hardly believe any power supply or system power rails are that stable,
based on experiences with other PC-style computers.

>
>> Both "in3" and "in4" are "unknowns" to me. I know they will be external
>> voltage inputs to the SCH5127, but it's a guess as to what is being
>> measured. I located a "service guide" for the Acer H340, but it is
>> useless
>> in this regard. The same judgement applies to "in0". the remaining
>> inputs
>> are marked per the kernel documentation notes written by Juerg.
>
> I believe that in4 isn't used. It's too close to the ADC's high limit
> to be useful. And the dme1737 driver now shows has one more voltage
> value than your BIOS does, right?
>
>> Checking the BIOS screen for this machine shows the "V+1.5" reading out
>> a
>> steady ~1.5V.
>
> 1.5 V is quite different from 1.44 V, so either it's not in7, or the
> scaling factor of 2 isn't correct.

1.44V is within +- 10 percent of 1.5V, but I agree that improvement is
needed; changing scaling values in LM_Sensors is a "math problem".

>
> Anyway, it beats me why the manufacturer would scale down a voltage
> which it could monitor directly. Very odd.

This entire Acer system is "very odd".

Why would a vendor set the system fan to ~760 rpm when HDD temperatures at
that level almost reach 50C and before any serious system load is applied?
50C is a dangerous threshold for most HDD. Thus I use "fancontrol" to
override that automatic setting and push fan speed to "full" to bring HDD
temps down to <@C. If there is a better method than "fancontrol" that I
can call from "rc.local" (like "echo 'value' > 'someplace in system'"), I
would appreciate it since there is no BIOS control for fan speed at all:
it's based on a "Phoenix TrustedCore" BIOS / Intel Shelton Reference BIOS.

>
>> Also, a comment for Jean. I pulled the CMOS battery and booted the
>> machine...before making this kernel module change. I did not see any
>> change in the BIOS reported value for "VBAT" and "sensors" did not see
>> any
>> reported change; BIOS reported +3.20V and "sensors" reported +3.24V.
>> Perhaps Acer makes that measurement ahead of the CMOS battery on the "+"
>> voltage line? I wonder why. Or perhaps I don't understand what "VBAT" is
>> supposed to measure.
>
> Vbat is measuring the voltage at the Vbat pin of the chip, which is
> supposed to be connected to the battery.
>
> Now it is possible that the board designer decided to also connect
> +3.3V or 3VSB there, so that the battery is only used when other power
> sources aren't available, to extend the battery's life. This makes
> sense, but makes monitoring of Vbat useless, of course. This would
> explain the relatively high Vbat value. CR2032 batteries are rated at
> 3.0V, not 3.3V.
>
>> Finally, for good measure I ran "depmod -a" and rebooted the machine.
>> The
>> 'updated' dme1737.ko module is correctly loaded on reboot.
>>
>> Dec 11 00:59:00 anas-01 kernel: [   24.137243] dme1737 dme1737.2160:
>> Found
>> a SCH5127 chip at 0x0870
>
> Strange. The address is different from the one sensors-detect reported
> (0x800.)
>
>> Dec 11 00:59:00 anas-01 kernel: [   24.167411] dme1737 dme1737.2160:
>> Optional features: pwm3=3Dyes, pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3D=
no,
>> fan5=3Dno,
>> fan6=3Dno.
>
> --
> Jean Delvare
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
