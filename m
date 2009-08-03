From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 Aug 2009 12:21:38 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Create a DIV_ROUND_CLOSEST macro to do
Message-Id: <20090803142138.51738a18@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081111010132.1730.76566.stgit@elm3a70.beaverton.ibm.com>
	<1249300672.7924.53.camel@twins>
In-Reply-To: <1249300672.7924.53.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Julia Lawall <julia@diku.dk>

Hi Peter,

On Mon, 03 Aug 2009 13:57:52 +0200, Peter Zijlstra wrote:
> On Mon, 2008-11-10 at 17:01 -0800, Darrick J. Wong wrote:
> > Create a helper macro to divide two numbers and round the result to the
> > nearest whole number.  This is a helper macro for hwmon drivers that
> > want to convert incoming sysfs values per standard hwmon practice, though
> > the macro itself can be used by anyone.
> 
> Its too late to rename this now isn't it :-/

We can always rename things, but it is costly, so we only do that if we
have a good reason (e.g. the original name caused confusion.)

> 
> DIV_ROUND_{UP,CEIL}
> DIV_ROUND_{DOWN,FLOOR}

The latter is the simple integer division, so there is no point in
defining a macro for it. The former we already have.

> 
> I get.
> 
> The proposed thing is simply DIV_ROUND, but this DIV_ROUND_CLOSEST name
> is just wonky.

I can't disagree. I even think I argued about it back then, but then
finally gave up. You should have participated in the debate when it was
hot rather than 8 months later :(

> 
> Also, shouldn't it be something like ?
> 
>   DIV_ROUND(x, y) (((x) + (((y)+1)/2)) / (y))

No, that wouldn't work. Simple example, 10/3 is 3.33. (10+3/2)/3 is 3
which is the correct rounded value. (10+(3+1)/2)/3 is 4 which is not
the correct rounded value.

> Also, do we want the default rounding to be symmetric or asymmetric?

I don't think we care at all. This macro will rarely be called on
negative numbers, and even then...

> 
> I think round to half even or something would be nice, but would add an
> extra conditional, not sure its worth it (round away from zero only
> works for signed numbers and it would also cost one conditional).

Definitely not worth the extra cost. We do the rounding because it is
not too expensive and adds value. Fine-tuning it will cost more than is
worth, plus would lead to endless debates about what is the best
rounding strategy.

If anyone really needs additional control on rounding, they better do
not rely on a general helper, but instead implement their own rounding
function.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
