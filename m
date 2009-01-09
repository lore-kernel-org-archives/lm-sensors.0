From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Jan 2009 17:10:59 +0000
Subject: Re: [lm-sensors] k8temp on K8 rev.F and rev.G: Testers wanted
Message-Id: <20090109181059.44b38c56@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090109160702.466b8a6f@hyperion.delvare>
In-Reply-To: <20090109160702.466b8a6f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 09 Jan 2009 17:42:40 +0100, Daimonos Tereutes wrote:
> Jean Delvare a =E9crit :
> > Hi all,
> >=20
> > I am done reviewing and testing Andreas' k8temp patches. After some
> > reorganization I came up with the following stack:
> >=20
> > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-0=
1-warn-about-errata.patch
> > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-0=
2-fix-wrong-sensor-selection-for-revf-revg.patch
> > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-0=
3-fix-temperature-reporting-for-most-revg.patch
> >=20
> > These are in linux-next at the moment, and I'd like to push them to
> > Linus quickly. But I do not own any rev.F nor rev.G CPU myself, so I
> > couldn't really test the patches, other than ensure that they do not
> > cause a regression on earlier K8 CPUs.
> >=20
> > So this is a call to owners of rev.F and rev.G K8 CPUs, to try these
> > patches and report how they are doing. There's also a standalone
> > version of the updated driver at:
> >   http://jdelvare.pck.nerim.net/sensors/k8temp/
> > if it is easier for you.
>
> Seems working well on my hardware.

Great. Thanks for reporting!

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
