From: "Darth Tumi" <darth.tumi@gmail.com>
Date: Mon, 05 May 2008 17:16:58 +0000
Subject: [lm-sensors]   Backporting coretemp and w83793 to 2.6.18
Message-Id: <481f410e.0c58560a.0fb1.407e@mx.google.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46CB9161.5090408@curl.com>
In-Reply-To: <46CB9161.5090408@curl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Sorry, this question is about one archived post
(http://lists.lm-sensors.org/pipermail/lm-sensors/2007-August/021007.html)
by Boleslaw Ciesielski... (bellow)

Any help will be appreciated.

> Boleslaw Ciesielski wrote:
> > I have this new server based on the Asus DSBF-DE/SAS motherboard and a
> > pair of Xeons 5355. I want to run CentOS 5.0 (RHEL 5 clone) on it.
> > CentOS 5.0 is based on the 2.6.18 kernel and as such has drivers for
> > everything *except* for the sensors. The motherboard uses 83793 chip.
> >=20
> > So, I wanted to backport the w83793 and coretemp drivers to 2.6.18
> > kernel. I took the source from 2.6.22.3 for these two and tried to
> > compile them for 2.6.18.
> >=20
> > The w83793 compiles and loads as is, without any changes.
> >=20
> > coretemp required some changes related to msr so I just restored the
> > code that was in there when coretemp was floating around as a patch
> > before it made it to the kernel. See the attached patch for detail.
> >=20
> > Anyway, with those changes both coretemp and w83793 compile and load. I
> > also copied sensors.conf from 2.10.4 and ran "sensors -s". However,
> > neither is providing any data. Output looks like this:
>=20
> Just a quick update. I got reply off-list that I am missing the new=20
> versions of the user tools. I installed 2.10.4 rpm from Fedora 7 and I=20
> get the readings now.
>=20
> Thank you
>=20
> Bolek





=20

__________ Informaci=F3n de ESET NOD32 Antivirus, versi=F3n de la base de f=
irmas
de virus 3071 (20080502) __________

ESET NOD32 Antivirus ha comprobado este mensaje.
http://www.eset.com
=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
