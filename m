From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 09 Dec 2009 22:01:32 +0000
Subject: Re: [lm-sensors] ADT7462 Hwmon Driver Bug
Message-Id: <20091209220132.GB10295@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[add lm-sensors to cc]

On Wed, Dec 09, 2009 at 11:55:59AM -0800, Ray Copeland wrote:
> Darrick, we have been happily using your ADT7462 hwmon driver but just
> found a couple of bugs.  I will include the diff's below
> vs. current release and provide a short explanation.  If you would like
> more details, please let me know.

Thanks for the feedback!

> First, the #define ADT7462_VOLT_COUNT is wrong, it should be 13 not 12.

Yep.  Oops.  You can tell that the adt7462 I have doesn't have all 13 voltage
inputs connected. :)

> All the for loops that use this as a limit count are
> of the typical form, "for (n = 0; n < ADT7462_VOLT_COUNT; n++)", so to
> loop through all voltages w/o missing the last one it is 
> necessary for the count to be one greater than it is.  (Specifically,
> you will miss the +1.5V 3GPIO input with count = 12 vs. 13.)
> 
> Secondly, the driver uses the following expression (parentheses added
> for clarity) to test if the +1.5V ICH/3GPIO voltages are
> configured:
> 
> if (((data->pin_cfg[3] >> ADT7462_PIN28_SHIFT) = ADT7462_PIN28_VOLT) &&
> !(data->pin_cfg[0] & ADT7462_VID_INPUT))
> 
> With "#define ADT7462_PIN28_SHIFT 6" this will never equate to "#define
> ADT7462_PIN28_VOLT 5" because that shifts in only the PIN28
> +1.5V ICH value and misses the PIN29 +1.5V 3GPIO value.  It is the
> combination of both these values that equates to 5 if the voltages 
> are configured.  
> 
> Note the logic is essentially correct in that both these voltages must
> be configured together, meaning you can't set one to +1.5V and 
> have the other be something else.  Also, I think the logic just got a
> little confused thinking that pin 28 comes first (bit-position 
> wise) in the pin_cfg[3], but actually the order of bits from ms to ls is
> pin28/29 not pin 29/28.

Aha, you're right, the pin 29/28 bits start at 4, not 6.  Some sort of thinko
on my part, sorry about that.

These two corrections seem generally ok for posting to lm-sensors, though a few
minor issues need to be addressed first:

1. These corrections are best split into two patches, one for the VOLT_COUNT
   increase and a second for the PIN28 -> PIN29 fix, because they address
   different bugs.  The patch pre-amble can be the above justification that you
   wrote.
2. Please add the proper Signed-off-by: declarations to both patches.
3. Remove the comments ending in "DRIVER BUG!!".

Send the updated patch set to lm-sensors and lkml, and I'll test 'em and ack as
necessary to get them upstream.

Thank you for finding and fixing these bugs!

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
