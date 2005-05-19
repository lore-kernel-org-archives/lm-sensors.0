From: patrick@dreker.de (Patrick Dreker)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: LM Sensors and Kernel 2.5 (Nvidia Nforce2)
Message-Id: <200307120438.06859.patrick@dreker.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307110439.33500.patrick@dreker.de>
In-Reply-To: <200307110439.33500.patrick@dreker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Samstag, 12. Juli 2003 01:31 schrieb Greg KH <greg@kroah.com> zum Thema Re: 
LM Sensors and Kernel 2.5 (Nvidia Nforce2):
> > 1) port or integrate i2c-nforce2 from LM-Sensors CVS into kernel 2.5
> > 2) adapt libsensors to use sysfs
> > (correct me if I am wrong...)
> Yup, that sounds about right.
Fine.

> > Question: Is anybody already doing one or both of the above?
> Nope, not that I know of.
Not so nice...

> Can you port the i2c-nforce2 driver to the 2.5 kernel?  I outlined the
> steps necessary to do this in an older email (it's in the archives
> somewhere, if you can't find it I can dig it up.)
I think I found it and it sounds too easy to be true, but I'll take my chances 
and go for the driver.

> Or if you want to start working on the sysfs version of libsensors, that
> would be great too.
One step after the other...

Patrick
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/D3SLcERm2vzC96cRAmBCAJ9IxHv7PV1x5uCCiFVypEW4eHfEFACdF+Z8
kGQAIIF56DzQHrF712AmS7g=Gw33
-----END PGP SIGNATURE-----
