From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH 2.6 sysfs names: fscher: change div to ripple
Message-Id: <426FBB41.8090905@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
In-Reply-To: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Grant Coady wrote:

>On Tue, 26 Apr 2005 14:49:47 -0700, Philip Pokorny <ppokorny@penguincomputing.com> wrote:
>
>  
>
>>So a ripple counter is the equivalent to a fan divisor and therefore I 
>>would recommend *not* to apply this patch to rename it.  Keep the 
>>original fan_div name.
>>    
>>
>
>Jean Delvare tells me the thing is different, my request for a tester 
>has gone unanswered thus far, if you have access to one of these chips 
>the test is simple: if changing fan_ripple/fan_div doubles or halves 
>the fan speed reading, then fan_ripple != fan_div.  That easy!
>
>Until somebody provides the answer to that simple test I am assuming 
>fan_ripple != fan_div.
>  
>
Unfortunately, I don't have the hardware either.

But whether it's the same hardware implementation or not, if it has the 
same effect, then it's the same feature (quack's like a duck => it's a 
duck).

The fan dividors we're used to seeing are ripple counters on the 22.5kHz 
clock that divide it down to reduce the clock pulses counted by the 
gating fan pulses.

This ripple counter sounds like the same thing, but working on the fan 
pulses directly rather than on the 22.5kHz clock.  So the fan tach 
signal is slower with a higher divisor.

So the fan_ripple is the *inverse* of the fan_div value, but they have 
the same net effect, and you can account for the reciprical in the 
driver.  ie  fan_div = 8/fan_ripple  (if the max "ripple" value is 8)


>>If fscpos has a fan_ripple accessor, then *it* should be changed to 
>>fan_div, not the other way round.
>>    
>>
>
>Disagree, if you have access to these chips, please perform the test 
>and let me know result, then we can say the datasheet is a poor 
>translation.  (pulses <=> ripples struck me as strange translation).
>  
>
Well, as I said above, the difference could be that one operates on the 
fan pulses and the other operates on the measuring clock signal.

>The datasheet _is clear_ on defining ripples as 2, 4 or 8 per fan 
>revolution, whereas datasheets for chips with 22.5kHz fan clock 
>divided before -> gated counter _always_ spec the fan as two pulses 
>per revolution.
>
>Having the same name for a fundamentally different function would 
>not be useful.
>  
>
Ahh, but lm_sensors has two goals.  One is to make available all the 
chip functions.  The other, is to provide a *consistent abstraction* to 
user space for those features.

For example, there are several different types of fan speed control 
algorithms out there.  But lm_sensors attempts to fold them all into a 
common reference model so that user-space tools have to deal with only 
one model for fan speed control.

>The current different names for the same function is plainly wrong.
>  
>
Agreed

>(fanX_pulses_per_rev) --> user-space should have this too, to scale 
>fan speed when they have other than two pulses per rev fans.
>  
>
I've had to deal with 4-pulse per rev fans before and I've done it with 
'compute' commands in sensors.conf.  It does not need to be in the driver.

