From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 07 Mar 2014 14:24:16 +0000
Subject: Re: [lm-sensors] Sensors configuration for Asus P5PE-VM motherboard
Message-Id: <20140307152416.721cedfd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393524410.49402.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1393524410.49402.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 7 Mar 2014 06:10:16 -0800 (PST), ianp wrote:
> > On Thursday, March 6, 2014 4:41 PM, Jean Delvare <jdelvare@suse.de> wro=
te:
> >>  compute=A0 in5=A0 @*(255/80), @/(255/80)
> >=20
> > I have a better one. 5.196/0.008/(255/80) is 203.764, which is not an
> > integer register value. That's why your validation above doesn't work.
> > 5.196 V in the BIOS has to correspond to a register value of 203 or
> > 204, it can't be in between.
> >=20
> > 5.196/(204*0.008) would mean a scaling factor 3.183823, which almost
> > works but assumes that the BIOS rounds values, which is generally not
> > the case. However 5.196/(203*0.008) leads to a scaling factor of
> > 3.199507, which I will deliberately round to 3.2 :-) because it's nice,
> > has been seen before, and works quite well:
> >=20
> > 199 * 0.008 * (1+22/10) =3D 5.094
> > 201 * 0.008 * (1+22/10) =3D 5.145
> > 202 * 0.008 * (1+22/10) =3D 5.171
> > 203 * 0.008 * (1+22/10) =3D 5.196
> >=20
> > So I vote for (1+22/10) as the +5V scaling factor.
>=20
> Ha! This scaling computation has been a tricky one, and it really helps w=
hen one is accustomed to what I can only imagine are multitudes of possible=
 scaling factors. ;)
>=20
> Which brings me to this idea for the voltage scaling guide: would it be p=
ossible to list some common scaling factors for +5V and +12V as a look-up t=
able, if the list isn't going to be long? I bet it would help others who wi=
ll be faced with the same conundrum as I did when deciding which scaling fa=
ctor should be used, if the computation didn't yield a desirable value that=
 corresponds to the BIOS samples taken when verified.

I thought about it already, unfortunately the list would be too long.
Each chip has its own recommended settings, and each board maker has
its own habits. So it is possible to look-up existing configuration
files for the same chip and/or board maker, once you have a suspect,
but having a big list with all the possibilities wouldn't work, I'm
afraid. And in many cases it would be useless anyway, as the board
makers are incredibly creative with their new models.

It shouldn't be needed anyway... I didn't use the information to come
up with the right value, I only used it as a second confirmation that I
got it right.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
