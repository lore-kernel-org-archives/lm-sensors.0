From: David Mathog <dmathog@gmail.com>
Date: Sat, 20 Nov 2010 17:33:07 +0000
Subject: Re: [lm-sensors] it8726 chip?
Message-Id: <AANLkTinNkFTJ=yJ+k73WiQtotUfZEpVSSBMvgHv5-p6H@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinP-Bk2MQugbyCz03uwEnLv3si5nvnYX1o-bJae@mail.gmail.com>
In-Reply-To: <AANLkTinP-Bk2MQugbyCz03uwEnLv3si5nvnYX1o-bJae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> This is the old default section, which apparently doesn't apply to your
> board at all, so you should forget about it and start again from
> scratch. The new default section for that chip is almost empty and
> reads:
>
> chip "it87-*" "it8712-*" "it8716-*" "it8718-*" "it8720-*"
>
> =A0 =A0label in8 "Vbat"
>
>> Kernel is from ubuntu 8.10, 2.6.27-11-generic. =A0Sensors is 3.0.2
>>
>> Any suggestions for improving these readings?
>
> Reboot, enter the BIOS setup screen, write down everything that's
> printed in the hardware monitoring section, including multiple values
> when a given entry oscillates between 2 or more values. The run sensors
> without a configuration file (sensors -c /dev/null), and report all the
> values here.

The BIOS reports very little.  Here it is:

CPU Vcore 1.24V
VDimm 1.87V
CPU Tcontrol 40C
System Temp 32C
CPU Fan Speed 3479, 3461 (alternating)
System Fan 0

and

%sensors -c /dev/null
acpitz-virtual-0
Adapter: Virtual device
temp1:       +15.0=C2=B0C  (crit =3D +75.0=C2=B0C)

k8temp-pci-00c3
Adapter: PCI adapter
temp1:       +16.0=C2=B0C
temp2:        +7.0=C2=B0C
temp3:        +4.0=C2=B0C
temp4:       +10.0=C2=B0C

it8716-isa-0228
Adapter: ISA adapter
in0:         +1.25 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in1:         +1.23 V  (min =3D  +1.28 V, max =3D  +1.68 V)   ALARM
in2:         +1.87 V  (min =3D  +2.78 V, max =3D  +3.78 V)   ALARM
in3:         +2.91 V  (min =3D  +2.67 V, max =3D  +3.26 V)
in4:         +1.22 V  (min =3D  +2.50 V, max =3D  +3.49 V)   ALARM
in5:         +2.48 V  (min =3D  +0.58 V, max =3D  +1.34 V)   ALARM
in6:         +1.81 V  (min =3D  +1.04 V, max =3D  +1.36 V)   ALARM
in7:         +2.82 V  (min =3D  +2.67 V, max =3D  +3.26 V)
in8:         +2.99 V
fan1:       3461 RPM  (min =3D   10 RPM)
fan2:          0 RPM  (min =3D   10 RPM)  ALARM
fan3:          0 RPM  (min =3D    0 RPM)
temp1:       +15.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +75.0=C2=B0C) =
 sensor thermal dio              de
temp2:       +34.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +75.0=C2=B0C) =
 sensor =3D transistor
temp3:        -8.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +75.0=C2=B0C) =
 sensor =3D transistor
cpu0_vid:   +1.000 V

(Ignore the =C2 characters, that's a unicode side effect on a terminal
emulator that doesn't do unicode.)

Thanks,

David Mathog

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
