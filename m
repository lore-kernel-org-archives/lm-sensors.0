From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <20050324225459.64dbfa7c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> I still go for lm85 locking model, perhaps overdone but seems 
> clearly safe.  Certainly easy to point at lm85 as reference 
> model for write locking in the author / porter guide.

Absolutely.

> Then think of reader locking, can drivers simply return 
> -error_update_in_progress_uncertain_data_value_try_again ?

With what benefit, when we can wait a fraction of second and return a
valid value?

> Does sysfs have normal unix filelocking: exclusive write, 
> non-exclusive read?

I am told they are, but...

> Or is that what the driver is enforcing?
> Or is advisory locking too hard to clue-bat end user with?

..filesystem locking is about locking files individually. What we have
here is much more general than that. Concurrent accesses (with at least
one write) to different files may cause a race condition. So the driver
must handle it, exactly like is done in lm85.

> Moving on:
> What I do need is a list of drivers that will be handled by 
> others, then I'll update the 'orphans', as well as continue 
> the DIV_TO_REG removal work in progress.

Consider all the drivers 'orphans' ;) I mean, changes to a driver are
not reserved to its author. The original author will certainly check
your patches, and give some kind of approval, but that's about it.

> Is it time for me to learn the 'ticket' system?

What do you mean?

> Who is documenting this?

You? :)

-- 
Jean Delvare
