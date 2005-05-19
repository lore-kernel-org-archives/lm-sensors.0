From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [RFC] Dynamic fan clock divider changes (long)
Message-Id: <20040531112719.10b7d64c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516222809.2c3d1ea2.khali@linux-fr.org>
In-Reply-To: <20040516222809.2c3d1ea2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I like the idea of dynamic divisor changes (I'll call it auto fan
> divisors or A.F.D.). Whether it belongs in the driver or in userspace
> is a tougher call. There may be more information available to a driver
> on clock rate and possible divisors, but it would be more work to
> propagate the code to all the drivers rather than do it once in
> 'sensors'.
> 
> I'm all for AFD in pc87360 as a demonstration / proof of concept.
> However let's think about what it would take to do the same thing in
> 'sensors' and whether that offers some advantages.

We discussed this a bit with MMH already, and as you pointed out, the
problem is that the userspace would then need to know the possible
dividers and clock frequency. This is likely to represent more code than
the AFD algorithm itself, which is why I'm not it favor of this.

One thing MMH and I are in favor of (if we agree that it's more simple
to put that stuff in the drivers) would be to have a generic function in
i2c-sensor instead of one in all chip drivers. Almost all chips work on
the same model, the function would have to know the possible dividers
and that's about all. Most chips accept a divider "range", typically
from 1 to 8 or 1 to 128. Only the IT87 fan 3 is different AFAIK (only
accept 2 and 8) so this one would probably have its own function.

I will try to improve the pc87360 implementation so that everything is
centralized in a single function. Then, if no problems are reported with
this implementation, we'll modify the prototype so that the funtion has
enough parameters to be chip-independant, and move it to i2c-sensor. All
this won't happen before I (or anyone else) have ported the pc87360
driver to Linux 2.6, so this leaves enough time for testing and feedback
if any problem arises.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
