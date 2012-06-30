From: Philipp Kraus <philipp.kraus@flashpixx.de>
Date: Sat, 30 Jun 2012 14:37:28 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <jsn2pu$qj$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 2012-06-30 16:21:25 +0200, Guenter Roeck said:

> On Sat, Jun 30, 2012 at 04:06:39PM +0200, Philipp Kraus wrote:
>> On 2012-06-30 15:41:06 +0200, Guenter Roeck said:
>>=20
>>> On Sat, Jun 30, 2012 at 07:52:06AM +0200, Philipp Kraus wrote:
>>>> Hello,
>>>>=20
>>>> I'm using on a dual xeon system lmsensors and pwmconfig for listing
>>>> and controlling the fan speed.
>>>> Lmsensors is configurated and checks the temperature of the CPUs,
>>>> but the fans rotate every time with
>>>> full speed:
>>>>=20
>>>> CPU1 Fan:    5555 RPM  (min =3D 2000 RPM)
>>>> CPU2 Fan:    5895 RPM  (min =3D 2000 RPM)
>>>>=20
>>>> CPU 1 Temp:   +50.0 C  (high =3D +75.0 C, hyst =3D +60.0 C)  sensor =
=3D Intel PECI
>>>> CPU 2 Temp:   +53.0 C  (high =3D +75.0 C, hyst =3D +60.0 C)  sensor =
=3D Intel PECI
>>>>=20
>>>> On booting up the fans have got around 2000 RPMs but some minuts the
>>>> system speeds up on idle status
>>>> Can you help me please to configure the options correctly, that the
>>>> RPMs are only gown up if needed?
>>>>=20
>>> Hi Phil,
>>>=20
>>> imagine you are an expert in the area. Then imagine someone sends you t=
his
>>> e-mail. Do you think you would be able to help based on the information=
 in the
>>> e-mail ?
>>>=20
>>> Or, in other words, please provide sufficient information for
>>> people to actually
>>> be able to help. Kernel version, lm-sensors version, complete sensors c=
ommand
>>> output, and all relevant configuration (including pwm configuration) wo=
uld be
>>> a start.
>>=20
>>=20
>> Sorry my mistake, I have forgot to past the full data (it was a
>> little bit early on this morning and I was tired):
>>=20
>> kernel version 3.2.11
>> lm sensors 3.3.1
>> Gentoo Linux 64 Bit
>>=20
>> pmwconfig found this devices
>> hwmon0/device is i5k_amb
>> hwmon1/device is w83793
>>=20
>> which are also used on lm sensors. The sensors config has stored
>> only the min/max values (the min values on the CPUs are set to 2000
>> RPM),
>> labels and some ignore values
>>=20
>> Only the two kernel modules are build
>> CONFIG_SENSORS_I5K_AMB=3Dm
>> CONFIG_SENSORS_W83793=3Dm
>> all other are disabled
>>=20
>> I hope this additional kernel modules are helpful:
>> CONFIG_THERMAL=3Dm
>> CONFIG_THERMAL_HWMON=3Dy
>> CONFIG_X86_THERMAL_VECTOR=3Dy
>> CONFIG_ACPI_THERMAL=3Dm
>>=20
>> I don't know which option can be modifies to change this settings
>> and where I can start my search to find the problem. If I boot up
>> the system the CPU
>> fans do some "pulse", so the speed rises up and slows down, rise up, ...=
....
>> If I run only once sensors the pulse is gone away, but the RPM increses
>>=20
> Do you have "fancontrol" running ? If yes, pelase provide the configurati=
on
> file. Also, please provide output of "grep . /sys/class/hwmon/hwmon1/devi=
ce/*"
> and the output of the "sensors" command.

sensors shows:

i5k_amb-isa-0000
Adapter: ISA adapter
Ch. 0 DIMM 0:  +71.5 C  (low  =3D +92.0 C, high =3D +124.0 C)
Ch. 0 DIMM 1:  +72.0 C  (low  =3D +102.0 C, high =3D +124.0 C)
Ch. 1 DIMM 0:  +73.5 C  (low  =3D +92.0 C, high =3D +124.0 C)
Ch. 1 DIMM 1:  +65.0 C  (low  =3D +102.0 C, high =3D +124.0 C)

w83793-i2c-0-2f
Adapter: SMBus I801 adapter at 1100
VcoreA:       +1.07 V  (min =3D  +0.93 V, max =3D  +1.49 V)
VcoreB:       +1.07 V  (min =3D  +0.93 V, max =3D  +1.49 V)
in2:          +1.01 V  (min =3D  +1.00 V, max =3D  +1.33 V)
in3:          +0.53 V  (min =3D  +0.38 V, max =3D  +0.69 V)
in4:          +0.56 V  (min =3D  +0.50 V, max =3D  +1.65 V)
in5:          +3.41 V  (min =3D  +2.96 V, max =3D  +3.63 V)
in6:          +0.99 V  (min =3D  +0.90 V, max =3D  +1.10 V)
+5V:          +5.07 V  (min =3D  +4.52 V, max =3D  +5.50 V)
5VSB:         +5.12 V  (min =3D  +4.52 V, max =3D  +5.50 V)
Vbat:         +3.23 V  (min =3D  +2.70 V, max =3D  +3.30 V)
Front Fan1:  1914 RPM  (min =3D 1500 RPM)
Front Fan2:  2076 RPM  (min =3D 1500 RPM)
Rear Fan1:   1277 RPM  (min =3D  900 RPM)
CPU1 Fan:    6250 RPM  (min =3D 2000 RPM)
CPU2 Fan:    6221 RPM  (min =3D 2000 RPM)
CPU 1 Temp:   +52.0 C  (high =3D +75.0 C, hyst =3D +60.0 C)  sensor =3D Int=
el PECI
CPU 2 Temp:   +54.0 C  (high =3D +75.0 C, hyst =3D +60.0 C)  sensor =3D Int=
el PECI
RAM 1 Temp:   +75.2 C  (high =3D +87.0 C, hyst =3D +82.0 C)  sensor =3D Int=
el PECI
RAM 2 Temp:   +78.0 C  (high =3D +87.0 C, hyst =3D +82.0 C)  sensor =3D Int=
el PECI
System Temp:  +47.0 C  (high =3D +75.0 C, hyst =3D +70.0 C)  sensor =3D the=
rmistor
cpu0_vid:    +2.050 V
intrusion0:  OK
beep_enable: disabled

the grep command shows
grep: /sys/class/hwmon/hwmon1/device/driver: Is a directory
grep: /sys/class/hwmon/hwmon1/device/hwmon: Is a directory
grep: /sys/class/hwmon/hwmon1/device/power: Is a directory
grep: /sys/class/hwmon/hwmon1/device/subsystem: Is a directory

and within the directory are the in*, pwm* temp* files

I have only configures lm sensors and setup the values with pwmconfig,=20
that has create the /etc/fancontrol file with this content
INTERVAL=10
DEVPATH=3Dhwmon1=DEvices/pci0000:00/0000:00:1f.3/i2c-0/0-002f
DEVNAME=3Dhwmon1=3Dw83793
FCTEMPSFCFANS=3Dhwmon1/device/pwm2MINTEMPMAXTEMPMINSTARTMINSTOP
Thanks

Phil



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
