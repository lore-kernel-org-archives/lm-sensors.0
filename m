From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Jun 2009 12:11:16 +0000
Subject: Re: [lm-sensors] Jetway NC92-330-LF motherboard sensors.conf
Message-Id: <20090615141116.1fd4222f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <55a4f86e0906050429q2aad447cqf7ddea1a043bf1c5@mail.gmail.com>
In-Reply-To: <55a4f86e0906050429q2aad447cqf7ddea1a043bf1c5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 5 Jun 2009 13:29:38 +0200, Maciej =C5=BBenczykowski wrote:
> submitting a sensors.conf file for a Jetway NC92-330-LF motherboard
> with f71882fg monitoring chip.
>=20
> # uname -a
> Linux gaia 2.6.29.4-168.mz1.fc11.x86_64 #1 SMP Fri Jun 5 11:10:05 CEST
> 2009 x86_64 x86_64 x86_64 GNU/Linux
>=20
> # lsmod | head -n 5
> Module                  Size  Used by
> f71882fg               27120  0
> coretemp                6768  0
>=20
> Also including a slight patch to coretemp.c for atom support.
>=20
> Hope you include the conf in the wiki.

Done, thanks for your contribution:
http://www.lm-sensors.org/wiki/Configurations/Jetway/NC92-330-LF

Note: you should really be able to tell which is the CPU temperature
sensor by putting significant load on the system and watching which
temperature value raises highest and fastest.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
