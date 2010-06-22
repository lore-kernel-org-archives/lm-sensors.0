From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Date: Tue, 22 Jun 2010 11:24:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon,
Message-Id: <20100622112403.GB4524@loge.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100622084557.GA4524@loge.amd.com>
In-Reply-To: <20100622084557.GA4524@loge.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Jun 22, 2010 at 01:35:33PM +0200, Jean Delvare wrote:
> Hi Andreas,
>=20
> On Tue, 22 Jun 2010 10:45:57 +0200, Andreas Herrmann wrote:
> > From: Andreas Herrmann <andreas.herrmann3@amd.com>
> >=20
> > Reported temperature for ASB1 CPUs is too high.
> > Add ASB1 CPU revisions (these are also non-desktop variants) to the
> > list of CPUs for which the temperature fixup is not required.
> >=20
> > Example: (from LENOVO ThinkPad Edge 13, 01972NG, system was idle)
> >=20
> >   Current kernel reports
> >=20
> >   $ sensors
> >   k8temp-pci-00c3
> >   Adapter: PCI adapter
> >   Core0 Temp:  +74.0=B0C
> >   Core0 Temp:  +70.0=B0C
> >   Core1 Temp:  +69.0=B0C
> >   Core1 Temp:  +70.0=B0C
> >=20
> >   With this patch I have
> >=20
> >   $ sensors
> >   k8temp-pci-00c3
> >   Adapter: PCI adapter
> >   Core0 Temp:  +54.0=B0C
> >   Core0 Temp:  +51.0=B0C
> >   Core1 Temp:  +48.0=B0C
> >   Core1 Temp:  +49.0=B0C
> >=20
> > Cc: <stable@kernel.org> # .32.x .33.x, .34.x
> > Cc: Rudolf Marek <r.marek@assembler.cz>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> > ---
> >  drivers/hwmon/k8temp.c |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> >=20
> > I think this patch should go into .35.
>=20
> I agree, I've applied it, thanks for your contribution.
>=20
> > Patch was built against Linus' git v2.6.35-rc3-3-g9a3cde2.
> > (Hope that there is no conflict with your recent fix for single core
> > CPUs.)
>=20
> No, there is not.
>=20
> > diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> > index 0ceb6d6..1fdd63e 100644
> > --- a/drivers/hwmon/k8temp.c
> > +++ b/drivers/hwmon/k8temp.c
> > @@ -180,11 +180,13 @@ static int __devinit k8temp_probe(struct pci_dev =
*pdev,
> >  		}
> > =20
> >  		if ((model >=3D 0x69) &&
> > -		    !(model =3D 0xc1 || model =3D 0x6c || model =3D 0x7c)) {
> > +		    !(model =3D 0xc1 || model =3D 0x6c || model =3D 0x7c ||
> > +		      model =3D 0x6b || model =3D 0x6f || model =3D 0x7f)) {
> >  			/*
> > -			 * RevG desktop CPUs (i.e. no socket S1G1 parts)
> > -			 * need additional offset, otherwise reported
> > -			 * temperature is below ambient temperature
> > +			 * RevG desktop CPUs (i.e. no socket S1G1 or
> > +			 * ASB1 parts) need additional offset,
> > +			 * otherwise reported temperature is below
> > +			 * ambient temperature
> >  			 */
> >  			data->temp_offset =3D 21000;
> >  		}
>=20
> I would like to avoid having to update this list each time a new CPU
> model is released. Are there more K8 models scheduled to be released?

I am not aware of other models. I think the ASB1 parts were the last
updates of that CPU family. Those Athlon/Turion Neo CPUs are on the
market for quite some time now. I've encountered that problem because
I have such a CPU in my Laptop.

> If there are, we should come up with a better test, either by
> defaulting to no offset if all newer models don't need it, or by using
> a socket-based detection as we do in the k10temp driver, assuming this
> is available on the K8 as well.

Unfortunately on K8 socket type information is not provided with CPUID
like its done for family 0x10. Thus the socket type must be derived
from the CPU revision and information contained in the CPU revision
guide.

I think (hope) that this list needs no update anymore.


Thanks,


Andreas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
