From: Stefan Sassenberg <stefan.sassenberg@gmx.de>
Date: Wed, 05 Mar 2008 17:25:50 +0000
Subject: Re: [lm-sensors] No sensors found >2.6.21, w83627hf, ICH6
Message-Id: <47CED79E.30607@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <47CD5B89.1070302@gmx.de>
In-Reply-To: <47CD5B89.1070302@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Wed, 05 Mar 2008 17:09:02 +0100, Stefan Sassenberg wrote:
>> Bad news for me:
>>
>> Probing for `Analog Devices ADT7467 or ADT7468'...          Success!
>>      (confidence 7, driver `to-be-written')
>=20
> No driver yet and nobody working on it as far as I know - but in the
> meantime you may try forcing the lm85 driver, with chip type adm1027,
> you should get some basic results.
>=20
After modprobing w83627hf, lm85, adm1021, adm1025, adm1026, adm1029,=20
adm1031 the results are just the same.

Meanwhile I connected the hard disk to a MSI W7231IMS. It has the same=20
AD chip:
Probing for `Analog Devices ADT7467 or ADT7468'...          Success!
...but a different Winbond:
Found `Winbond W83627EHF/EHG Super IO Sensors'              Success!
...and shows no fan speed but three temperature values:
Sys Temp:    +33=B0C  (high =3D   +45=B0C, hyst =3D   +40=B0C)
CPU Temp:  +33.0=B0C  (high =3D +45.0=B0C, hyst =3D +40.0=B0C)
temp3:     +32.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)

Not bad.

Stefan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
