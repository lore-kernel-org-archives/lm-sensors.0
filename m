From: Parag Warudkar <parag.lkml@gmail.com>
Date: Mon, 17 Sep 2012 18:06:05 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Bump max wait and rearrange udelay
Message-Id: <alpine.DEB.2.02.1209171356340.3412@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.02.1209151834120.2271@ubuntu> <20120915225841.GA3816@roeck-us.net> <alpine.DEB.2.02.1209151918210.2271@ubuntu> <alpine.DEB.2.02.1209152323490.2088@ubuntu> <20120916043116.GA4477@roeck-us.net> <20120916093520.GA5623@polaris.bitmath.org>
 <alpine.DEB.2.02.1209161712070.14838@ubuntu> <20120916223003.GA2160@polaris.bitmath.org> <alpine.DEB.2.02.1209161957490.2808@ubuntu> <20120917162705.GA2854@polaris.bitmath.org>
In-Reply-To: <20120917162705.GA2854@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Parag Warudkar <parag.lkml@gmail.com>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org



On Mon, 17 Sep 2012, Henrik Rydberg wrote:

> The current patch does exactly the same sleeps, the only difference is
> that the test is also done before the first sleep. Thus, the increased
> delay, if any, comes from the sleep range.
My understanding is that the original patch resulted in trying a 
max udelay(16). The new one does usleep_range(16, 32). That's a minimum 16 
max 32 - so the fact that it stops read failures means the added delay is 
present and does help.

> 
> 
> The MBP10,1 experiences a lot of write errors with this patch.

Well the send_byte changes are not necessary for fixing my problem - I 
only converted it because of usleep_range() primarily. What happens if you 
drop the send_byte() part of the patch and test with only the wait_read() 
changes? I would be very surprised if that caused write or read failures. 


Parag

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
