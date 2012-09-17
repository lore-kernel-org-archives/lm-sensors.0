From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Mon, 17 Sep 2012 19:46:22 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Bump max wait and rearrange udelay
Message-Id: <20120917194622.GA308@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120916043116.GA4477@roeck-us.net>
 <20120916093520.GA5623@polaris.bitmath.org>
 <alpine.DEB.2.02.1209161712070.14838@ubuntu>
 <20120916223003.GA2160@polaris.bitmath.org>
 <alpine.DEB.2.02.1209161957490.2808@ubuntu>
 <20120917162705.GA2854@polaris.bitmath.org>
 <alpine.DEB.2.02.1209171356340.3412@ubuntu>
 <20120917184954.GA349@polaris.bitmath.org>
 <alpine.DEB.2.02.1209171446390.1963@ubuntu>
 <20120917191416.GA598@polaris.bitmath.org>
In-Reply-To: <20120917191416.GA598@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org

> > So bottomline, I suspect we will need to bump to 0x20000 if you want to 
> > keep the current loop termination and udelay().
> 
> That is just crazy, since your code works with a 32ms maximum.

I am sorry, I misread the number of zeroes here. If you are saying
that fours times the current number is enough for the error rate to
drop off on your machine, then I think we should just do that. It is
the only change I can think of that is safe enough at this stage.

Given that the irqsoff latency on a normal machine can be as high as
200 ms or so, it does not seem all that strange.

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
