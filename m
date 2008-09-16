From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Sep 2008 22:35:41 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <200809170035.41414.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf, Marco,

Le mardi 16 septembre 2008, Rudolf Marek a =E9crit=A0:
> Hello,
>=20
> Here is mine research:
>=20
> DHG chip is wired as follows:
>=20
> in0 is Vcore
> in1 is 12V
> in2 not used
> in3 is 3.3V
> in4 is 5V
>=20
> temp1 is MB temp
> fans are
> fan2 is cpu,
> fan5 is not, fan4 is not
>=20
> There is some unknown i2c chip at 0x38 which measures voltages, and fans
>=20
> It measures:
> Cpu voltage, DDR voltage, SB 1.1V voltage SB 1.5V, CPU PLL voltage, NB 1.=
1V Dram=20
> VTT volrage, VTT CPU voltage,
>=20
> And also fans:
> Chasis fan1
> Chasis fan2
> Power Fan
> And some Opt fans, I know what registers are there (mostly up 0xa0 for fa=
ns)
>=20
> So we need to find out what chip it is, because it measures a lot too.
>=20
> The NB temperature etc etc is measured by some chip at 0x40 it seems it a=
lso=20
> controls some fan temperature???
>=20
> Definitely what is the output of
>=20
> i2cdetect 0
> i2cdump 0 0x40
> i2cdump 0 0x38

Excellent work, thanks Rudolf. We don't currently know of any
hardware monitoring chip at either 0x40 or 0x38, which is why
sensors-detect didn't reveal anything. The output of i2cdetect would
definitely be a good thing to have, sorry for not thinking of this
earlier.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
