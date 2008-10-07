From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Oct 2008 20:12:38 +0000
Subject: Re: [lm-sensors] Looking for IT8720 datasheet.
Message-Id: <20081007221238.69057bed@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
In-Reply-To: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean-Marc,

Just a couple comments on top of what Frank already wrote and with
which I do agree.

On Fri, 3 Oct 2008 09:23:08 -0400, Jean-Marc Spaggiari wrote:
> Regarding pwm4 and pwm5, I'm not really sure how to do so, and I seen
> that some fans info was missing. So I will try to figure how to use it
> since I have 3 fans and only 2 are displayed.
>=20
> fan1:       3013 RPM  (min =3D    0 RPM, div =3D 2)
> fan2:          0 RPM  (min =3D    0 RPM, div =3D 2)
> fan3:       5973 RPM  (min =3D    0 RPM, div =3D 2)

If fan2 is slow, try increasing fan2_div to 4 or even 8. But I'm a bit
surprised, if the IT8720F is similar to the IT8718F, then it should
have 16-bit fan tachometers and thus no fan_div registers.

> Last point, temperatures are slightly different from it8720 and k8temp.
>=20
> temp1:       +41.0 =B0C  (low  =3D  -1.0 =B0C, high =3D +127.0 =B0C)  sen=
sor =3D transistor
> temp2:       +34.0 =B0C  (low  =3D  -1.0 =B0C, high =3D  -3.0 =B0C)  sens=
or =3D transistor
> temp3:       +22.0 =B0C  (low  =3D  -5.0 =B0C, high =3D +127.0 =B0C)  sen=
sor =3D transistor
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +43.0 =B0C
> Core1 Temp:  +37.0 =B0C
>=20
> Has it87 only the motherboard temp?

I guess so, yes.

> In that case, why there is 3?

Why not? A motherboard is something relatively large, there's nothing
wrong with having several temperature sensors on it. For example you
can monitor the CPU socket, the north bridge and the south bridge. Or
virtually any point of the motherboard.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
