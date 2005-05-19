From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH 2.6 sysfs names: fscher: change div to ripple
Message-Id: <hnht61t3a06c4eup6v6o887lh5r1o3rh5t@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
In-Reply-To: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Apr 2005 14:49:47 -0700, Philip Pokorny <ppokorny@penguincomputing.com> wrote:

>So a ripple counter is the equivalent to a fan divisor and therefore I 
>would recommend *not* to apply this patch to rename it.  Keep the 
>original fan_div name.

Jean Delvare tells me the thing is different, my request for a tester 
has gone unanswered thus far, if you have access to one of these chips 
the test is simple: if changing fan_ripple/fan_div doubles or halves 
the fan speed reading, then fan_ripple != fan_div.  That easy!

Until somebody provides the answer to that simple test I am assuming 
fan_ripple != fan_div.

>If fscpos has a fan_ripple accessor, then *it* should be changed to 
>fan_div, not the other way round.

Disagree, if you have access to these chips, please perform the test 
and let me know result, then we can say the datasheet is a poor 
translation.  (pulses <=> ripples struck me as strange translation).


The datasheet _is clear_ on defining ripples as 2, 4 or 8 per fan 
revolution, whereas datasheets for chips with 22.5kHz fan clock 
divided before -> gated counter _always_ spec the fan as two pulses 
per revolution.

Having the same name for a fundamentally different function would 
not be useful.

The current different names for the same function is plainly wrong.

The available evidence to me points to a difference in function, 
requiring a name change.  If you can perform the test confirming 
this issue then we know the correct name to use.

(fanX_pulses_per_rev) --> user-space should have this too, to scale 
fan speed when they have other than two pulses per rev fans.

Thanks,
--Grant.
