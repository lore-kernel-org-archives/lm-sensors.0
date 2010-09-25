From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 25 Sep 2010 11:01:25 +0000
Subject: Re: [lm-sensors] [PATCH v2] lis3: Fix Oops with NULL platform data
Message-Id: <20100925130125.049401a0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <s5heiclngqe.wl%tiwai@suse.de>
	<20100924135802.GA18109@ericsson.com>
	<s5hlj6r1b5p.wl%tiwai@suse.de>
	<20100924163005.7704f63e@endymion.delvare>
	<4C9CBF4E.7080200@cam.ac.uk>
In-Reply-To: <4C9CBF4E.7080200@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@linux-foundation.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, =?ISO-8859-1?B?yXJpYw==?= Piel <Eric.Piel@tremplin-utc.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 24 Sep 2010 16:10:06 +0100, Jonathan Cameron wrote:
> On 09/24/10 15:30, Jean Delvare wrote:
> > That being said, I indeed would like all non-hwmon drivers to go away
> > from drivers/hwmon. Originally we were waiting for iio to settle first,
> > but apparently this is taking forever.
> More developers and code reviewers always welcome!

Just to clear any confusion: this wasn't a criticism from my side. I
understand why it takes time. All I mean is that it is not reasonable
to delay other changes waiting for IIO to hit mainline. Because we have
no idea when that will happen.

> > The 4 drivers I would like to
> > kick are: ams, hdaps, lis3lv02d and applesmc. They are primarily
> > accelerometer device drivers. Not sure where to put them,
> > drivers/accel(erometer), drivers/misc, drivers/misc/accel(erometer),
> > drivers/input/accel(erometer)... Opinions welcome.
> If the primary use is as an input device then talk to Dmitry. Some
> accelerometers are being taken into input. There are some open questions
> on naming etc currently being debated so anyone interested should get
> involved in those asap.

Let's see if he wants them. I seem to recall he objected to them going
to input, on the basis that the input function was a not the key
feature. But apparently we have one accel driver in drivers/input/misc
(adxl34x) so maybe we can have more.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
