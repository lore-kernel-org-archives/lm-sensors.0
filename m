From: ianp <braveheart_leo@yahoo.com>
Date: Fri, 07 Mar 2014 14:48:39 +0000
Subject: Re: [lm-sensors] Sensors configuration for Asus P5PE-VM motherboard
Message-Id: <1394203719.751.YahooMailNeo@web160504.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393524410.49402.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1393524410.49402.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Friday, March 7, 2014 10:24 PM, Jean Delvare <jdelvare@suse.de> wrote:
>>=20
>>=A0 Which brings me to this idea for the voltage scaling guide: would it =
be=20
> possible to list some common scaling factors for +5V and +12V as a look-u=
p=20
> table, if the list isn't going to be long? I bet it would help others who=
=20
> will be faced with the same conundrum as I did when deciding which scalin=
g=20
> factor should be used, if the computation didn't yield a desirable value =

> that corresponds to the BIOS samples taken when verified.
>=20
> I thought about it already, unfortunately the list would be too long.
> Each chip has its own recommended settings, and each board maker has
> its own habits. So it is possible to look-up existing configuration
> files for the same chip and/or board maker, once you have a suspect,
> but having a big list with all the possibilities wouldn't work, I'm
> afraid. And in many cases it would be useless anyway, as the board
> makers are incredibly creative with their new models.
>=20
> It shouldn't be needed anyway... I didn't use the information to come
> up with the right value, I only used it as a second confirmation that I
> got it right.
>=20
>=20
> --=20
> Jean Delvare
> SUSE L3 Support
>

I was leaning towards a table sorted by monitoring chip, listing possible c=
ommon scaling factors under each chip that have been encountered in the pas=
t. And I was hoping that the board makers' implementation for each monitori=
ng chip would be uniform so that this list would be manageable and could wo=
rk, but unfortunately and like you said, it would be a mix-and-match fest w=
ith each board maker having its own habits, even perhaps varying across mod=
els as well.


ianp


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
