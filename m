From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Jul 2010 15:03:06 +0000
Subject: Re: [lm-sensors] config for Gigabyte P55-US3L
Message-Id: <20100702170306.27fc1d0b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.1006301403230.25622@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.00.1006301403230.25622@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Yuri,

On Thu, 1 Jul 2010 16:12:54 +0400 (MSD), yuri.nefedov@gmail.com wrote:
>=20
>    Hi Jean,
>=20
> On Wed, 30 Jun 2010, Jean Delvare wrote:
>=20
> >>
> >>   Unfortunately wiki page (http://www.lm-sensors.org/wiki/Configuratio=
ns)
> >>   is not working  (requires authorization).
> >
> > It is working. There's no rule stating that all wikis in the world have
> > to be publicly writable.
> >
>=20
>     Yes, you are right. Probably it will be good to add on this page
>     a link to mailing list with sentence to send configuration to it.

Good point, I've updated the page. Hope you like it.

> >> -12V:       -12.01 V  (min =3D -10.84 V, max =3D -13.17 V)
> >
> > This one is wrong. in7 is 5VSB on all IT8720F chips, because it's
> > internal. So you want:
> >
> >   label in7 "5VSB"
> >   compute  in7  @ * (6.8/10+1), @ / (6.8/10+1)
> >
> > If the value isn't correct for you, then you probably need the
> > following patch of mine:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvar=
e-hwmon/hwmon-it87-fix-in7-on-IT8720F.patch
> >
> > According to my notes, all Gigabyte boards need it (BIOS bug.)
>=20
>     Yes this value is wrong for this motherboard:
>=20
> 5VSB:        +3.60 V  (min =3D  +4.49 V, max =3D  +5.51 V)   ALARM
>=20
>     I did not yet tried you patch.

I expect the patch to work, just try it if you can. If you can't, feel
free to try the following sequence:

# rmmod it87
# isaset -y -f 0x2e 0x87
# isaset -y -f 0x2e 0x01
# isaset -y -f 0x2e 0x55
# isaset -y -f 0x2e 0x55
# isaset -y -f 0x2e 0x07
# isaset -y -f 0x2f 7
# isaset -y -f 0x2e 0x2c
# isaset -y -f 0x2f 0x02 0x02
# isaset -y -f 0x2e 0x02
# isaset -y -f 0x2f 0x02
# modprobe it87

>     I found that it is not the only bug in BIOS.
>     Yesterday the temperature of CPU was -30C.
>     After switching off/on the temperature returned to normal.
>=20
>     Also the voltages in4 and in6 are mysterious.
>     In the attachment the plots for them (weekly-voltage2.png)
>     and load average of the system (weekly-la.png).
>     Do you have any idea that it can be?

Not really. You'd need to ask the motherboard manufacturer. Just a
couple random ideas:

* It seems that more voltages will follow the example of Vcore in the
future, and change over time depending on operating frequency.

* Voltage inputs can always be used for temperature monitoring. We've
seen one case of this in the past, maybe you have a similar hardware
setup. This is traditionally implemented with a resistor and a
thermistor of equal value at 25=C2=B0C. Unfortunately, it all depends on the
beta value of the thermistor.


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
