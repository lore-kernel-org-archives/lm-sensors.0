From: Juergen Bausa <Juergen.Bausa@web.de>
Date: Tue, 28 Aug 2007 06:29:29 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <1539045386@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

So, which version is needed to run the dme1737 on the asus board (Which I t=
hink doesnt have the=20
SCH3114 Super I/O chip)?

debian testing and unstable both have 2.10.4 at the moment, which is the sa=
me version as=20
http://www.lm-sensors.org/wiki/Download. Will it be enough to install this =
version?

By the way: Does anyone know of backports to etch?

Juergen


> -----Urspr=FCngliche Nachricht-----
> Von: Kushal Koolwal <kushalkoolwal@hotmail.com>
> Gesendet: 28.08.07 00:56:24
> An:  "Juergen. Bausa" <juergen.bausa@web.de>
> CC: <lm-sensors@lm-sensors.org>
> Betreff: RE: [lm-sensors] dme1737 module

Hello,
>=20
> Actually I have tried the newest version of lm-sensors on Debian sid and =
dme1737 does not show any output for my SCH3114 Super I/O chip.
>=20
> I have also opened a ticket for the same last week.
>=20
> Here is the URL of the ticket:
> http://www.lm-sensors.org/ticket/2243
>=20
> Thanks
>=20
> Kushal Koolwal
>=20
> > Date: Mon, 27 Aug 2007 14:26:16 -0700
> > From: juergh@gmail.com
> > To: Juergen.Bausa@web.de
> > CC: lm-sensors@lm-sensors.org
> > Subject: Re: [lm-sensors] dme1737 module
> >=20
> > Hi Juergen,
> >=20
> >=20
> > > Juerg Haefliger <juergh <at> gmail.com> writes:
> > >
> > > >
> > > > > I own a barebone made by asus which needs the dme1737 module for
> > > > > lm-sensors to work correctly. Since it had been included in kernel
> > > > > 2.6.23 and I am running 2.6.18 (from
> > > > > debian etch) I was wondering if there is a stand alone version
> > > > > of the module, that I could
> > > > > compile for my kernel? Is there any way to use it with 2.6.18?
> > > >
> > > > Copy the file dme1737.c from the 2.6.23 kernel to a temp directory =
and
> > > > create a Makefile in the same directory that contains the following
> > > > lines:
> > > >
> > > > obj-m :=3D dme1737.o
> > > > all:
> > > > make -C /lib/modules/`uname -r`/build M=3D$(PWD) modules
> > > >
> > > > Then run 'make' which will compile the module. You also need to have
> > > > the kernel headers installed to be able to compile.
> > > > Additionally, you will also need the latest 'lm-sensors' package
> > > > (2.10.4 ) or the dme1737 will not be recognized.
> > > >
> > >
> > > Thanks a lot, the module seems to work fine. I used the newest sensor=
s-detect
> > > and it found out the modules I have to use. However, the output of se=
nsors
> > > is quite short:
> > >
> > > jba@lisa:~$ sensors
> > > k8temp-pci-00c3
> > > Adapter: PCI adapter
> > > Core0 Temp:
> > > -1=B0C
> > > Core0 Temp:
> > > +1=B0C
> > > Core1 Temp:
> > > +6=B0C
> > > Core1 Temp:
> > > +6=B0C
> > >
> > > dme1737-i2c-0-2e
> > > Adapter: SMBus nForce2 adapter at 4c00
> > >
> > > k8temp values are wrong, but that is another problem. But why doent
> > > dme1737 display anything? Is it because of the older lm-sensors versi=
on in
> > > debian (2.10.1-3). Or will it be sufficiant to update the config file?
> > > If possible I would like to keep the etch version of lm-sensors.
> >=20
> > You need a newer lm-sensors. 2.10.1 doesn't know about the dme1737.
> > Just updating the config file is not enough.
> >=20
> > ...juerg
> >=20
> >=20
> > > Juergen
> > >
> > >
> > > _______________________________________________
> > > lm-sensors mailing list
> > > lm-sensors@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >=20
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20
>=20
> -----------------------------------------------------------------
> Get news, entertainment and everything you care about at Live.com. Check =
it out!


_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
