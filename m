From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sat, 19 Apr 2008 20:51:37 +0000
Subject: Re: [lm-sensors] lm-sensors dme1737 driver
Message-Id: <191fb4ca0804191351p1459f2c2g8d61e0170e32262e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Antonio,

CC'ing the list for others to enjoy :-)


> Hi Juerg:
>
> I am using sensors version 3.0.1 with libsensors version 3.0.1, with driv=
er
> dme1737 kernel 2.6.25 in 8 Sun Fire X2100 servers. I get the following
> output from sensors and ipmitool (ipmitool give similar results than BIOS
> HWMON so I think that everything is correct):
>
> eye4:~# sensors
>
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +31.0=B0C
> Core1 Temp:  +32.0=B0C
>
>
> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 1c00
> V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +3.37 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:        +11.93 V  (min =3D  +0.00 V, max =3D +15.94 V)
> V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:        +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  CPU_Fan:    9608 RPM  (min =3D  800 RPM)
> Fan2:       2965 RPM  (min =3D  800 RPM)
> Fan3:       4169 RPM  (min =3D  800 RPM)
> Fan4:       9358 RPM  (min =3D  800 RPM)
> RD1 Temp:    +40.3=B0C  (low  =3D -20.0=B0C, high =3D +80.0=B0C)
>  Int Temp:    +28.6=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> CPU Temp:    +25.1=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> cpu0_vid:   +1.550 V
>
> dme1737-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 1c40
> V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +3.37 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:        +11.93 V  (min =3D  +0.00 V, max =3D +15.94 V)
> V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:        +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>  CPU_Fan:    9608 RPM  (min =3D  800 RPM)
> Fan2:       2963 RPM  (min =3D  800 RPM)
> Fan3:       4169 RPM  (min =3D  800 RPM)
> Fan4:       9342 RPM  (min =3D  800 RPM)
> RD1 Temp:    +41.1=B0C  (low  =3D -20.0=B0C, high =3D +80.0=B0C)
>  Int Temp:    +28.6=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> CPU Temp:    +25.2=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> cpu0_vid:   +1.550 V

Two dme1737 detected? That looks fishy. According to some SUN
documents, there's only a single Super-IO in the X2100 server. Could
it be that you have two i2c masters connected to the same bus? Try to
write one of the temp limit registers in one dme1737 (see below) and
check if the value in the other one changes as well. That would
indicate a single dme1737 chip but seen twice by the driver.

Do
echo 100000 > /sys/class/hwmon/hwmon1/device/temp1_max
followed by 'sensors'. Check if both high limits for RD1 temp schow 100C no=
w.



> eye4:~# ipmitool sdr
> DDR 2.6V         | 2.60 Volts        | ok
> CPU core Voltage | 1.37 Volts        | ok
> VCC 3.3V         | 3.35 Volts        | ok
> VCC 5V           | 5.04 Volts        | ok
> VCC 12V          | 11.97 Volts       | ok
>  Battery Volt     | 2.99 Volts        | ok
> CPU TEMP         | 40 degrees C      | ok
> SYS TEMP         | 25 degrees C      | ok
> CPU FAN          | 9540 RPM          | ok
> SYSTEM FAN3      | 2970 RPM          | ok
>  SYSTEM FAN1      | 4140 RPM          | ok
> SYSTEM FAN2      | 9270 RPM          | ok
>
>
> Only some readings seem to be swapped, I will change them in the
> sensors.conf. But I get the following messages in
>
> eye4:~# grep "dme" /var/log/messages
> Apr 18 15:50:48 eye4 kernel: dme1737 0-002e: Found a DME1737 chip at 0x2e
> (rev 0x89).
> Apr 18 15:50:48 eye4 kernel: dme1737 0-002e: Optional features: pwm3=3Dye=
s,
> pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
>  Apr 18 15:50:48 eye4 kernel: dme1737 0-002e: Non-standard fan to pwm
> mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report to
> the driver maintainer.
> Apr 18 15:50:59 eye4 kernel: dme1737 0-002e: Read from register 0x32 fail=
ed!
> Please report to the driver maintainer.
>  Apr 18 16:36:47 eye4 kernel: dme1737 0-002e: Found a DME1737 chip at 0x2e
> (rev 0x89).
> Apr 18 16:36:47 eye4 kernel: dme1737 0-002e: Optional features: pwm3=3Dye=
s,
> pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
>  Apr 18 16:36:47 eye4 kernel: dme1737 0-002e: Non-standard fan to pwm
> mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report to
> the driver maintainer.
> Apr 18 16:36:47 eye4 kernel: dme1737 1-002e: Found a DME1737 chip at 0x2e
> (rev 0x89).
>  Apr 18 16:36:47 eye4 kernel: dme1737 1-002e: Optional features: pwm3=3Dy=
es,
> pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> Apr 18 16:36:47 eye4 kernel: dme1737 1-002e: Non-standard fan to pwm
> mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report to
> the driver maintainer.
>  Apr 18 16:37:44 eye4 kernel: dme1737 0-002e: Read from register 0x2d
> failed! Please report to the driver maintainer.
> Apr 18 16:39:52 eye4 kernel: dme1737 0-002e: Found a DME1737 chip at 0x2e
> (rev 0x89).
> Apr 18 16:39:52 eye4 kernel: dme1737 0-002e: Optional features: pwm3=3Dye=
s,
> pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
>  Apr 18 16:39:52 eye4 kernel: dme1737 0-002e: Non-standard fan to pwm
> mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report to
> the driver maintainer.
> Apr 18 16:39:52 eye4 kernel: dme1737 1-002e: Found a DME1737 chip at 0x2e
> (rev 0x89).
>  Apr 18 16:39:52 eye4 kernel: dme1737 1-002e: Optional features: pwm3=3Dy=
es,
> pwm5=3Dno, pwm6=3Dno, fan3=3Dyes, fan4=3Dyes, fan5=3Dno, fan6=3Dno.
> Apr 18 16:39:52 eye4 kernel: dme1737 1-002e: Non-standard fan to pwm
> mapping: fan1->pwm1, fan2->pwm2, fan3->pwm1, fan4->pwm3. Please report to
> the driver maintainer.
>  Apr 18 16:43:03 eye4 kernel: dme1737 0-002e: Read from register 0x52
> failed! Please report to the driver maintainer.
> Apr 18 17:29:52 eye4 kernel: dme1737 0-002e: Read from register 0x48 fail=
ed!
> Please report to the driver maintainer.
>  Apr 18 17:29:52 eye4 kernel: dme1737 0-002e: Read from register 0x4c
> failed! Please report to the driver maintainer.
> Apr 18 17:29:52 eye4 kernel: dme1737 0-002e: Read from register 0x9b fail=
ed!
> Please report to the driver maintainer.
>  Apr 18 17:29:53 eye4 kernel: dme1737 1-002e: Read from register 0x2c
> failed! Please report to the driver maintainer.
> Apr 19 10:02:15 eye4 kernel: dme1737 0-002e: Read from register 0x6b fail=
ed!
> Please report to the driver maintainer.

Hmm... did you reload the dme1737 module multiple times? Can you
unload the module, reload it and send the messages generated from that
single module load operation?


>
> Is everything OK?

Not really :-) The failed register reads and non-standard fan-pwm
mappings aren't good. Maybe there's a conflict with ACPI (or IPMI).
I'm assuming you have a bmc or ipmi module loaded. Can you send the
outputs of 'lsmod' and 'lspci -vnn'? And please run 'cat
/proc/acpi/dsdt > dsdt.aml' and send me the dsdt.aml file in private.
Try unloading the ipmi/bmc module and reload the dme1737 module and
check if the read errors went away.

...juerg



> If you need more information about hardware or software setup, plz, don't
> hesitate to ask me.
>
> I would like to thank you for the development of the dme driver... It was
> long time awaited!
>
> Best regards,
>
> Antonio Exp=F3sito

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
