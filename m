From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 05 Nov 2014 23:21:55 +0000
Subject: Re: [lm-sensors] Kaveri [and Radeon] temps
Message-Id: <20141105232155.GA25189@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <m31tph9wmt.fsf@carbon.jhcloos.org>
In-Reply-To: <m31tph9wmt.fsf@carbon.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Cloos <cloos@jhcloos.com>
Cc: dri-devel@lists.freedesktop.org, lm-sensors@lm-sensors.org

On Wed, Nov 05, 2014 at 04:15:54PM -0500, James Cloos wrote:
> I'm getting odd temp readings on an A8-7600 with 3.3.4 and Linus'
> current kernel.
>=20
> Eg, the gpu temp shows up when (mostly) idle as:
>=20
>  radeon-pci-0008
>  Adapter: PCI adapter
>  temp1:         -1.0=B0C  (crit =3D +120.0=B0C, hyst =3D +90.0=B0C)
>=20
The driver for the Radeon chips is maintained by the radeon driver
maintainers, so you might want to ask at dri-devel@lists.freedesktop.org
(copied with this reply). The driver supports different chips with
different methods to read the temperature, so it might help to know
which chip is in your system (lspci -nn should tell you).

> aka:
>=20
>  radeon-pci-0008
>  Adapter: PCI adapter
>  temp1:        +32.0=B0F  (crit =3D +248.0=B0F, hyst =3D +194.0=B0F)
>=20
>=20
> And the cpu temp is similar:
>=20
>  k10temp-pci-00c3
>  Adapter: PCI adapter
>  temp1:         +0.0=B0C  (high =3D +70.0=B0C)
>                         (crit =3D +80.0=B0C, hyst =3D +79.0=B0C)
> aka:
>=20
>  k10temp-pci-00c3
>  Adapter: PCI adapter
>  temp1:        +32.0=B0F  (high =3D +158.0=B0F)
>                         (crit =3D +176.0=B0F, hyst =3D +174.2=B0F)
>=20
AMD CPUs are known report wildly off temperatures especially at
low temperatures. Does the temperature increase with load ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
