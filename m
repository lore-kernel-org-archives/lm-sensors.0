From: Stefan Sassenberg <stefan.sassenberg@gmx.de>
Date: Wed, 05 Mar 2008 16:09:02 +0000
Subject: Re: [lm-sensors] No sensors found >2.6.21, w83627hf, ICH6
Message-Id: <47CEC59E.5030302@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <47CD5B89.1070302@gmx.de>
In-Reply-To: <47CD5B89.1070302@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Wed, 05 Mar 2008 15:57:14 +0100, Stefan Sassenberg wrote:
>> Jean Delvare wrote:
>>> On Wed, 05 Mar 2008 11:31:30 +0100, Stefan Sassenberg wrote:
>>>> Jean Delvare wrote:
>>> I didn't notice at first but you wrote you were using lm-sensors 2.9.1.
>>> That's pretty old. In kernel 2.6.22 the w83627hf driver was converted
>>> from an i2c-isa driver to a platform driver (together with many other
>>> hwmon driver, as we were finally getting rid of i2c-isa.) Support for
>>> platform drivers was added to lm-sensors only in 2.10.0. So, no
>>> surprise it doesn't work for you. For a kernel >=3D 2.6.22, I would even
>>> recommend lm-sensors >=3D 2.10.3.
>>>
>> Very good. I could download deb packages of version 2.10.1. The next=20
>> version is 2.10.5 but there seem to be no lmsensors package of that=20
>> version for now. But now I get results:
>>
>> w83627thf-isa-0290
>> Adapter: ISA adapter
>> VCore:     +1.25 V  (min =3D  +0.70 V, max =3D  +1.87 V)
>> +12V:     +11.98 V  (min =3D  +6.51 V, max =3D  +9.18 V)       ALARM
>> +3.3V:     +3.36 V  (min =3D  +0.26 V, max =3D  +0.19 V)       ALARM
>> +5V:       +5.04 V  (min =3D  +2.72 V, max =3D  +3.28 V)       ALARM
>> -12V:     -12.20 V  (min =3D  +3.27 V, max =3D -14.75 V)       ALARM
>> V5SB:      +5.05 V  (min =3D  +4.27 V, max =3D  +1.61 V)       ALARM
>> VBat:      +3.22 V  (min =3D  +3.04 V, max =3D  +3.92 V)
>> fan1:        0 RPM  (min =3D 1035 RPM, div =3D 8)              ALARM
>> CPU Fan:     0 RPM  (min =3D 1171 RPM, div =3D 8)              ALARM
>> fan3:        0 RPM  (min =3D 3183 RPM, div =3D 8)              ALARM
>> M/B Temp:    -48=B0C  (high =3D   +29=B0C, hyst =3D   +14=B0C)   sensor =
=3D=20
>> thermistor
>> CPU Temp: +108.5=B0C  (high =3D  +120=B0C, hyst =3D  +115=B0C)   sensor =
=3D diode=20
>>
>> temp3:     -48.0=B0C  (high =3D  +120=B0C, hyst =3D  +115=B0C)   sensor =
=3D=20
>> thermistor
>> alarms:   Chassis intrusion detection                      ALARM
>> beep_enable:
>>            Sound alarm enabled
>>
>> Thank you very much, Jean. My next problem are the strange values, but I=
=20
>> haven't read the manuals regarding that point yet.
>=20
> The voltages look rather good to me, but you should compare with what
> the BIOS says for confirmation. The limits are wrong but that's
> expected - set them in /etc/sensors.conf and run "sensors -s" to write
> them to the chip.

Yes, no problem.
>=20
> No fan speeds, strange, unless you have no fans on that systems, or
> very very slow fans (in which case you should increase the fan_div
> values to 16 or even 32.) Are there fan speeds displayed in the BIOS?

Fans have speed 1365rpm and 2396rpm resp. according to BIOS. Higher divs=20
aren't working either, but that's ok, fan speeds are no must at present.
>=20
> Temperatures look wrong, -48 typically means no sensor connected,
> +108.5=B0C is too high to be realistic unless your computer case is on
> fire ;) Try changing the thermal sensor types... although the BIOS
> should have set them up right.
>=20
> The lack of fan speeds and proper temperature readings might hint at an
> additional sensor chip on your board. If you can't get them out of the
> W83627THF, try running an up-to-date version of sensors-detect and see
> if it finds an extra chip on the SMBus.

Bad news for me:

Probing for `Analog Devices ADT7467 or ADT7468'...          Success!
     (confidence 7, driver `to-be-written')

Stefan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
