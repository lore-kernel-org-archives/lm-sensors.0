From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Oct 2007 12:23:20 +0000
Subject: Re: [lm-sensors] What todo with driver entry in sensors-detect for
Message-Id: <20071019142320.3ae630ac@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47187757.3000308@hhs.nl>
In-Reply-To: <47187757.3000308@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 19 Oct 2007 11:22:31 +0200, Hans de Goede wrote:
> I just remembered that I still need to update 2.10.5's sensors-detect for the 
> new fschmd driver. I've left the fscpos and fscher drivers in there for now as 
> fschmd will not be available until 2.6.24 gets released.
> 
> But what should I do with the fscscy entry? The fscscy driver is only available 
> in 2.4 and in 2.6 the fschmd driver should be used.

We have a mechanism for that already, search for @chip_kern24_ids and
@chip_kern26_ids. When a different driver should be used for 2.4 and
2.6 kernels, add one entry in each of these lists instead of @chip_ids.

The fscher and fscpos cases are actually more difficult to handle. You
changed sensors-detect in branch lm-sensors-3.0.0 to always select the
new driver (fschmd) for all FSC chips. This is only correct for kernels
>= 2.6.24, while this branch is supposed to support kernels as old as
2.6.5! So you need to update sensors-detect to take this into account,
and select the old driver for kernels 2.6.23 and older. Look at
chip_special_cases and do something similar.

On top of that, please keep in mind that trunk should still support 2.6
kernels, including future ones, as much as possible. This means that it
should also know about the fschmd driver for kernels >= 2.6.24. In
fact, I would like to keep sensors-detect in both branches in sync as
long as possible, it's much easier to maintain that way.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
