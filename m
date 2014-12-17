From: Sean O'Brien <sean451@hotmail.com>
Date: Wed, 17 Dec 2014 18:31:31 +0000
Subject: Re: [lm-sensors] Supermicro X7DBU configuration
Message-Id: <BLU175-W2EF358CABC5146593CFDEE66D0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU175-DS1275A243EB8731D1852460E66C0@phx.gbl>
In-Reply-To: <BLU175-DS1275A243EB8731D1852460E66C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



----------------------------------------
> Subject: RE: [lm-sensors] Supermicro X7DBU configuration
> From: jdelvare@suse.de
> To: sean451@hotmail.com
> CC: linux@roeck-us.net; lm-sensors@lm-sensors.org
> Date: Wed, 17 Dec 2014 19:25:45 +0100
>
> Le Wednesday 17 December 2014 =E0 13:16 -0500, Sean O'Brien a =E9crit :
>> Loading the module produced the following:
>>
>> $ sudo i2cdetect -l
>> i2c-0 i2c Radeon i2c bit bus DVI_DDC I2C adapter
>> i2c-1 i2c Radeon i2c bit bus VGA_DDC I2C adapter
>> i2c-2 i2c Radeon i2c bit bus MONID I2C adapter
>> i2c-3 i2c Radeon i2c bit bus CRT2_DDC I2C adapter
>> i2c-4 smbus SMBus I801 adapter at 1100 SMBus adapter
>
> And now modprobe w83793 and you should see it in "sensors".
>
> --
> Jean Delvare
> SUSE L3 Support
>

Voila!

w83793-i2c-4-2f
Adapter: SMBus I801 adapter at 1100
VcoreA: =A0 =A0 =A0 +1.08 V =A0(min =3D =A0+0.92 V, max =3D =A0+1.49 V)
VcoreB: =A0 =A0 =A0 +1.08 V =A0(min =3D =A0+0.92 V, max =3D =A0+1.49 V)
in2: =A0 =A0 =A0 =A0 =A0+1.08 V =A0(min =3D =A0+0.99 V, max =3D =A0+1.33 V)
in3: =A0 =A0 =A0 =A0 =A0+0.50 V =A0(min =3D =A0+0.38 V, max =3D =A0+0.69 V)
in4: =A0 =A0 =A0 =A0 =A0+1.49 V =A0(min =3D =A0+1.34 V, max =3D =A0+1.98 V)
in5: =A0 =A0 =A0 =A0 =A0+3.30 V =A0(min =3D =A0+2.96 V, max =3D =A0+3.63 V)
in6: =A0 =A0 =A0 =A0 =A0+0.99 V =A0(min =3D =A0+0.90 V, max =3D =A0+1.10 V)
+5V: =A0 =A0 =A0 =A0 =A0+5.09 V =A0(min =3D =A0+4.64 V, max =3D =A0+5.65 V)
5VSB: =A0 =A0 =A0 =A0 +5.14 V =A0(min =3D =A0+4.64 V, max =3D =A0+5.65 V)
Vbat: =A0 =A0 =A0 =A0 +3.34 V =A0(min =3D =A0+2.99 V, max =3D =A0+3.66 V)
fan1: =A0 =A0 =A0 =A09183 RPM =A0(min =3D =A0712 RPM)
fan2: =A0 =A0 =A0 =A09375 RPM =A0(min =3D =A0712 RPM)
fan3: =A0 =A0 =A0 =A09246 RPM =A0(min =3D =A0712 RPM)
fan4: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D =A0712 RPM) =A0ALARM
fan5: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D =A0712 RPM) =A0ALARM
fan6: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D =A0712 RPM) =A0ALARM
fan7: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D =A0712 RPM) =A0ALARM
fan8: =A0 =A0 =A0 =A09782 RPM =A0(min =3D =A0712 RPM)
fan9: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D =A0712 RPM) =A0ALARM
fan10: =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0712 RPM) =A0ALARM
temp1: =A0 =A0 =A0 =A0+45.0=B0C =A0(high =3D +89.0=B0C, hyst =3D +84.0=B0C)=
 =A0sensor =3D Intel PECI
temp2: =A0 =A0 =A0 =A0+40.0=B0C =A0(high =3D +89.0=B0C, hyst =3D +84.0=B0C)=
 =A0sensor =3D Intel PECI
temp3: =A0 =A0 =A0 -128.0=B0C =A0(high =3D +89.0=B0C, hyst =3D +84.0=B0C) =
=A0sensor =3D Intel PECI
temp4: =A0 =A0 =A0 -128.0=B0C =A0(high =3D +89.0=B0C, hyst =3D +84.0=B0C) =
=A0sensor =3D Intel PECI
temp5: =A0 =A0 =A0 =A0+26.0=B0C =A0(high =3D +75.0=B0C, hyst =3D +70.0=B0C)=
 =A0sensor =3D thermistor
intrusion0: =A0OK
beep_enable: disabled


Now to control those noise fans!

Thanks so much for the guidance guys! Very much appreciated.

Sean. 		 	   		 =20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
