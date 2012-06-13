From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Jun 2012 16:05:53 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <20120613180553.525ebfa1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
In-Reply-To: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 Jun 2012 06:51:32 -0700, Guenter Roeck wrote:
> I suspect it requires additional patches to work. Jean might know.
> fe61e07e9ebc890c70d97a1f72ddaad4bee2d848 seems relevant, and there may be others,
> even infrastructure changes.

fe61e07e9ebc890c70d97a1f72ddaad4bee2d848 is certainly relevant too,
yes. I can't think of anything else, but that was long ago, so I could
miss something else.

> Can you switch to a more recent kernel ?

This would seem reasonable, yes, 2.6.34 is getting very old and
unsupported, and it did not even support I2C multiplexing so I take it
that you already did a fair amount of backport to get to the kernel
you're currently running. No real surprise you get into trouble...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
