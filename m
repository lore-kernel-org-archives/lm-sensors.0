From: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 24 Nov 2012 10:18:04 +0000
Subject: Re: [lm-sensors] MAX1363 IIO driver questions
Message-Id: <50B09EDC.4020200@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121124052707.GA17392@roeck-us.net>
In-Reply-To: <20121124052707.GA17392@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On 11/24/2012 05:27 AM, Guenter Roeck wrote:
> Hi all,
Hi Guenter,
> 
> What would it take to move the MAX1363 driver out of staging ?
>
Nothing given it is already out of staging in linux-next (though only has been
for about a week)

> Background is that I need a hardware monitoring driver for MAX1139, and would
> like to avoid using a driver from staging if possible (after all, it might
> go away anytime). Another option would be to submit a hwmon driver for it,
> but that doesn't seem to be the best approach.

The hwmon driver client driver for iio devices is still in staging, but mainly
because I haven't had a chance to take a last look at it before posting it to
the hmwon list.  IIRC you were more or less happy with what went into staging
in the first place, so hopefully not too much left to do.

Jonathan
> 
> Thanks,
> Guenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
