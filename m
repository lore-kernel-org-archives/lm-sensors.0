From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 26 Jul 2007 16:58:18 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically via
Message-Id: <46A8D2AA.6070100@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726010421.GM19586@tree.beaverton.ibm.com>
In-Reply-To: <20070726010421.GM19586@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong wrote:
> On Thu, Jul 26, 2007 at 08:08:09AM -0700, Juerg Haefliger wrote:
>> Hi Darrick,
>>
>> I guess I'm not seeing the big picture :-) The problem you're trying
>> to solve is that the reading of the registers takes a long time and
>> needs to be able to sleep?
> 
> Yes, and also that sleeping in the sysfs read function is not desirable.
> Personally, I was fine with that, but Mr. de Goede was concerned about
> it, so I decided to try to fix it.  I admit, the dual-delayed-workqueue
> method is a bit strange, but it solves the reading problem at a slight
> cost of waking up the CPU even if nobody's watching the sensors.
> 

I just read in another thread, that other hwmon drivers suffer from similar 
problems, so I guess userspace will just have to be able to deal with this, and 
the best fix is not to fix it. Sorry to waist everybody's time on this.

Regards,

Hans


p.s.

You could still try to shave some time off by not reading all the limits etc 
each update.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
