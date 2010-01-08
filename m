From: Marcus Vogt <issaqua@gmail.com>
Date: Fri, 08 Jan 2010 21:51:31 +0000
Subject: Re: [lm-sensors] SMSC SCH5147-NW not detected / supported
Message-Id: <4cb1b6761001081351m2311c45cs47ad04c19be957bb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4cb1b6761001031453g147d8dcbj413a3e74d15c372@mail.gmail.com>
In-Reply-To: <4cb1b6761001031453g147d8dcbj413a3e74d15c372@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

That worked a treat:

sch311x-isa-0a70
Adapter: ISA adapter
in0:         +1.79 V  (min =3D  +0.00 V, max =3D  +3.32 V)
in1:         +0.69 V  (min =3D  +0.00 V, max =3D  +1.99 V)
in2:         +3.36 V  (min =3D  +0.00 V, max =3D  +4.38 V)
in3:         +5.10 V  (min =3D  +0.00 V, max =3D  +6.64 V)
in4:        +11.91 V  (min =3D  +0.00 V, max =3D +15.94 V)
in5:         +3.27 V  (min =3D  +0.00 V, max =3D  +4.38 V)
in6:         +3.19 V  (min =3D  +0.00 V, max =3D  +4.38 V)
fan1:       1930 RPM  (min =3D    0 RPM)
fan2:       1887 RPM  (min =3D    0 RPM)
fan3:          0 RPM  (min =3D    0 RPM)
temp1:         FAULT  (low  =3D -127.0=B0C, high =3D +127.0=B0C)  ALARM
temp2:       +40.4=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
temp3:       +53.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
cpu0_vid:   +2.050 V

[   75.098685] ACPI: I/O resource dme1737 [0xa70-0xa71] conflicts with
ACPI region RNTR [0xa00-0xa7f]
[   75.098688] ACPI: This conflict may cause random problems and
system instability
[   75.098690] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[   75.098724] dme1737 dme1737.2672: Found a SCH311x chip at 0x0a70
[   75.098729] dme1737 dme1737.2672: Optional features: pwm3=3Dyes,
pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dno, fan5=3Dno, fan6=3Dno.

Is there anything I can do to help with this?  Any documentation or
the like I can do?

Cheers,

Marcus.

On Thu, Jan 7, 2010 at 7:44 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Tue, 5 Jan 2010 09:25:35 +1100, Marcus Vogt wrote:
>> Hi Juerg,
>>
>> Unfortunately that didn't work:
>>
>> root@ythekshri:~# modprobe =A0dme1737 force_id=3D0x7c
>> FATAL: Error inserting dme1737
>> (/lib/modules/2.6.31-16-generic-pae/kernel/drivers/hwmon/dme1737.ko):
>> Device or resource busy
>> root@ythekshri:~#
>>
>> dmesg reports:
>>
>> [ 1793.870444] ACPI: I/O resource dme1737 [0xa70-0xa71] conflicts with
>> ACPI region RNTR [0xa00-0xa7f]
>> [ 1793.870448] ACPI: If an ACPI driver is available for this device,
>> you should use it instead of the native driver
>
> This means that ACPI claimed the whole chip for its own use, preventing
> native drivers (dme1737 in your case) from using it.
>
> You can bypass this check by booting with acpi_enforce_resources=3Dlax,
> for testing purpose. I wouldn't recommend it as a permanent solution
> though, because if ACPI is really using the chip, the concurrent
> accesses are likely to conflict at some point with unpredictable (but
> generally bad) results.
>
>> root@ythekshri:~# cat /proc/ioports | grep a7
>> 0a00-0a7f : pnp 00:09
>> root@ythekshri:~#
>
>> On Tue, Jan 5, 2010 at 3:51 AM, Juerg Haefliger <juergh@gmail.com> wrote:
>> > Hi Marcus,
>> >
>> >
>> >>> Hi guys,
>> >>>
>> >>> I have a HP EX490 and it has a SMSC SCH5147-NW for monitoring (found
>> >>> via visual inspection of the board). =A0The vendor URL for this chip=
 is
>> >>> http://www.smsc.com/index.php?tid%4&pid=161
>> >>>
>> >>> This does not appear to be detected or supported via lm-sensors -
>> >>> though it does identify that there is a Super I/O SMSC device - the
>> >>> trimmed information from sensors-detect is as follows:
>> >>>
>> >>> =A0 =A0 =A0 Probing for Super-I/O at 0x2e/0x2f
>> >>> =A0 =A0 =A0 Trying family `SMSC'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Yes
>> >>> =A0 =A0 =A0 Found unknown chip with ID 0xc101
>
> Juerg, can you please add the chip to sensors-detect so that it is
> properly identified?
>
>> >>> Unfortunately, google does not appear to be able to find the data
>> >>> sheet for this chip and the only other references are for some Lenovo
>> >>> gear that use them.
>> >>>
>> >>> Any ideas on how I'd progress with this? =A0I'm happy to do testing =
and
>> >>> a bit of coding.
>> >>
>> >> I'll ask my contact at SMSC if he can provide a datasheet.
>> >
>> > The chip seems to be close to a SCH311x. Try loading the dme1737
>> > module with 'force_id=3D0x7c' module load parameter and report your
>> > results.
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
