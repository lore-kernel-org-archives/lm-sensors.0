From: n4phth4@yahoo.com (Keith)
Date: Wed, 23 Nov 2005 16:06:07 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051123150536.61652.qmail@web32613.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- Jean Delvare <khali@linux-fr.org> wrote:
> I would start by writing safe values to the limit
> files: 0 to min voltage
> limits, 10000 to max voltage limits (the driver will
> automatically trim
> down to the max possible limit), 100000 to max
> temperature limits,
> etc... The idea is to find out whether the write
> transactions themselves
> are causing problems (unlikely) or if the problem is
> triggered by an
> alarm condition which results from setting some
> limits too tight. If the
> safe writes seem to work OK, try more dangerous ones
> and see when it
> breaks.


Hm it's worth noting now (and I should've put it in
the ticket) that after the first time the system froze
from a ``sensors -s'', I was able to reboot
(subsequent times I was not able to; had to pull the
battery to clear whatever was fouled) and the BIOS log
mentioned something along the lines of the CPU
overheating.  So maybe the limits were set too tight. 
I then set the upper limit (temp1_max) higher but it
made no difference.  However I didn't touch the
"Board" and "Remote" limits...
 

> I seem to understand that "sensors -s" does not
> always hang. 


This is true.  I had it run to completion (got the
bash prompt back) once, and then it hung.


> If you could try an older kernel (for example
> 2.6.13.4) and see if you
> have the problem there too, that would be
> interesting. Just because the
> i2c-i801 driver didn't change doesn't mean that
> nothing in the kernel
> did change. If the monitoring chip is generating
> some hardware interrupt
> on alarm conditions, the i2c-i801 driver may not be
> involved at all.
> 
> Oh, another thing to try I forgot to mention (for
> Keith too) would be to
> run an UP kernel on the same hardware and see if the
> problem disappears.
> It would be nice if we can at least assert that SMP
> is one triggering
> factor.


I'll try both of these over the next few days.

 



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
