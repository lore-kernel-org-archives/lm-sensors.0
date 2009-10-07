From: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Date: Wed, 07 Oct 2009 17:01:11 +0000
Subject: Re: [lm-sensors] [RFC][PATCH 0/2] LIS3LV02D I2C driver
Message-Id: <4ACCC957.3060802@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1254391591-9696-1-git-send-email-samu.p.onkalo@nokia.com> <4ACCC273.1030308@gmail.com>
In-Reply-To: <4ACCC273.1030308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>

Op 07-10-09 18:31, Jonathan Cameron schreef:
> Just a quick heads up wrt overlapping work.
>=20
> For the i2c support Kalhan Trisal has been posting patches for i2c
> support for this
> driver to the lm-sensors list for some time and the latest version of that
> set is also pretty clean.
You mean this post, right?
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-August/026505.html
"Accelerometer driver for STMicroeletronics-LIS331DL-three-axis-digital"
Thanks for the heads up, I had never heard of this driver before.

Well, it's for the LIS331DL, not the LIS3LV02DL (12 bits) or the
LIS302DL (8 bits) (both supported by lis3lv02d driver). That said,
according to the specs, it seems to be _very_ similar to the LIS302DL,
they even report the same "who_am_i" value. Just some special features
are different (free fall detection for instance).
>=20
> The changes in these two patch sets should probably be reconciled before
> merging.

Yes, at least from a 5 minutes look, it seems it should be possible to
merge both drivers. Samu's i2c implementation is pretty clean as well
and IMHO it seems the Right Thing to have all the bus specific parts
(I=B2C, SPI, ACPI/HP) "inheriting" from a generic driver. So I think we
should try to merge everything in the lis3lv02d driver. Kalhan, would
you mind having a look at the patch from Samu, and see what is required
to get your LIS331DL working with the lis3lv02d driver? It should be
very little and avoid duplication of efforts :-)

See you,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
