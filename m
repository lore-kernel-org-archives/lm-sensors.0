From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Fri, 09 Jan 2009 14:41:02 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (k8temp) fix temperature
Message-Id: <20090109144102.GZ10725@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215231213.GC7013@alberich.amd.com>
In-Reply-To: <20081215231213.GC7013@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jan 09, 2009 at 02:34:39PM +0100, Jean Delvare wrote:
> > @@ -176,6 +179,16 @@ static int __devinit k8temp_probe(struct pci_dev *=
pdev,
> >  				 "wrong - check erratum #141\n");
> >  		}
> > =20
> > +		if (((model >=3D 0x68) && (model !=3D 0xc1)) &&
> > +		    !(model =3D 0x68) && !(model =3D 0x6c) &&
> > +		    !(model =3D 0x7c))
>=20
> This test is pretty confusing, with these extra parentheses and the mix
> of (a !=3D b) and !(a =3D b). What about the following instead? As far as
> I can see, it leads to the same results, but is much more readable:
>=20
> 		if (model >=3D 0x69 &&
> 		    !(model =3D 0xc1 || model =3D 0x6c || model =3D 0x7c))
>=20

Well, right you are.

When I wrote the check I had following in mind:

  Check for RevG:

  ((model >=3D 0x68) && (model !=3D 0xc1)) // excluding ATHLON64 FX, "JH-F3"

  and after that exclude all mobile parts:

  !(model =3D 0x68) && !(model =3D 0x6c) && !(model =3D 0x7c))

Of course this can be simplified.

> > +			/*
> > +			 * RevG desktop CPUs (i.e. no socket S1G1 parts)
> > +			 * need additional offset, otherwise reported
> > +			 * temperature is below ambient temperature
> > +			 */
> > +			data->temp_offset =3D 21000;
>=20
> If you apply the same offset to all sensors, you'll still obtain
> something odd:
>=20
>  k8temp-pci-00c3
>  Adapter: PCI adapter
>  Core0 Temp:
>               +38=B0C
>  Core0 Temp:
>               +24=B0C
>  Core1 Temp:
>               +42=B0C
>  Core1 Temp:
>               +26=B0C
>=20
> That's not terribly realistic, is it? Unless both sensors for a given
> core are very far apart -
> but I suspect each core is pretty small,
> isn't it?

"Far" is relative, isn't it ;-)

Guess this is from an idle system.
Please bring load on both cores and look at the temperature
differences again.




Regards,

Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
