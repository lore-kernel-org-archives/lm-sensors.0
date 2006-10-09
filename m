From: kress@hal.saar.de (Michael Kress)
Date: Mon, 09 Oct 2006 20:25:22 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <452AB032.9050205@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
>> I tried it - i.e. I replaced pc87427.c in a copy of the directory
>> containing the old pc87427.c
>> But I regret to report a failure. I try to document the relevant things.=
..
>>    =20
>
> Is the attached version any better? I had forgotten to create the
> "name" attribute file, and libsensors needs it. This is fixed now,
> hopefully this is all that was missing.
>
>  =20
Yeah, it seems 2b perfect like this - thank you very much for your effort!

[root at matrix PC87427-platform-driver]# sensors
pc87427-isa-0840
Adapter: ISA adapter
case-fan1:3698 RPM  (min =3D 2000 RPM)
case-fan2:3400 RPM  (min =3D 2000 RPM)
case-fan3:3400 RPM  (min =3D 2000 RPM)
case-fan4:3375 RPM  (min =3D 2000 RPM)
CPU0-fan: 3075 RPM  (min =3D 2000 RPM)
CPU1-fan: 2934 RPM  (min =3D 2000 RPM)

[root at matrix PC87427-platform-driver]# dmesg | tail -n 8
pc87427: readall_fan: data=FFff88003f09e540, nr=3D0
pc87427: readall_fan: data=FFff88003f09e540, nr=3D1
pc87427: readall_fan: data=FFff88003f09e540, nr=3D2
pc87427: readall_fan: data=FFff88003f09e540, nr=3D3
pc87427: readall_fan: data=FFff88003f09e540, nr=3D4
pc87427: readall_fan: data=FFff88003f09e540, nr=3D5
pc87427: readall_fan: data=FFff88003f09e540, nr=3D6
pc87427: readall_fan: data=FFff88003f09e540, nr=3D7

Salut
Michael

--=20
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L


