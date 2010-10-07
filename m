From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Oct 2010 07:06:03 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] hwmon: (lm90) Add support for
Message-Id: <20101007090603.05b69dcd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286293108-28890-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286293108-28890-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Oct 2010 10:33:06 -0700, Guenter Roeck wrote:
> Hi Jean,
> On Wed, Oct 06, 2010 at 12:07:09PM -0400, Jean Delvare wrote:
> > Note that your algorithm always rounds interval down, even when the
> > closest integer would be up. Proper rounding would need a different
> > algorithm to avoid accumulating rounding errors, I think.
> > 
> > As it stands, requesting a 21 ms update interval will lead to a 31.250
> 
> I think you mean 23 ms, not 21 ms. 21 will report as 15 (you almost got me there).

Yes, sorry, I meant 23. Not sure how I managed to mistype it. I didn't
mean to trick you, it's a genuine typo.

> > ms update interval (register value 0x9), reported as 31 ms through
> > sysfs, while it should preferably lead to a 15.625 ms update interval
> > (register value 0xa), currently reported as 15 ms but ideally reported
> > as 16 ms: this is a 7.375 ms error instead of a 8.250 ms error. You may
> > decide this is unimportant though, I leave it up to you.
> > 
> I figured this is really a corner case (it really only applies to the 23 ms setting),
> and yields less than 1ms error. Everything else I came up with seemed to be too complicated.
> 
> I could change the update_interval calculation to
> 	update_interval = (LM90_MAX_CONVRATE_MS + ((1 << i) >> 1)) >> i;
> 
> That would take care of the 15ms vs. 16ms reporting error, and round 62.5 up to 63.
> Not sure if it is worth it, though. Seems to be a bit complicated.

I see you have found a different solution meanwhile, but for
completeness... The above can be simplified to:

	update_interval = DIV_ROUND_CLOSEST(LM90_MAX_CONVRATE_MS, 1 << i);

It might be slower, but I'm not even sure, and it doesn't actually
matter, as you do it only once.

Also note that there is no point in using ">> 1" instead of "/ 2" and
"<< 1" instead of "* 2", the compiler is smart and will replace
multiplications and divisions by bit-shift each time this is possible. 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
