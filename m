From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Thu, 07 Jan 2010 01:59:29 +0000
Subject: Re: [lm-sensors] sensors show hdd temp instead of cpu temp using
Message-Id: <20100107015929.GA2131@owl>
List-Id: <lm-sensors.vger.kernel.org>
References: <b4184b2f1001041651x593dec41tf7e6a0dc71acecf8@mail.gmail.com>
In-Reply-To: <b4184b2f1001041651x593dec41tf7e6a0dc71acecf8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 19:51 Mon 04 Jan, vajorie wrote:
> Hi,
>=20
> I guess this could be a follow up from my previous email trying to get
> lm-sensors working in this laptop. Since kernel 2.6.32, coretemp seems
> to support atom cpus, as I found out, but the temperature reported as
> cpu temperature (I guess?) is hdd temperature, not cpu temperature.
>=20
> The bug report in kernel.org indicated that I should report it here.
> Here is that bug report:
> http://bugzilla.kernel.org/show_bug.cgi?id=11161
>=20
> Here's some info that I hope is useful:
>=20
> Motherboard: I don't know (an Acer netbook using Atom N280 cpu)
>=20
> lm-sensors v. 3.1.1
>=20
> kernel 2.6.32 (arch linux)
>=20
> sensors output:
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +45.0=B0C  (crit =3D +90.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +45.0=B0C  (crit =3D +90.0=B0C)
>=20
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +26.8=B0C  (crit =3D +100.0=B0C)
>=20

You can get the hdd temperature through hddtemp[1].=20

Coretemp get CPU temperature data from MSR directly. The data in
MSR is reported by the on-die DTS (Digital Temperature Sensor), it
reflects the delta between the current temperature and the maximum
junction temperature of the die(Tj).


[1] http://savannah.nongnu.org/projects/hddtemp/

Thanks
Huaxu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
