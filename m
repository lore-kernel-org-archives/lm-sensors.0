From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 10 Oct 2009 07:34:08 +0000
Subject: Re: [lm-sensors] [Module] hwmon: GM/GME965 GM45 and more chips IGP
Message-Id: <20091010093408.13bdc3ab@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907180440p43b81f33x85c4dc70007165b3@mail.gmail.com>
In-Reply-To: <73511e6c0907180440p43b81f33x85c4dc70007165b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Lu,

On Fri, 9 Oct 2009 14:07:41 +0000, Lu Zhihe wrote:
> Hi Jean,
>=20
>      Thank you very much for your reply!
>=20
> 2009/10/8 Jean Delvare <khali@linux-fr.org>:
> > Hi Lu,
> > Can you please elaborate about it? Don't you ever plan to get your
> > driver included in the kernel tree?
>=20
>    I am glad to know you think it maybe worth to merge to the kernel
> tree. :-)  Thank you again!
> Sure, if it can even be merged, I will try to improve it to meet the
> need.  Tobias and I had work on this aim too.

OK, great. Then please send the latest version of you driver as a patch
on top of Linus' latest kernel, and I'll review it.

> > If your driver won't ever be merged, I admit I am not interested in
> > reviewing it. If the plan is to merge it, then I will review it.
> >
> > I can't test your code, I do not have any supporter piece of hardware,
> > sorry.
> >
> > I've looked at the intel-agp driver, which binds to the same PCI
> > devices. It's way too big and complex to resort to the same hack we
> > have in sis5595 and i2c-sis5595 for example. The intel-agp driver must
> > remain a "real" pci driver which binds to its devices, in particular so
> > that power management works OK.
> >
> > This leaves us with 3 alternatives.
> >
> > 1* Add hwmon support to the intel-agp driver directly. As this driver
> > =A0 is already somewhat big (77 kB) it would probably go unnoticed. The
> > =A0 hwmon part in your driver is probably about 350 lines of code.
> >
> > 2* Implement hwmon as a separate module, simply use pci_get_dev()
> > =A0 during initialization of that module, and if a device is found,
> > =A0 register a platform driver and instantiate a platform device for the
> > =A0 hwmon part. This is essentially what your implementation does,
> > =A0 except that your module registers the platform driver and device
> > =A0 regardless of the presence of a supported chip, which is bad.
> >
> > 3* Let intel-agp instantiate the platform device for hwmon, and only
> > =A0 register the driver in the separate module. This avoid some code
> > =A0 duplication, and we can have the hwmon module auto-load. Maybe the
> > =A0 best compromise code-wise, but possibly somewhat more difficult to
> > =A0 maintain.
> >
> > Note that driver auto-loading should also work with option #2, although
> > your implementation doesn't do it. It shouldn't be too hard to add.
>=20
>    Excuse me, I don''t quite catch about "driver auto-loading". Do you
> meet gm965temp build-in, while not as a module?
>    Can you give me more hint? And I will try to improve gm965temp. Thanks=
 a lot!

No. I am referring to the fact that Linux kernel modules can be loaded
automatically when the supported hardware is present, thanks to udev.

Kernel drivers can come with a list of hardware is supports. When a
device is then instantiated in the kernel, and shows up in sysfs
(somewhere under /sys/devices), udev sees it. If the device declared a
modalias name, udev will test against the supported list provided by
all kernel drivers, and if any matches, the driver in question is
loaded. The idea is that the user no longer has to know or care about
what hardware he/she has: required drivers load automatically.

If you look at the intel-agp driver, the statement which makes
auto-loading possible is:

MODULE_DEVICE_TABLE(pci, agp_intel_pci_table);

This exports to user-space (udev) the list of devices in
agp_intel_pci_table. You can see it by running:

/sbin/modinfo intel-agp

These are all the "alias:" lines.

So, what I want is that your driver loads automatically too, just like
intel-agp. For this you need a MODULE_DEVICE_TABLE call or equivalent.

If you use options 1 or 2 above then you want a pci-based
MODULE_DEVICE_TABLE, exactly as in the intel-agp driver.

If you use option 3, then we probably want a platform-based module
alias.

Anyway, this can easily be added afterwards, when your driver is ready.
So if you don't understand that part, it doesn't matter much.

> > I don't have a strong opinion between these 3 choices, but I want the
> > driver to auto-load as needed.
>=20
> The updated sensor-detect patch based on svn code is as following:
> ---
>=20
> From: Lu Zhihe <tombowfly@gmail.com>
>=20
> Subject: [PATCH] sensors-detect add gm965temp detected for lm-sensors
>=20
> Signed-off-by: Lu Zhihe <tombowfly@gmail.com>
>=20
> ---
>=20
> --- prog/detect/sensors-detect.orig	2009-10-09 21:43:12.000000000 +0000
> +++ prog/detect/sensors-detect	2009-10-09 21:50:13.000000000 +0000
> @@ -147,6 +147,16 @@ $revision =3D~ s/ \([^()]*\)//;
>  		procid	=3D> "Intel SCH",
>  		driver	=3D> "i2c-isch",
>  	}, {
> +		vendid	=3D> 0x8086,
> +		devid	=3D> 0x2a00,
> +		procid	=3D> "Intel GM965",
> +		driver	=3D> "gm965temp",
> +	}, {
> +		vendid	=3D> 0x8086,
> +		devid	=3D> 0x2a10,
> +		procid	=3D> "Intel GME965",
> +		driver	=3D> "gm965temp",
> +	}, {

This part is wrong: these chips are not I2C/SMBus masters!

>  		vendid	=3D> 0x1106,
>  		devid	=3D> 0x3040,
>  		procid	=3D> "VIA Technologies VT82C586B Apollo ACPI",
> @@ -1860,6 +1870,10 @@ use vars qw(@cpu_ids);
>  		driver =3D> "i5k_amb",
>  		detect =3D> \&intel_amb_detect,
>  	}, {
> +		name =3D> "Intel GM/GME965 thermal sensor",
> +		driver =3D> "gm965temp",
> +		detect =3D> \&intel_gm965_detect,
> +	}, {
>  		name =3D> "VIA C7 thermal and voltage sensors",
>  		driver =3D> "c7temp",
>  		detect =3D> \&c7temp_detect,
> @@ -5301,6 +5315,15 @@ sub intel_amb_detect
>  	return;
>  }
>=20
> +sub intel_gm965_detect
> +{
> +        if ((exists $pci_list{'8086:2a00'}) ||  # Intel GM965
> +            (exists $pci_list{'8086:2a10'})) {  # Intel GME965
> +                return 9;
> +        }
> +        return;
> +}
> +

This part is correct, however we want to add all the other chips
supported by your driver, right? Please send an updated patch with all
the chips. It's OK to have a single entry in @cpu_ids if you want, but
all PCI IDs must be listed in intel_gm965_detect().

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
