From: =?iso-8859-1?B?Sm9zZSDBbHZhcmV6?= <dynamix66@hotmail.com>
Date: Sun, 01 May 2011 11:03:59 +0000
Subject: Re: [lm-sensors] HELP with  and [msi p67a-gd65]
Message-Id: <SNT141-w25788F7E03720F1D273EA4A19C0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT141-w55955A6C97713857828A23A19C0@phx.gbl>
In-Reply-To: <SNT141-w55955A6C97713857828A23A19C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



>
> Chip ID 0x1005appears to be a F71889 a standalone drive is available here
> http://people.fedoraproject.org/~jwrdegoede/f71882fg/
>
> Just manually download the driver to some directory than do a make && sudo
> make install && modprobe f71882fg
>
> Regards
> Ian Dobson
>
>

thanks for=A0responding=A0so quickly,=A0amazing

I'll try=A0with=A0that=A0driver

one=A0question=A0...

>=A0Do=A0you=A0want=A0to=A0probe=A0the=A0I2C/SMBus=A0adapters=A0now?=A0(YES=
=A0/ no):
>=A0Using=A0driver=A0`i2c-i801=A0'for=A0device=A00000:00:1=A0f.3:=A0Intel=
=A0Cougar=A0Point=A0(PCH)
>=A0Module=A0i2c-i801=A0loaded=A0successfully.
>=A0i2c-dev=A0Module=A0loaded=A0successfully.

why=A0 i2c-i801=A0not come out=A0in=A0the=A0summary of=A0sensors-detect=A0t=
o add it=A0to=A0/etc=A0/=A0modules?=A0is=A0not necessary?

thanks! 		 	   		 =20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
