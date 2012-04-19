From: GSR <gsr.bugs@infernal-iceberg.com>
Date: Thu, 19 Apr 2012 21:40:01 +0000
Subject: Re: [lm-sensors] asus_atk0110: i8042: keys get stuck and keyboard stops responding
Message-Id: <20120419214001.GA18307@fortress.battleship>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120320231656.GC12339@burratino>
In-Reply-To: <20120320231656.GC12339@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,
kronos.it@gmail.com (2012-04-11 at 1059.02 +0200):
> Sorry for the latency, I was on vacation...
>=20
> On Thu, Apr 5, 2012 at 1:48 AM, GSR - FR <famrom@infernal-iceberg.com> wr=
ote:
> > Hi,
> > jrnieder@gmail.com (2012-03-22 at 0940.40 -0500):
> >> =A0 =A0 =A0 cat DSDT.aml >/sys/kernel/debug/acpi/custom_method
> >
> > I got some time to try all those things, but that step fails with
> > "cat: write error: Invalid argument".
>=20
> Can you send me the dump of your DSDT table?

Do you mean acpidump output? That is in Debian bug #662895.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D662895
http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D25;filename=3Dacpi-p7p55=
d-bios1807-acpi2.txt.gz;att=3D1;bug=3D66289

GSR
=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
