From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 24 Sep 2011 16:12:27 +0000
Subject: Re: [lm-sensors] AMD Phenom II Family 16h
Message-Id: <20110924181227.4ebbf059@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201109232108.25627.pablow.1422@gmail.com>
In-Reply-To: <201109232108.25627.pablow.1422@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 23 Sep 2011 20:50:22 -0700, Guenter Roeck wrote:
> On Fri, Sep 23, 2011 at 08:06:19PM -0400, Pablo Fabian Wagner Boian wrote:
> > Hi everyone.
> > I've got a question regarding AMD Phenom II Family 16h. I'm using the k=
10temp=20
> > which appear to be the lastest (the stand alone one, downloaded from lm-
> > sensors.org), and it gives me a temp not matching the real (about -10=
=BAC diff=20
> > between them). And, should it provides me a temp reading for all cores?=
 (6 in=20
> > my case), because I got only one.
>
> I can not comment on the accuracy, but the k10temp module reads the tempe=
rature
> from the northbridge, and there is only one no matter how many cores your=
 chip has.

The K8 only had a single north bridge PCI device, but it could report
several temperatures per CPU. This is no longer true with the family
10h and later.

As far as accuracy goes, the issue is explained at length in
Documentation/hwmon/k10temp.

> I guess the chip only reports the package temperature, not the per-core t=
emperature.

I think you're right. Which is not bad per se... better one good
temperature value than two good and two bogus as k8temp often does.

> Having said that ... the driver officially only supports up to family 15h=
 as far
> as I can see. Did you patch it, or does it just work ?

The driver supports PCI devices (north bridge) not CPU families. Just
as family 12h and 14h north bridges have the same PCI device ID, I can
only guess that family 15h and 16h north bridges have the same PCI
device ID. If this is confirmed, we can update the driver documentation
accordingly. Andre, Clemens, any comment on this?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
