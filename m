From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Tue, 25 Aug 2015 00:19:36 +0000
Subject: Re: [lm-sensors] [RFC] i2c: Revert back to old device naming for ACPI enumerated I2C slaves
Message-Id: <2688486.RKUY9k7hgx@vostro.rjw.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8540522221881012566=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com> <20150824132612.GA10078@katana>
In-Reply-To: <20150824132612.GA10078@katana>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Dustin Byford <dustin@cumulusnetworks.com>, linux@roeck-us.net


--===============8540522221881012566==
Content-Type: multipart/signed; boundary="nextPart1520531.O02NFJvkWi"; micalg="pgp-sha256"; protocol="application/pgp-signature"


--nextPart1520531.O02NFJvkWi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, August 24, 2015 03:26:13 PM Wolfram Sang wrote:
> On Mon, Aug 24, 2015 at 01:52:02PM +0300, Jarkko Nikula wrote:
> > Commit 70762abb9f89 ("i2c: Use stable dev_name for ACPI enumerated I2C
> > slaves") broke the lm-sensors which relies on I2C hwmon slave devices under
> > /sys/bus/i2c/devices/ to be named as "x-00yz". However if those hwmon
> > devices are ACPI 5 enumerated their name became "i2c-INTABCD:ij" and sysfs
> > code in lm-sensors does not find them anymore:
> > 
> > lib/sysfs.c:665:
> > if ((!subsys || !strcmp(subsys, "i2c")) &&
> >     sscanf(dev_name, "%hd-%x", &entry.chip.bus.nr,
> > 	   &entry.chip.addr) == 2) {
> > 
> > This patch fixes this by reverting back the old device naming in i2c-core
> > but at the same avoids regression to ALSA SoC drivers that depend on stable
> > device binding.
> 
> This way we fix some userspace by going back. However, this name change
> was effective for 18 months, so enough time for some other userspace to
> adapt. We would break the latter by reverting.

Right.

Generally, reverts of such things need to be made relatively quickly.

> I tend to create the symlinks to prevent any further breakage. I am open
> for other suggestions, though. This ugly situation has surely happened
> before somewhere somewhen in the kernel :/

It happens on a regular basis.

In this particular case it looks like we need a mechanism to use the old
naming scheme for hwmon and the new one for everything else or something
similar.  I'm afraid I am not familiar enough with the i2c core to suggest
anything specific ATM, though.

Thanks,
Rafael

--nextPart1520531.O02NFJvkWi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJV27SfAAoJEILEb/54YlRxsD0P/3SvBX/qDUxkYNJ8pNg6xN7A
/9pNIq+AgGNncYljkG4JWKrUod1Hfw3/lO6WXwx3E8b8zbBdq2B+R2DVJo/gnrb5
zIx0PU83UlG5VgsgEUZKkGMhXGOJAWGpcDKpj6UL2E3XhqeIl42BOKu1DAxXX0ml
BGmdHro8fwqykaUCKS9E4lBGerz/3/QE5nbA2XxDJSMx9N0dU+sDtgdHxIr5KmZ7
E5BqkL/sDn7h6r1n+29tTyAM+z86HaHQGzNmQxmH1SBa0sEnZ7x+p8Td5XULvx80
JtFFw6a/yPnD9CVMtI2XdgWxEmRo6Nr2RcicJAM8rUEuBKNveUKI1lwILnKfvTCF
HCg00DLwhpEQMFwdI1o7hpLAFmBA1DRFkad6HyDveqlCFuryXlSXa7wlYJYwc6yt
GaOuzqgcVSPioy/Jkgn+GJ7RbpmJMc31L+GceFN0iAxhn8cUZtAseIHSzqjChBam
C6mg+hhDawvKqq/huukefmp9Ws/bv2FuiyetLi8Sv0xyjKu7rq2b/x5WGiqsYh9z
WAtQsnGG9XfRiSKbt7yUg5TgEwpLuPs/IRxnV8FAk1JhMHqj4gKy6NPDKRw96opp
id+EbCOWzr+zBljFt393D2NC0ATEgtqJ5G0PJ6MdKueIZDnSRjQH8EJkDbOEbUAf
tJ6J5pPMBZxCj6W3oP65
=Gw3G
-----END PGP SIGNATURE-----

--nextPart1520531.O02NFJvkWi--



--===============8540522221881012566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8540522221881012566==--

