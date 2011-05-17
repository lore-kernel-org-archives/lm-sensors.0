From: Fabien Marteau <fabien.marteau@armadeus.com>
Date: Tue, 17 May 2011 07:06:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for as1531,
Message-Id: <4DD21E5E.9000605@armadeus.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <fabien.marteau@armadeus.com> <1305553154-18195-2-git-send-email-fabien.marteau@armadeus.com> <20110516153900.GA31255@ericsson.com>
In-Reply-To: <20110516153900.GA31255@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Guenter,

Thanks for the review.

On 16/05/2011 17:39, Guenter Roeck wrote:
> On Mon, May 16, 2011 at 09:39:14AM -0400, fabien.marteau@armadeus.com wrote:
>> From: Fabien Marteau <fabien.marteau@armadeus.com>
>>
>>
> Some description, such as "Dhis driver adds support for xxx" would be nice.
> 
> Also, I wonder if this driver belongs into hwmon in the first place. It is
> a generic ADC chip with high conversion rate. iio would probably be more
> appropriate and also much better in supporting high speed readings.
I provided this driver "as is" because it's a driver that work well on
our platform. I thought that iio was not stable enough driver framework
to be used.
I can rewrite it under iio framework but I have no time for this moment
to do that. You think it's better to wait for an iio driver or to
continue commiting this ?

regards,
Fabien M

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
