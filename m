From: robs@multiplayer.it (Roberto Sebastiano)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: as99127f bug?
Message-Id: <1070209362.1636.36.camel@newdeal>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031130134504.142f7cde.khali@linux-fr.org>
In-Reply-To: <20031130134504.142f7cde.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Il dom, 2003-11-30 alle 15:24, Jean Delvare ha scritto:
> > > > M/B and CPU temp are swapped. CPU is 39 and MB 28
> > >=20
> > > I doubt it. It would be physically difficult to do this, unless the
> > > monitoring chip is hardly tied to the CPU. This was never seen.
> > > temp1(here displayed as "M/B Temp") is the monitoring chipset
> > > internal temperature. 39 degrees is exactly what I have for a
> > > similar chip here.
> >
> > No, the BIOS shows the temperatures *exactly* swapped
>=20
> Strange. I'd be tempted to affirm that your BIOS is wrong. Please run
> some CPU-intensive task (kernel compilation, cpuburn, whatever) and
> see which temperature is raising. This is CPU temp.
>=20
I ran Folding@home, the temperature raising after a few minutes is M/B
temp (temp1) (+6 C?), while temp2 is +0,5 C?


> BTW, which motherboard is that? The more I learn about Asus, the more I
> think they are the worst brand when it comes to hardware monitoring. Not
> releasing data sheets is a first thing, using the chipsets in a
> completely wrong way is another. My next motherboard won't be an Asus.
>=20
A common Asus a7n8x-x


> > Also, fan1 is wrong. I use a thermaltake silent boost, it never
> > reaches 3000 RPM
>=20
> I'm clueless. What does the BIOS say about it?

That the fan spins at about 2300-2400 RPM (maybe num/2 ?)

>=20
> > I'm not using a configuration file (2.6 kernel if that matters)
>=20
> I seriously doubt it. You wouldn't have labels such as "M/B Temp". Take
> a look, you probably have some (possibly old) /etc/sensors.conf file (or
> wherever that is on your system). If you don't believe me, try "sensors
> -c /dev/null" and you'll see what it really looks like without a
> configuration file.

You're right. Make user_install installed /etc/sensors.conf
I reviewed the config file.
As stated for the a7n8x-deluxe motherboard, the a7n8x-x needs:

label temp1 "CPU Temp"
label temp2 "M/B Temp"=20

It also needs:
ignore temp3
label in0 "VCore"
ignore in1

Now, what it still doesn't work is fan speed
I tried setting fan1_div 4 *before* set fan1_min but I still see
"fan1:     5000 RPM  (min =3D 3000 RPM, div =3D 2)"

What I don't understand is why you don't make smaller config files based
on motherboards instead of one huge config file with all the chipsets
configured. As more than one motherboard can use a chipset differently,
this only huge config file will be surely wrong for some users

Having a 30 line sensors.asus_a7n8x-x.conf nicely preconfigured is
better than a -probably wrong for my motherboard- 400 lines sensors.conf
Also, this would incourage users to submit more config files

IMHO,
--=20
Roberto Sebastiano <robs@multiplayer.it>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Questa parte del messaggio =3D?ISO-8859-1?Q?=E8?=3D firmata
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031130=
/041bdbde/attachment.bin
