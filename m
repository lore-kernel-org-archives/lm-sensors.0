From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Aug 2010 19:21:42 +0000
Subject: Re: [lm-sensors] W83667HG-B testing
Message-Id: <20100814212142.42414963@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C42ED6C.9030903@preclik.de>
In-Reply-To: <4C42ED6C.9030903@preclik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 20 Jul 2010 18:40:17 -0700, Guenter Roeck wrote:
> I did some research on the web. Looks like temp3 almost always shows
> very low temperatures for the W83667, and also for w83627ehf. Also, since
> the reading is low, but there is no low limit, there isn't really a reason
> for raising an alarm. 
> 
> Also, min/max values for voltages seem to be off almost everywhere.
> And values for temp1_max and temp1_hyst are often negative or very low.

These chips simply don't initialize the limits to anything sane by
default. It's the user's (or BIOS') job to write sane limits. This
doesn't mean anything about the driver.

> So, in summry, looks like -B support is just as good or as bad as support
> for the other chips. Not sure if that is good or bad, though, since the 
> off-track readings are so common.

Off-track reading are "fine" as long as the alarm flags match.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
