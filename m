From: David Brownell <david-b@pacbell.net>
Date: Mon, 24 Sep 2007 20:18:39 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc6] lm75: new-style i2c binding,
Message-Id: <20070924201838.355C6219C50@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070916234519.861D3C24EE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070916234519.861D3C24EE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> > Updates and cleanups for lm75:
> >=20
> >  - Update the LM75 driver to handle new-style I2C driver binding
> >    (following the driver model).
> >=20
> >  - Use 12 bit resolution (1/16 degree C) on chips that support it,
> >    instead of 9 bit (1/2 degree C);  needs new conversion routines.
> >=20
> >  - Grow the list of compatible chips; update Kconfig accordingly.
> >=20
> >  - On driver disconnect, restore the original device config (which
> >    usually means shutdown).
> >=20
> >  - Some code cleanups:  a handful of whitespace fixes, and clearly
> >    marking the various driver components (sysfs/hwmon attributes,
> >    driver core support, legacy stuff, register access, module glue).
>
> This is crying for at least two separate patches, and ideally more like
> 3 or 4.

I was fairly sure someone was going to say that.  I take it that
there's no real technical comment on the changes though?


> Additionally, I can't apply your patch to my tree. Presumably you are
> missing recent patches that went into Mark's hwmon-testing tree and
> which affect the lm75 driver:

The location of that tree seems to be hidden.  I did find a GIT
tree of Mark's, but it didn't have any lm75 changes.


> hwmon: Allow writing of negative trigger temperatures
> http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dcommit=
;h=A1efde3fd7b3d94c942b1a675da992c8a2f1f04b

I saw a mention of this patch in the list archives, but didn't see
the patch anywhere.  That'd be a trivial tweak to the patch.


> hwmon: Convert from class_device to device
> http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dcommit=
;h=F89523a27def89ddc74d094a0910970f6a1c6f43

Didn't notice see that one.


> If you split your patch and make sure that the result applies on top of
> the above patches, I'll be happy to review and test your work.

I'll split it out a bit then.


> > The way to kick in higher sample resolution on a given board is to
> > use the new style binding to pass in the chip type.
> >=20
> > One temporary omission:  IRQ support, or for the TI chips SMBALERT#
> > notifications.
>
> --=20
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
