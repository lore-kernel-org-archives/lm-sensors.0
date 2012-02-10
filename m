From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Fri, 10 Feb 2012 18:14:06 +0000
Subject: Re: [lm-sensors] [PATCH v5 4/5] hwmon: add MAX197 support
Message-Id: <20120210131406.28c3a00b@v0nbox>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328130344-18836-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<1328130344-18836-5-git-send-email-vivien.didelot@savoirfairelinux.com>
	<1328132138.2261.116.camel@groeck-laptop>
	<20120206151507.73a23eb8@v0nbox>
	<1328561164.2261.258.camel@groeck-laptop>
	<20120210110755.4914b332@v0nbox>
	<20120210161538.GB1060@ericsson.com>
In-Reply-To: <20120210161538.GB1060@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>

Le Fri, 10 Feb 2012 08:15:38 -0800,
Guenter Roeck <guenter.roeck@ericsson.com> a =E9crit :

> Vivien,
>=20
> On Fri, Feb 10, 2012 at 11:07:55AM -0500, Vivien Didelot wrote:
> > Hi,
> >=20
> > On Mon, 6 Feb 2012 12:46:04 -0800,
> > Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> >=20
> > > On Mon, 2012-02-06 at 15:15 -0500, Vivien Didelot wrote:
> > > [ ... ]
> > > >=20
> > > > BTW, about the TS-5500 ADC part, is a platform ts5500_adc.c
> > > > file the better solution, or should the device be declared in
> > > > the ts5500.c platform code?
> > > >=20
> > > I would suggest to declare it in the ts5500.c platform code. That
> > > seems to be the common approach as far as I can see.
> > >=20
> > > platform_add_devices() works pretty well for this. It saves you
> > > from having to call platform_device_register() for each device
> > > separately. Obviously that only works if all devices are declared
> > > in a single file.
> >=20
> > As the LED is registered using the leds_class, I think
> > platform_add_devices() couldn't be used here.
> >=20
> > Lots of platform codes don't check the returned
> > value of platform_add_devices(). Should we care about a LED or ADC
> > registration failure (is the following snippet OK?)?
> >=20
> >     static int __init ts5500_init(void)
> >     {
> >     [...]
> >         pdev =3D platform_device_register_simple("ts5500", -1, NULL,
> > 0); if (IS_ERR(pdev)) {
> >                 ret =3D PTR_ERR(pdev);
> >                 goto release_mem;
> >         }
> >         platform_set_drvdata(pdev, ts5500);
> >    =20
> >         ret =3D sysfs_create_group(&pdev->dev.kobj,
> >                                  &ts5500_attr_group);
> >         if (ret)
> >                 goto release_pdev;
> >    =20
> >         led_classdev_register(&pdev->dev, &ts5500_led_cdev);
> >         if (ts5500->adc) {
> >                 ts5500_adc_pdev.dev.parent =3D &pdev->dev;
> >                 platform_device_register(&ts5500_adc_pdev);
> >         }
> >    =20
> I didn't look at other code, but personally I try to be consistent.
> Why do you check the return value from
> platform_device_register_simple() above, but not the return code from
> platform_device_register() ? That does not seem to be very consistent
> to me.

I check the platform_device_register_simple() returned value because it
is the platform itself, while the others are on-board devices. I
thought that it is not a big deal if their registrations failed but the
platform registration succeeded. Maybe I'm wrong and I should check
everything.

Thanks,
Vivien.

>=20
> Thanks,
> Guenter
>=20
> >         return 0;
> >    =20
> >         release_pdev:
> >                 platform_device_unregister(pdev);
> >         release_mem:
> >                 kfree(ts5500);
> >    =20
> >                 return ret;
> >     }
> >     device_initcall(ts5500_init);
> >=20
> >=20
> > Thanks,
> >=20
> >=20
> > --=20
> > Vivien Didelot
> > Savoir-faire Linux Inc.
> > Tel: (514) 276-5468 #149



--=20
Vivien Didelot
Savoir-faire Linux Inc.
Tel: (514) 276-5468 #149

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
