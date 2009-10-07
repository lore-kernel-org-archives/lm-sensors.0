From: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Date: Wed, 07 Oct 2009 17:26:32 +0000
Subject: Re: [lm-sensors] [RFC][PATCH 0/2] LIS3LV02D I2C driver
Message-Id: <4ACCCF48.5090005@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1254391591-9696-1-git-send-email-samu.p.onkalo@nokia.com> <4ACCC273.1030308@gmail.com> <4ACCC957.3060802@tremplin-utc.net>
In-Reply-To: <4ACCC957.3060802@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>

Op 07-10-09 19:01, =C9ric Piel schreef:
> Op 07-10-09 18:31, Jonathan Cameron schreef:
>> Just a quick heads up wrt overlapping work.
>>
>> For the i2c support Kalhan Trisal has been posting patches for i2c
>> support for this
>> driver to the lm-sensors list for some time and the latest version of th=
at
>> set is also pretty clean.
> You mean this post, right?
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-August/026505.html
> "Accelerometer driver for STMicroeletronics-LIS331DL-three-axis-digital"
> Thanks for the heads up, I had never heard of this driver before.

:
> Kalhan, would
> you mind having a look at the patch from Samu, and see what is required
> to get your LIS331DL working with the lis3lv02d driver? It should be
> very little and avoid duplication of efforts :-)
Ah, bah,
I see you have actually already more or less done this!
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-October/026840.html
"I2C glue layer for lis3lv02d STMicroelectronics digital accelerometer"

The main thing you forgot to do with this patch was to CC the maintainer
of the driver (AKA me) ;-)

Anyway, this version is _very_ close to the one from Samu. It has just
all the basics, really clean! Samu has already added some nifty things
(like changing the axis conversion, support for suspend...). So it
should _really_ easy to converge :-) As Samu's patch is already in
Andrew's queue, I think it's simpler to leave it as it, and just to keep
my request to you, Kalhan, to check that it works for your hardware as
well.

See you,
Eric
PS: in a previous iteration, you had fixed the rate reading function for
the 8 bits version of the hardware. Would you mind sending this as a
independent patch, or just letting me "rip off" your fix?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
