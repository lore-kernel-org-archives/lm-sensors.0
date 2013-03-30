From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 30 Mar 2013 17:05:05 +0000
Subject: Re: [lm-sensors] [nct6775] Asrock 890FX Deluxe5 - Strange values and alarms (#6)
Message-Id: <20130330170505.GA28035@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Mar 30, 2013 at 08:54:57AM -0700, fizista wrote:
> Hi there.
>=20
> Look at this:
>=20
> Vcore:          +1.23 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:            +1.85 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> AVCC:           +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:          +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:            +0.10 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> in5:            +1.70 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> in6:            +0.10 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> 3VSB:           +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:           +3.39 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
> fan1:             0 RPM  (min =3D    0 RPM, div =3D 128)
> fan2:          3515 RPM  (min =3D    0 RPM, div =3D 8)
> fan3:             0 RPM  (min =3D    0 RPM, div =3D 128)
> SYSTIN:         +40.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALAR=
M  sensor =3D thermistor
> CPUTIN:         +31.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D thermistor
> AUXTIN:        +127.5=B0C  (high =3D +114.0=B0C, hyst =3D +114.0=B0C)  AL=
ARM  sensor =3D thermistor
> PCH_CHIP_TEMP:   +0.0=B0C =20
> PCH_CPU_TEMP:    +0.0=B0C =20
> PCH_MCH_TEMP:    +0.0=B0C=20
>=20
> FAN3 should be about 700RPM (the value I saw in the BIOS)
>=20

Hi,

The ASRock configuration utility specifies for this board:

<Fan Enable=3D"1">
    <Item Index=3D"0" Name=3D"CPU_TEMP" Enable=3D"1" Control=3D"Temperature=
">CPU Temperature</Item>
    <Item Index=3D"1" Name=3D"MB_TEMP" Enable=3D"1" Control=3D"Temperature"=
>M/B Temperature</Item>
    <Item Index=3D"2" Name=3D"FAN2" Enable=3D"1" Control=3D"FanReading">CPU=
 Fan1 Speed</Item>
    <Item Index=3D"3" Name=3D"FAN6" Enable=3D"1" Control=3D"FanReading">CPU=
 Fan2 Speed</Item>
    <Item Index=3D"4" Name=3D"FAN1" Enable=3D"1" Control=3D"FanReading">Cha=
ssis Fan1 Speed</Item>
    <Item Index=3D"5" Name=3D"FAN4" Enable=3D"1" Control=3D"FanReading">Cha=
ssis Fan2 Speed</Item>
    <Item Index=3D"6" Name=3D"FAN5" Enable=3D"1" Control=3D"FanReading">Cha=
ssis Fan3 Speed</Item>
    <Item Index=3D"7" Name=3D"FAN3" Enable=3D"1" Control=3D"FanReading">Pow=
er Fan Speed</Item>
</Fan>

</HardwareMonitor>
    <FanControl Enable=3D"1" AutoApply=3D"0">
    <Item Name=3D"FAN2" Enable=3D"1" Interface=3D"SIO_FAN" SmartFan=3D"1" A=
pplyValue=3D"" ModelName=3D"P67E4"
	SelectValue=3D"0" TempSelectValue=3D"0">CPU FAN1; CPU FAN2</Item>
    <Item Name=3D"FAN1" Enable=3D"1" Interface=3D"SIO_FAN" SmartFan=3D"1" A=
pplyValue=3D"" ModelName=3D"P67E4"
	SelectValue=3D"0"> CHASSIS FAN1</Item>
    <Item Name=3D"FAN4" Enable=3D"1" Interface=3D"MMIO" BaseAddress=3D"0xFE=
D80400" ReadingReg=3D"0x69"
	WritingReg=3D"0x03" ApplyValue=3D"" ModelName=3D"P67E4" SelectValue=3D"0">=
CHASSIS FAN2</Item>
    <Item Name=3D"FAN5" Enable=3D"1" Interface=3D"MMIO" BaseAddress=3D"0xFE=
D80400" ReadingReg=3D"0x6E"
	WritingReg=3D"0x13" ApplyValue=3D"" ModelName=3D"P67E4" SelectValue=3D"0">=
CHASSIS FAN3</Item>
</FanControl>

<FanReading Enable=3D"1">
    <Item Name=3D"FAN1" Bank=3D"6" HighReg=3D"0x56" LowReg=3D"0x57">SYSFANI=
N</Item>
    <Item Name=3D"FAN2" Bank=3D"6" HighReg=3D"0x58" LowReg=3D"0x59" SwitchI=
nterface=3D"SIO_GPIO"
	SwitchControl=3D"GPIO80=3DLow, GPIO87=3DHigh">CPUFANIN</Item>
    <Item Name=3D"FAN3" Interface=3D"MMIO" BaseAddress=3D"0xFED80400" Readi=
ngReg=3D"0x73"
	WritingReg=3D"0x23">AUXFANIN</Item>
    <Item Name=3D"FAN4" Interface=3D"MMIO" BaseAddress=3D"0xFED80400" Readi=
ngReg=3D"0x69"
	WritingReg=3D"0x03">AUXFANIN0</Item>
    <Item Name=3D"FAN5" Interface=3D"MMIO" BaseAddress=3D"0xFED80400" Readi=
ngReg=3D"0x6E"
	WritingReg=3D"0x13" >AUXFANIN1</Item>
    <Item Name=3D"FAN6" Bank=3D"6" HighReg=3D"0x58" LowReg=3D"0x59" SwitchI=
nterface=3D"SIO_GPIO"
	SwitchControl=3D"GPIO80=3DHigh, GPIO87=3DLow">CPUFANIN2</Item>
</FanReading>

Translating this, fan2 (the one with the high reading) would be one of
the CPU fans. The CPU fans are pin multiplexed, meaning you'll never know
which one of the fan speeds is really reported, as the pin multiplexing
is not supported by Linux. I have no idea why it reads such a high speed.
Is this a standard fan ?

Fans 3..5 are read via direct MMIO, ie not through the NCT6775, and also not
supported in Linux. If you want to see the speed of a chassis fan, you would
have to connect it to the header for chassis fan 1.

The alarms are because the min/max values are not configured. You would
have to specify limits in the configuration file and apply as appropriate.

There is a scaling factor for most of the voltages, but unfortunately the A=
SRock
utility doesn't specify it, or I don't know how to interpret it. So you'll =
have
to figure it out based on the raw voltages.

See http://www.lm-sensors.org/wiki/Configurations/ASRock/AM2NF3-VSTA for an
example configuration file for another ASRock board, and
http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling for how to find the
specific values for your board.

Copying the lm-sensors mailing list for additional input.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
