From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Question to libsensors, due to a memory leak in a program. (fwd)
Message-Id: <3D8CFB2B.9BDF08DE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200209181204.g8IC4d901065@shire.frodo.local>
In-Reply-To: <200209181204.g8IC4d901065@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

the correct way to free is free_the_label(&label)

> Hello Frodo Looijaard,
>=20
> I am a german student and currently writing a small graphical frontend fo=
r>  lm_sensors.
> Everything works as I wish, but I encountered a small memory leak that ha=
s>  to do with the=20
> "sensors_get_label"-function of libsensors.
> I asked in several diskussion boards in the net, but nobody could help me=
.>=20
> (If I ask the wrong person, or if you don't find the time to help/answer,=
 > I would be pleased if you could tell me=20
> who I could ask).
>=20
> One function, I wrote, uses the following commands:
>=20
>    int i=3D0, nr1=3D0, nr2=3D0;
>    const sensors_chip_name *    sensors_chip;
>    const sensors_feature_data * sensor_data;
>=20
>    sensors_chip =3D sensors_get_detected_chips( &i))
>    sensor_data  =3D sensors_get_all_features( *sensors_chip, &nr1, &nr2))
>    char * label;
>=20
>    sensors_get_label ( *sensors_chip, sensor_data->number, &label);
>=20
> The last of the seven lines is called periodically ( eg. all 3 seconds).
> This causes a leak of 4 bytes about every 10 seconds (more or less).
> Four byte ist not much, but unacceptable.
> I am sure that the sensors_get_label-command is "guilty", because if I co=
m> ment this line ( using //) I can run=20
> my program for hours without "loosing" this four bytes periodically.
>=20
> So I added the following line as adviced in your sensors.h (quote: "*resu=
l> t is newly allocated (free it=20
> yourself)").
>=20
>    free( label);
>=20
> But this did not change anything. The memory leak did not vanish.
>=20
> I hope this is enough information so that you (or someone else) can help =
m> e.=20
> How can I get rid of this memory leak?
>=20
> Yours sincerely,
>=20
> Michael Zwick
>=20
> _________________________________________________________________________=
_> ____
> Die clevere Geldreserve: der DiBa-Privatkredit. Funktioniert wie ein Disp=
o> ,=20
> ist aber viel g=FCnstiger! Alle Infos: http://diba.web.de/?mc=3D021104
>=20
> --
> Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~=
frodol
> Defenestration n. (formal or joc.):
>   The act of removing Windows from your computer in disgust, usually foll=
owed
>   by the installation of Linux or some other Unix-like operating system.
