From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH 2.6 sysfs names: fscher: change div to ripple
Message-Id: <lkrv61piugcern80m060s8m29jiqloq2b9@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
In-Reply-To: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip,
On Wed, 27 Apr 2005 09:18:09 -0700, Philip Pokorny <ppokorny@penguincomputing.com> wrote:
>
>This ripple counter sounds like the same thing, but working on the fan 
>pulses directly rather than on the 22.5kHz clock.  So the fan tach 
>signal is slower with a higher divisor.

The main difference is that changing ripple will change fan speed 
reading, that aspect is different from other chips, thus the variable 
needs a different name.

The fan speed reading in fscher is defined as 0..255 U/sec.  What is 
a 'U'?   Code comments suggest revs / sec?  

>So the fan_ripple is the *inverse* of the fan_div value, but they have 
>the same net effect, and you can account for the reciprical in the 
>driver.  ie  fan_div = 8/fan_ripple  (if the max "ripple" value is 8)

Yes, you may do that, but without the chip to test I'd rather just 
put fsc* fan_div/fan_ripple into a different common name so user land 
sees it has a different meaning.

Sysfs names project is cleaning up and documenting sysfs naming.

I'm working up to fan speed control :)

Cheers,
--Grant.
