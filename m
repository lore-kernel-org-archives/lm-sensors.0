From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 24 Sep 2011 18:04:13 +0000
Subject: Re: [lm-sensors] adjusting /etc/sensors.conf for a dual processor
Message-Id: <20110924180413.GA24687@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
In-Reply-To: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Sep 24, 2011 at 01:01:51PM -0400, Jean Delvare wrote:
> On Sat, 24 Sep 2011 09:10:17 -0700 (PDT), Audio Phile wrote:
> > Ah!=A0 I didn't read the output carefully.=A0 If you notice, the "core =
id" is what is causing this, nothing wrong with lm-sensors here.
>=20
> Indeed, the unexpected core IDs come straight from /proc/cpuinfo.
>=20
> > We can I think blame HP.=A0 Next question would be how to get this on t=
o the lm-sensors wiki so that other HP Z600 users can make this addition to=
 their configs if necessary.
>=20
> What makes you think the system vendor has anything to do with this? I
> would expect the core IDs to be reported by the CPU itself (someone
> please correct me if I'm wrong.)
>=20
> > $ grep "core id" cpuinfo.txt
> > core id=A0=A0=A0 =A0=A0=A0 : 0
> > core id=A0=A0=A0 =A0=A0=A0 : 1
> > core id=A0=A0=A0 =A0=A0=A0 : 9
> > core id=A0=A0=A0 =A0=A0=A0 : 10
> > core id=A0=A0=A0 =A0=A0=A0 : 0
> > core id=A0=A0=A0 =A0=A0=A0 : 1
> > core id=A0=A0=A0 =A0=A0=A0 : 9
> > core id=A0=A0=A0 =A0=A0=A0 : 10
> > core id=A0=A0=A0 =A0=A0=A0 : 0
> > core id=A0=A0=A0 =A0=A0=A0 : 1
> > core id=A0=A0=A0 =A0=A0=A0 : 9
> > core id=A0=A0=A0 =A0=A0=A0 : 10
> > core id=A0=A0=A0 =A0=A0=A0 : 0
> > core id=A0=A0=A0 =A0=A0=A0 : 1
> > core id=A0=A0=A0 =A0=A0=A0 : 9
> > core id=A0=A0=A0 =A0=A0=A0 : 10
>=20
> I have no idea if the CPU is just reporting strange values or if the
> kernel is somehow misbehaving.
>=20
I suspect it is the CPU ... for each CPU model I have been testing with, I =
have seen
different yet consistent CPU numbers for the "real" cores if the CPU suppor=
ts
hyperthreading. Sometimes the siblings are the odd numbers, sometimes the r=
eal cores
come first followed by the siblings, and sometimes the real cores have the =
lower
and upper numbers and the siblings are in the center. Seems like real core =
numbering
may be inconsistent across CPU models.=20

My guess may be wrong, of course, but I don't immediately see how the kernel
would manage to assign consistent CPU numbers for each model across boots,
yet just as consistently different numbers for other CPU models.

The above is really a strange one, though. So far the gaps I have seen were=
 always
the hyperthreading siblings.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
