From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 26 Aug 2007 18:50:17 +0000
Subject: Re: [lm-sensors] [PATCH] Allow writing of negative trigger
Message-Id: <20070826185017.GD3679@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070816081353.GF10132@tweety>
In-Reply-To: <20070816081353.GF10132@tweety>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Christian:

* Jean Delvare <khali@linux-fr.org> [2007-08-16 11:40:10 +0200]:
> I retested w83627ehf and it's now OK for all temperature channels. I
> also tested adm1021, successfully. I can't test lm77 nor lm93 but the
> code looks right.

There's always i2c-stub, but yeah, it looks OK to me too.

> I had to rediff the adm1021 part due to this patch from Krzysztof Helt
> in Mark's tree:
> http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=commit;ha040d50b43652607ad4677fb4b0ba91ea33be3

I'm surprised that git couldn't merge that automatically (I tried).

BTW I don't mind if I have to do a bit of fixup to get a patch to apply to my
testing branch.  But of course I appreciate it if it's already taken care of -
thanks Jean.

> So here is the updated patch. Mark, please apply.
> 
> From: Christian Hohnstaedt <chohnstaedt@innominate.com>
> Subject: hwmon: Allow writing of negative trigger temperatures
> 
> - replace differing temperature variable types by long
> - use strtol() instead of strtoul() for conversion
> 
> Signed-off-by: Christian Hohnstaedt <chohnstaedt@innominate.com>
> Acked-by: Jean Delvare <khali@linux-fr.org>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
