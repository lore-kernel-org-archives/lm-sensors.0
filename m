From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Apr 2011 12:16:55 +0000
Subject: Re: [lm-sensors] w83795 fan control not working
Message-Id: <20110412141655.40e55bbb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110407150007.51dd1c06@endymion.delvare>
In-Reply-To: <20110407150007.51dd1c06@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Darren,

On Fri, 08 Apr 2011 17:11:35 -0700, Darren Hart wrote:
> Hey Jean,
>=20
> I really appreciate your thoughts here. I'll respond inline, but let me
> give a summary. I've contacted SuperMicro and am hoping they'll get back
> to with a contact to help get some answer regarding how IPMI (WPCM450R)
> and W83795-ADG (I checked the chip, -ADG) are supposed to interact and
> still allow the OS to read temperature and control fans.
>=20
> You are correct about temp1, that has to be the northbridge, it is
> located right behind the PCI-E slots (which appears to be common
> practice) and has a very inadequate heat sink. I'm considering replacing
> it with a much more substantial heatsink and possible adding a tunnel to
> direct air over it. I've asked SuperMicro for a recommendation here as

FWIW, I was able to decrease the north bridge temperature on my own
dual-Xeon board by replacing the front case from a 59 m3/h model to a
92 m3/h model. So the air flow in the case definitely matters.

> well. If I can get that temperature down, my guess is the BIOS fan
> control might be able to do a much better job and I won't need the
> w83795-adg fancontrol from the OS quite so bad.

This is certainly true.

> >> (...)
> >> $ sensors | grep =B0C
> >> Core 0:      +26.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> Core 1:      +26.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> Core 2:      +24.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> Core 8:      +22.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> temp1:       +40.0=B0C  (high =3D +138.0=B0C, hyst =3D +96.0=B0C)  sen=
sor =3D thermistor
> >> temp2:       -61.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D thermistor
> >> temp3:       +36.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D thermistor
> >> temp1:       +75.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
> >>                       (crit =3D +127.0=B0C, hyst =3D +127.0=B0C)  sens=
or =3D thermal diode
> >> temp5:       +35.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
> >>                       (crit =3D +75.0=B0C, hyst =3D +70.0=B0C)  sensor=
 =3D thermistor
> >> temp7:       +24.8=B0C  (high =3D +95.0=B0C, hyst =3D +92.0=B0C)
> >>                       (crit =3D +95.0=B0C, hyst =3D +92.0=B0C)  sensor=
 =3D Intel PECI
> >> temp8:       +23.0=B0C  (high =3D +95.0=B0C, hyst =3D +92.0=B0C)
> >>                       (crit =3D +95.0=B0C, hyst =3D +92.0=B0C)  sensor=
 =3D Intel PECI
> >> Core 9:      +25.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> Core 10:     +24.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> Core 0:      +24.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> Core 1:      +21.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> Core 2:      +20.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> Core 8:      +15.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> Core 9:      +22.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)
> >> Core 10:     +19.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C) =20
> >=20
> > Unrelated to your issue, but the core numbering by coretemp is
> > surprising. I'm curious if you see the same in /proc/cpuinfo.
>=20
> No I do not. The Core ID you see above refers to physical cores per
> socket (there are six per socket). I had also found this odd and wrote
> one of the authors of coretemp about it. There appears to be some effort
> ongoing to try and get those numbers to align with what is used in the
> rest of the system to identify CPUs. Note that cpuinfo lists 24 CPUs due
> to hyper-threading, while coretemp is only concerned with physical cores.

It's correct that the coretemp driver skips hyperthread siblings. But
the core numbering is supposed to be correct (i.e. in line
with /proc/cpuinfo) since kernel 2.6.35. And it works fine for me.

> >> (...)
> >> I read somewhere during my hours of searching for a solution to this t=
hat
> >> both CPU fans are controlled by the same pwm signal, so that is not
> >> surprising. It's too bad about the case fans though, I really like to =
run
> >> the larger quiet fan up before bringing up the smaller front fan, but,
> >> it is what it is.
> >=20
> > As you don't seem to be using the second CPU fan header, you could
> > cheat and plug your large rear fan in this header, so pwm1 would
> > control it (if we manage to get this to work at all...)
>=20
> Turns out if I turn both fan housing around and flip the fans I can get
> them both in the system (barely). I have it running like this for now -
> but I think it's overkill really, and the CPUs don't break 40C even
> under a 24 way kernel compile or four parallel 24 way poky builds.

My limited experience with similar hardware is that the CPUs don't heat
much, and you have to focus on board (mainly north bridge) cooling and
not CPU cooling.

> > Didn't you get an error message in the kernel logs related to w83795
> > register 0x001? This is where the driver gets the chip type from.
>=20
> Hrm... looking back I see various errors reading ranging from 0x011
> through 0x46, but I don't see 0x001.

On a second thought, that's possible. In case of a bank mismatch, the
driver won't even notice the problem and won't report any error. Just,
you'll get the value read from (or worse, written to) a different
register in the chip.

> (...)
> As this board is available with and without the BMC, I wonder if they
> just don't expect people to use the W83795 if they have the BMC? That

Maybe, yes.

> would be fine if IPMI could control fan speed, but from what I can tell,
> it can only report on it.

I'm not familiar with IPMI, sorry, but indeed I've never heard of fan
speed control using this way.

But then again, if vendors would just let us select thermal trip points
for fan speed control in the BIOS, I think we could live without fan
control support on the OS side. Sigh.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
