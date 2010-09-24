From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Date: Fri, 24 Sep 2010 15:22:01 +0000
Subject: Re: [lm-sensors] [PATCH v2] lis3: Fix Oops with NULL platform data
Message-Id: <4C9CC219.4090304@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <s5heiclngqe.wl%tiwai@suse.de>	<20100924135802.GA18109@ericsson.com>	<s5hlj6r1b5p.wl%tiwai@suse.de> <20100924163005.7704f63e@endymion.delvare>
In-Reply-To: <20100924163005.7704f63e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guenter Roeck <guenter.roeck@ericsson.com>, Andrew Morton <akpm@linux-foundation.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Op 24-09-10 16:30, Jean Delvare schreef:
> Well, as long as the driver lives in drivers/hwmon and the hwmon
> subsystem is maintained, it seems fair to consider the driver
> maintained.
> 
> That being said, I indeed would like all non-hwmon drivers to go away
> from drivers/hwmon. Originally we were waiting for iio to settle first,
> but apparently this is taking forever. The 4 drivers I would like to
> kick are: ams, hdaps, lis3lv02d and applesmc. They are primarily
> accelerometer device drivers. Not sure where to put them,
> drivers/accel(erometer), drivers/misc, drivers/misc/accel(erometer),
> drivers/input/accel(erometer)... Opinions welcome.
As maintainer of the lis3lv02d driver, I'd completely support the move too.

IMHO, an accelerometer is just another input device (usually with 2 or 3
axes), so moving them to drivers/input/accel would make sense.

Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
