From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Mar 2013 07:06:09 +0000
Subject: Re: [lm-sensors] ASRock 990FX Extreme3
Message-Id: <20130305070609.GC10027@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201303041827.00388.fredrick.o.jackson@gmail.com>
In-Reply-To: <201303041827.00388.fredrick.o.jackson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Mar 04, 2013 at 06:27:00PM -0600, Fredrick O Jackson wrote:
>=20
> I have an ASRock 990FX Extreme3 board that I'd REALLY like to be able to =

> monitor the temperature of.  I'm no expert at lmsensors and despite days =
of=20
> effort, I cannot determine how to configure lmsensors for this board. My =
temps=20
> dont match the hardware monitor in the bios. Some of the fans and voltage=
s are=20
> also wrong.=20
>=20
> I'd be willing to pay for some effective advice or a config file for this=
 board.=20
> I appreciate any help.
>=20
> thanks
> Fred
>=20
>=20
>=20
>=20
> sample output of sensors after running sensors-detect
>=20
>=20
> fam15h_power-pci-00c4
> Adapter: PCI adapter
> power1:       37.73 W  (crit =3D 124.95 W)
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +20.6=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)
>=20
> radeon-pci-0100
> Adapter: PCI adapter
> temp1:        +56.5=B0C =20
>=20
> nct6776-isa-0290
> Adapter: ISA adapter
> Vcore:        +0.92 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:          +1.86 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> AVCC:         +3.28 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:        +3.28 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:          +1.51 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> in5:          +1.74 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> 3VSB:         +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:         +3.38 V  (min =3D  +2.70 V, max =3D  +3.63 V)

Here is the matching data from wthe ASrock tool:

<Voltage Enable=3D"1">
        <Item Index=3D"0" Name=3D"CPU_VCORE_V" Enable=3D"1">Vcore Voltage</=
Item>
	<Item Index=3D"1" Name=3D"P3P3_V" Enable=3D"1">+3.3V Voltage</Item>
	<Item Index=3D"2" Name=3D"P5P0_V" Enable=3D"1">+5.0V Voltage</Item>
	<Item Index=3D"3" Name=3D"P12_V" Enable=3D"1">+12V Voltage</Item>
	<Item Index=3D"4" Name=3D"CPU_NB_V" Enable=3D"1" VoltageControl=3D"CPU_NB_=
V">CPU NB Voltage</Item>
	<Item Index=3D"5" Name=3D"DRAM_V" Enable=3D"1" VoltageControl=3D"DRAM_V">D=
RAM Voltage</Item>
	<Item Index=3D"6" Name=3D"NB_V" Enable=3D"1" VoltageControl=3D"NB_V">NB Vo=
ltage</Item>
	<Item Index=3D"7" Name=3D"HT_V" Enable=3D"1" VoltageControl=3D"HT_V">HT Vo=
ltage</Item>
	<Item Index=3D"8" Name=3D"SB_V" Enable=3D"1" VoltageControl=3D"SB_V">SB Vo=
ltage</Item>
</Voltage>

With this information, check out http://www.lm-sensors.org/wiki/VoltageLabe=
lsAndScaling
to help you determine scaling factors.

> fan1:           0 RPM  (min =3D    0 RPM)  ALARM
> fan2:        2036 RPM  (min =3D    0 RPM)  ALARM
> fan3:           0 RPM  (min =3D    0 RPM)  ALARM
> fan4:           0 RPM  (min =3D    0 RPM)  ALARM
> fan5:           0 RPM  (min =3D    0 RPM)  ALARM

fan1 should be connected to the chassis fan.

fan2 is multiplexed to the two CPU fans through gpio pins.
You can select one of the two with the commands provided in
https://github.com/groeck/nct6775/blob/master/README.ASRock
Use the commands provided for the ASRock 970 Extreme4.

fan3..5 are not connected to the NCT6776; don't ask me why. They are connec=
ted
to memory mapped IO. Here is the data from Asus:

<Item Name=3D"FAN1" Bank=3D"6" HighReg=3D"0x56" LowReg=3D"0x57">SYSFANIN</I=
tem>
<Item Name=3D"FAN2" Bank=3D"6" HighReg=3D"0x58" LowReg=3D"0x59" SwitchInter=
face=3D"SIO_GPIO" SwitchControl=3D"GPIO16=3DLow, GPIO10=3DHigh">CPUFANIN</I=
tem>
<Item Name=3D"FAN3" Interface=3D"MMIO" BaseAddress=3D"0xFED80400" ReadingRe=
g=3D"0x73" WritingReg=3D"0x23">AUXFANIN</Item>
<Item Name=3D"FAN4" Interface=3D"MMIO" BaseAddress=3D"0xFED80400" ReadingRe=
g=3D"0x69" WritingReg=3D"0x03">AUXFANIN0</Item>
<Item Name=3D"FAN5" Interface=3D"MMIO" BaseAddress=3D"0xFED80400" ReadingRe=
g=3D"0x6E" WritingReg=3D"0x13" >AUXFANIN1</Item>
<Item Name=3D"FAN6" Bank=3D"6" HighReg=3D"0x58" LowReg=3D"0x59" SwitchInter=
face=3D"SIO_GPIO" SwitchControl=3D"GPIO16=3DHigh, GPIO10=3DLow">CPUFANIN2</=
Item>

Unfortunately, there is no driver available for the memory mapped fans.

Hope that helps a bit.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
