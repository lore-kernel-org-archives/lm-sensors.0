From: Hubert Kario <hka@qbs.com.pl>
Date: Wed, 02 Sep 2009 00:23:52 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <200909020223.53045.hka@qbs.com.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tuesday 01 September 2009 23:27:28 Tech2009 wrote:
> Thank you for the suggestions.
>
> I looked in sysfs on the factory distro, no sign of dme1737 there (see
> attached). However there are other i2c devices not on my debian
> install...you could be right about the direct port io, but without
> disassembling the library it's hard to tell.
>
> I tried loading dme1737 with force_start, but that made no difference
> for me.
I was thinking about using the 'force' parameter to givie the address=20
explicitly to the module, the device may be on non standard port.
sensors-detect is usually more capable of detecting devices than kernel=20
modules
>
> I'm going to have to determine whether the problem is with the sensors
> program or the dme1737 driver. Is there a way to make the dme1737 module
> dump out the debug information present in the source code?
Haven't read the source of this module, but you'll probably have to compile=
=20
kernel (or at least the module) with different .config (one that enables=20
debugging messages)
>
> I'm going to see if I can use the dme1737.c module source to read the
> information via standard i2c calls in userland (ie i2ctools). If this
> does work, I will be at a loss as to why the dme1737 module + sensors
> program aren't working, but at least I'll have a viable alternative.
>
> I will let you know if it works.
I'm just a random lm-sensors user, so it's more of the blind leading the bl=
ind=20
case and educated guess than real inside knowledge about lm-sensors...
Though there are other readers from the list that will benefit from this=20
information
>
> On Tue, 2009-09-01 at 20:26 +0200, Hubert Kario wrote:
> > On Saturday 29 August 2009 18:03:36 Tech2009 wrote:
> > > > Message: 3
> > > > Date: Sat, 29 Aug 2009 10:30:25 +0200
> > > > From: Hubert Kario <hka@qbs.com.pl>
> > > > Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage
> > > > System SS4200
> > > > To: lm-sensors@lm-sensors.org
> > > > Message-ID: <200908291030.25637.hka@qbs.com.pl>
> > > > Content-Type: text/plain;  charset=3D"iso-8859-2"
> > > >
> > > >
> > > >
> > > > and what shows dmesg?
> > >
> > > dmesg output after sensors-detect:
> > > [ 1815.988770] i2c /dev entries driver
> > >
> > > dmesg output after sensors:
> > > (blank)
> >
> > So there doesn't appear to be any problem...
> >
> > > The bundled Linux image does not appear to use the dme1737 module or
> > > lmsensors. The web interface loads several closed source libraries, a=
nd
> > > I'm not sure how they access the hardware.
> >
> > They may access the hardware directly, is the web interface running as
> > root? Also, you may check /sys file system, look in
> > /sys/bus/platform/drivers/ for it, the module may be compiled in in the
> > bundled image
> >
> > > Is there something I should try to determine why sensors-detect sees
> > > the chip but sensors does not?
> >
> > you could try one of the parameters aviable for the module, for list of
> > all of them, run:
> > modinfo dme1737

--=20
Hubert Kario
QBS - Quality Business Software
ul. Ksawer=F3w 30/85
02-656 Warszawa
POLAND
tel. +48 (22) 646-61-51, 646-74-24
fax +48 (22) 646-61-50


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
