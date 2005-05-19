From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH 2.6 sysfs names: fscher: change div to ripple
Message-Id: <426EB77B.9020509@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
In-Reply-To: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A ripple counter is just a simple way of implementing a pulse frequency 
divider in hardware.

Together with a MUX to select from different bits of the ripple counter, 
it provides low cost divide by 2, 4, 8, etc.

So a ripple counter is the equivalent to a fan divisor and therefore I 
would recommend *not* to apply this patch to rename it.  Keep the 
original fan_div name.

If fscpos has a fan_ripple accessor, then *it* should be changed to 
fan_div, not the other way round.

:v)

Grant Coady wrote:

>Hi all,
>
>The fcsher and fscpos chips have a 'ripple' prescaler of ripples 
>(pulses) per revolution of the fan. 
>
>This small patch changes fscher to match fscpos and is compile tested
>
>  
>

