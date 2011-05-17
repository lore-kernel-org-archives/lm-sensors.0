From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 17 May 2011 09:25:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for as1531,
Message-Id: <4DD23EED.4010201@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <fabien.marteau@armadeus.com> <1305553154-18195-2-git-send-email-fabien.marteau@armadeus.com> <20110516153900.GA31255@ericsson.com> <4DD21E5E.9000605@armadeus.com>
In-Reply-To: <4DD21E5E.9000605@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fabien.marteau@armadeus.com
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/17/11 08:06, Fabien Marteau wrote:
> Hi Guenter,
> 
> Thanks for the review.
> 
> On 16/05/2011 17:39, Guenter Roeck wrote:
>> On Mon, May 16, 2011 at 09:39:14AM -0400, fabien.marteau@armadeus.com wrote:
>>> From: Fabien Marteau <fabien.marteau@armadeus.com>
>>>
>>>
>> Some description, such as "Dhis driver adds support for xxx" would be nice.
>>
>> Also, I wonder if this driver belongs into hwmon in the first place. It is
>> a generic ADC chip with high conversion rate. iio would probably be more
>> appropriate and also much better in supporting high speed readings.
> I provided this driver "as is" because it's a driver that work well on
> our platform. I thought that iio was not stable enough driver framework
> to be used.
> I can rewrite it under iio framework but I have no time for this moment
> to do that. You think it's better to wait for an iio driver or to
> continue commiting this ?
I'd say that if you primary use is hwmon, put it there for now and we can think
about moving it at a later date depending on how people are actually using it.
Guenter, would that be ok for you?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
