From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 26 Jul 2007 07:49:26 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically via
Message-Id: <46A85206.7010402@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726010421.GM19586@tree.beaverton.ibm.com>
In-Reply-To: <20070726010421.GM19586@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong wrote:
> On Wed, Jul 25, 2007 at 06:19:22PM -0700, Juerg Haefliger wrote:
>> Hi Darrick,
>>
>> Why using a workqueue at all? Can't you just run a timer and do the
>> update when it expires and restart the timer?
> 
> Currently, I use mutexes (and msleep) which require the ability to
> sleep.  Timers can't sleep because they are implemented as a softirq.
> That said, I think the solution is to have two workqueue items--one to
> start the read and another to run after the temperature sensors have
> been read.  The delays for both can be handled via schedule_delayed_work().
> It could be done with two timers and spinlocks, but ... yuck.
>

Or we could decide that we can live with the current 1 second + blocking of 
userspace apps, that is an option we should seriously consider too if this 
becomes ugly.

Regards,

hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
