From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 31 Jul 2008 10:33:00 +0000
Subject: Re: [lm-sensors] [RESEND x9+ patch 2.6.26-git 1/2] lm75: cleanup
Message-Id: <489194DC.4020000@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200807251523.28242.david-b@pacbell.net>	<20080729233231.0ced6d9b.akpm@linux-foundation.org>	<48901BF7.9050601@hhs.nl> <20080730004615.f0686916.akpm@linux-foundation.org>
In-Reply-To: <20080730004615.f0686916.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Andrew Morton wrote:
> 
> OK.  Can you please email me any patches which you think should be in
> 2.6.27 in the usual manner, with the appropriate mailing list cc's?  Add
> your own signed-off-by: if needed.  I'll get it all lined up.
> 

Done for the abituguru3 patch, as for Jean's new style driver conversion 
patches I think thats best done by Jean himself.

I also have a patch adding pwm control support to the fintek f71882fg on my to 
review list (I'm the maintainer of the f71882fg driver) I've already tested it 
and I'll try to get that reviewed the next couple a days and then send it to 
you for 2.6.27 inclusion.

Then there also are 2 new hwmon drivers which really have been waiting to long 
to get into the kernel too. I'll try to review those too, but I can test only 
one of them. Let me know if not being able to test the other is a problem for 
upstream inclusion.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
