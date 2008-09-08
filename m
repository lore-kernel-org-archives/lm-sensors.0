From: Dean Loros <autocrosser1@gmail.com>
Date: Mon, 08 Sep 2008 13:58:02 +0000
Subject: Re: [lm-sensors] EVGA nForce 750i motherboard
Message-Id: <48C52F6A.2040502@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C49CDE.7090800@gmail.com>
In-Reply-To: <48C49CDE.7090800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Updated info below----

Jean Delvare wrote:
> On Mon, 08 Sep 2008 01:48:39 -0700, Dean Loros wrote:
>> Hi Jean---
>>
>> Unloaded both. Dump for isadump 0x295 0x296:
>>
>> dean@linux:~/Desktop$ sudo isadump 0x295 0x296
>> [sudo] password for dean:
>> WARNING! Running this program can cause system crashes, data loss and wo=
rse!
>> I will probe address register 0x295 and data register 0x296.
>> Continue? [Y/n] y
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00: 04 ff 04 21 31 00 1e 50 01 02 01 02 3c 3c 0a 0a
>> 10: 04 ff 50 00 00 01 01 3c 43 07 00 00 ff ff ff d8
>> 20: a0 83 d0 d0 a0 c2 e6 5a e1 41 ff cb 88 cb 74 d9
>> 30: 90 ff db ff fe 00 00 00 01 00 7f fe a9 3f b9 68
>> 40: 01 de 1f ff ff ff 07 d4 2d 00 40 44 18 15 01 a3
>> 50: 21 80 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff
>> 60: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff
>> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> 80: 04 ff 04 21 31 00 1e 50 01 02 01 02 3c 3c 0a 0a
>> 90: 04 ff 50 00 00 01 01 3c 43 07 00 00 ff ff ff d8
>> a0: a0 83 d0 d0 a0 c2 e6 5a e1 41 ff cb 88 cb 74 d9
>> b0: 90 ff db ff fe 00 00 00 01 00 7f fe a9 3f b9 68
>> c0: 01 00 10 ff ff ff 07 d4 2d 00 40 44 18 15 01 a3
>> d0: 21 80 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff
>> e0: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff
>> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>
>> Interesting about i2cdump 1 0x2d b:
>>
>> dean@linux:~/Desktop$ sudo i2cdump 1 0x2d b
>> sudo: i2cdump: command not found
>=20
> i2cdump is no longer part of lm-sensors and is now part of a separate
> package named i2c-tools. Please install that package first and then you
> should have i2cdump. When you have it, please run the isadump command
> as well, it's better to have both dumps done at the same time for
> comparison purposes.

dean@linux:~/Desktop$ sudo i2cdump 1 0x2d b
[sudo] password for dean:
Error: Could not open file `/dev/i2c-1' or `/dev/i2c/1': No such file or
directory
dean@linux:~/Desktop$ sudo isadump
Syntax for I2C-like access:
  isadump [-y] [-k V1,V2...] ADDRREG DATAREG [BANK [BANKREG]]
Syntax for flat address space:
  isadump [-y] -f ADDRESS [RANGE [BANK [BANKREG]]]

Still problems there---please tell me the range you need
>=20
>> I got from BIOS:
>> CPU temp@c
>> board temp5c
>>
>> So I don't know where the 98c is coming from....
>=20
> Could be that temp1 isn't wired at all. Does it change in a consistent
> way depending in the system load?

Not really--only seems to vary about 10c

I suspect that temp2 is the CPU
> temperature and temp3 is the system temperature on your system. This
> would lead to the following configuration section:
>=20
>    label  temp2  "CPU Temp"
>    label  temp3  "Sys Temp"
>=20
>    set temp2_max      62
>    set temp2_max_hyst 58
>    set temp3_max      45
>    set temp3_max_hyst 42
>=20
> And if you can't make sense of temp1, you can add:
>=20
>    ignore temp1
>=20
>> After reloading the w83627ehf I get:
>>
>> dean@linux:~/Desktop$ sensors
>> acpitz-virtual-0
>> Adapter: Virtual device
>> temp1:       +40.0=B0C  (crit =3D +60.0=B0C)
>>
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:      +39.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>>
>> coretemp-isa-0001
>> Adapter: ISA adapter
>> Core 1:      +46.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>>
>> coretemp-isa-0002
>> Adapter: ISA adapter
>> Core 2:      +42.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>>
>> coretemp-isa-0003
>> Adapter: ISA adapter
>> Core 3:      +44.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>>
>> w83627dhg-isa-0290
>> Adapter: ISA adapter
>> VCore:       +1.27 V  (min =3D  +1.09 V, max =3D  +1.62 V)
>> in1:         +6.92 V  (min =3D  +6.12 V, max =3D +10.72 V)
>> AVCC:        +3.33 V  (min =3D  +2.30 V, max =3D  +3.47 V)
>> 3VCC:        +3.33 V  (min =3D  +3.50 V, max =3D  +4.08 V)   ALARM
>> in4:         +1.28 V  (min =3D  +2.03 V, max =3D  +2.04 V)   ALARM
>> in5:         +1.55 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
>> in6:         +5.89 V  (min =3D  +0.03 V, max =3D  +0.00 V)   ALARM
>> VSB:         +3.33 V  (min =3D  +1.57 V, max =3D  +0.02 V)   ALARM
>> VBAT:        +3.02 V  (min =3D  +0.10 V, max =3D  +1.54 V)   ALARM
>> Case Fan:   3000 RPM  (min =3D 2657 RPM, div =3D 2)
>> CPU Fan:    2556 RPM  (min =3D  998 RPM, div =3D 8)
>> Aux Fan:       0 RPM  (min =3D 10887 RPM, div =3D 4)  ALARM
>> fan4:       1638 RPM  (min =3D  912 RPM, div =3D 8)
>> fan5:          0 RPM  (min =3D    0 RPM, div =3D 2)  ALARM
>> Sys Temp:    +90.0=B0C  (high =3D  +0.0=B0C, hyst =3D +127.0=B0C)  senso=
r =3D thermistor
>> CPU Temp:    +33.0=B0C  (high =3D +127.0=B0C, hyst =3D  +0.0=B0C)  senso=
r =3D transistor
>> AUX Temp:    +34.5=B0C  (high =3D +127.0=B0C, hyst =3D  +0.0=B0C)  senso=
r =3D thermistor
>>
>>
>> Sensors is not reading a critical fan speed--nForce northbridge.
>=20
> Is the BIOS displaying it? How many wires does this fan have?

Yes--it is a three-wire connector
>=20
> Remember that the default labels in sensors3.conf may not match your
> motherboard.
Understood
>=20
> Also, the w83627ehf driver is adjusting the fan clock divisors
> automatically, so it may take a couple runs of "sensors" before fan
> speeds show.

Understood--as you can see, there are two speeds not showing--I would
guess that it "should" be one of those, but they do not have speed
outputs still. The Northbridge speed is around 2000 in the BIOS.

>=20
>> Sensors-detect requested that both the lm78 & w83627ehf get
>> loaded..running the latest Ubuntu kernel 2.6.27-2-generic
>=20
> OK. When I received your dumps, I'll fix sensors-detect so that it
> handles this case properly and no longer suggest the lm78 driver. I'll
> also update fix the lm78 driver so that it refuses to attach to
> W83627EHF and DHG chips.
>=20
> Thanks,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
