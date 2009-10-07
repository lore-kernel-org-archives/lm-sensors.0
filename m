From: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Date: Wed, 07 Oct 2009 17:20:39 +0000
Subject: Re: [lm-sensors] [RFC][PATCH 0/2] LIS3LV02D I2C driver
Message-Id: <4ACCCDE7.1090508@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1254391591-9696-1-git-send-email-samu.p.onkalo@nokia.com> <4ACCC273.1030308@gmail.com> <4ACCC957.3060802@tremplin-utc.net>
In-Reply-To: <4ACCC957.3060802@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>

=C9ric Piel wrote:
> Op 07-10-09 18:31, Jonathan Cameron schreef:
>  =20
>> Just a quick heads up wrt overlapping work.
>>
>> For the i2c support Kalhan Trisal has been posting patches for i2c
>> support for this
>> driver to the lm-sensors list for some time and the latest version of th=
at
>> set is also pretty clean.
>>    =20
> You mean this post, right?
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-August/026505.html
> "Accelerometer driver for STMicroeletronics-LIS331DL-three-axis-digital"
> Thanks for the heads up, I had never heard of this driver before.
>  =20
I think that was the original post. (sorry should have added references!)

> Well, it's for the LIS331DL, not the LIS3LV02DL (12 bits) or the
> LIS302DL (8 bits) (both supported by lis3lv02d driver). That said,
> according to the specs, it seems to be _very_ similar to the LIS302DL,
> they even report the same "who_am_i" value. Just some special features
> are different (free fall detection for instance).
>  =20
Yes, that's why he was advised to combine it with your driver leading
via about 3 revisions
to
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-October/026840.html
(removed a few pointless headers from previous version
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-September/026706.html
.)


which at first glance is pretty much the same as Samu's driver.
(hence real issue with overlapping work).

I do wonder if it is worth adding a mailing list entry to the driver
MAINTAINERS
entry (unless lm-sensors is where you do want anything relevant to be
discussed?).
Problem here is this evolved in a thread not initially related to your
driver and hence I guess no one noticed you weren't cc'd when it became
relevant.

Jonathan

p.s. Kalhan, btw, just noticed a typo in the patch message :
Macroelectronics->Microelectronics.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
