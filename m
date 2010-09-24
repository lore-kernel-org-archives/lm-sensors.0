From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 24 Sep 2010 15:10:06 +0000
Subject: Re: [lm-sensors] [PATCH v2] lis3: Fix Oops with NULL platform data
Message-Id: <4C9CBF4E.7080200@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <s5heiclngqe.wl%tiwai@suse.de>	<20100924135802.GA18109@ericsson.com>	<s5hlj6r1b5p.wl%tiwai@suse.de> <20100924163005.7704f63e@endymion.delvare>
In-Reply-To: <20100924163005.7704f63e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@linux-foundation.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 09/24/10 15:30, Jean Delvare wrote:
> On Fri, 24 Sep 2010 16:14:26 +0200, Takashi Iwai wrote:
>> At Fri, 24 Sep 2010 06:58:02 -0700,
>> Guenter Roeck wrote:
>>>
>>> On Thu, Sep 23, 2010 at 01:58:33AM -0400, Takashi Iwai wrote:
>>>> The recent addition of threaded irq handler causes a NULL dereference
>>>> when used with hp_accel driver, which has NULL pdata.
>>>>
>>>> Acked-by: Samu Onkalo <samu.p.onkalo@nokia.com>
>>>> Acked-by: Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
>>>> Cc: <stable@kernel.org>
>>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>>
>>> Applied.
>>
>> Oh, does this driver belong to hwmon tree?
>> Jean told me that this isn't managed in hwmon, so I had an impression
>> that it's an orphan driver.
> 
> Well, as long as the driver lives in drivers/hwmon and the hwmon
> subsystem is maintained, it seems fair to consider the driver
> maintained.
Technically hwmon is orphan (according to MAINTAINERS.) But that's not to
say that various people aren't looking after various parts of it and
I believe Andrew Morton is acting as maintainer of last resort.
> 
> That being said, I indeed would like all non-hwmon drivers to go away
> from drivers/hwmon. Originally we were waiting for iio to settle first,
> but apparently this is taking forever.
More developers and code reviewers always welcome!
> The 4 drivers I would like to
> kick are: ams, hdaps, lis3lv02d and applesmc. They are primarily
> accelerometer device drivers. Not sure where to put them,
> drivers/accel(erometer), drivers/misc, drivers/misc/accel(erometer),
> drivers/input/accel(erometer)... Opinions welcome.
If the primary use is as an input device then talk to Dmitry. Some
accelerometers are being taken into input. There are some open questions
on naming etc currently being debated so anyone interested should get
involved in those asap.

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
