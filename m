From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 11 Jan 2009 09:45:42 +0000
Subject: Re: [lm-sensors] k8temp on K8 rev.F and rev.G: Testers wanted
Message-Id: <4969BFC6.80207@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090109160702.466b8a6f@hyperion.delvare>
In-Reply-To: <20090109160702.466b8a6f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

Jean Delvare wrote:
> Hi all,
>=20
> I am done reviewing and testing Andreas' k8temp patches. After some
> reorganization I came up with the following stack:
>=20
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-01-=
warn-about-errata.patch
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-02-=
fix-wrong-sensor-selection-for-revf-revg.patch
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-03-=
fix-temperature-reporting-for-most-revg.patch
>=20
> These are in linux-next at the moment, and I'd like to push them to
> Linus quickly. But I do not own any rev.F nor rev.G CPU myself, so I
> couldn't really test the patches, other than ensure that they do not
> cause a regression on earlier K8 CPUs.
>=20
> So this is a call to owners of rev.F and rev.G K8 CPUs, to try these
> patches and report how they are doing. There's also a standalone
> version of the updated driver at:
>   http://jdelvare.pck.nerim.net/sensors/k8temp/
> if it is easier for you.
>=20

Ok,

I've just tested this on my x2 5000, I did so with 2 loaded cores to also=20
answer the questions about the 2 per core temps being pretty far apart when=
 idle:

Loaded for about a minute:
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +52.0=B0C
Core0 Temp:  +51.0=B0C
Core1 Temp:  +54.0=B0C
Core1 Temp:  +47.0=B0C

And after being loaded for some minutes:
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +56.0=B0C
Core0 Temp:  +56.0=B0C
Core1 Temp:  +58.0=B0C
Core1 Temp:  +52.0=B0C


The readings loook much saner now then with the driver in 2.6.28 (the +21=20
degrees helps!)

cpu revision info:
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 107
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 5000+
stepping        : 2

I also get:
k8temp 0000:00:18.3: Temperature readouts might be wrong - check erratum #1=
41


Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
