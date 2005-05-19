From: ebs@ebshome.net (Eugene Surovegin)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH] I2C update for 2.6.9
Message-Id: <20041020052108.GA14871@gate.ebshome.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <10982315061975@kroah.com> <1098231506495@kroah.com>
In-Reply-To: <1098231506495@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com, Nishanth Aravamudan <nacc@us.ibm.com>

On Tue, Oct 19, 2004 at 05:18:26PM -0700, Greg Kroah-Hartman wrote:
> ChangeSet 1.2072, 2004/10/19 15:21:15-07:00, nacc@us.ibm.com
> 
> [PATCH] I2C: replace schedule_timeout() with msleep_interruptible() in i2c-ibm_iic.c
> 
> Use msleep_interruptible() instead of schedule_timeout() to
> guarantee the task delays as expected. Remove the unnecessary
> set_current_state() following the if, as schedule_timeout() [and thus,
> mlseep_interruptible()] is guaranteed to return in TASK_RUNNING.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
> 
> 
>  drivers/i2c/busses/i2c-ibm_iic.c |    4 +---
>  1 files changed, 1 insertion(+), 3 deletions(-)
> 
> 
> diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> --- a/drivers/i2c/busses/i2c-ibm_iic.c	2004-10-19 16:53:58 -07:00
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c	2004-10-19 16:53:58 -07:00
> @@ -416,10 +416,8 @@
>      		init_waitqueue_entry(&wait, current);
>  		
>  		add_wait_queue(&dev->wq, &wait);
> -		set_current_state(TASK_INTERRUPTIBLE);
>  		if (in_8(&iic->sts) & STS_PT)
> -			schedule_timeout(dev->adap.timeout * HZ);
> -		set_current_state(TASK_RUNNING);
> +			msleep_interruptible(dev->adap.timeout * 1000);
>  		remove_wait_queue(&dev->wq, &wait);
>  		
>  		if (unlikely(signal_pending(current))){

It looks like this change added race I tried to avoid here.

This code is modeled after __wait_event_interruptible_timeout, where 
"prepare_to_wait" is done _before_ checking completion status. This 
change breaks this, e.g. if IRQ happens right after we check iic->sts, 
but before calling msleep_interruptible(). In this case we'll sleep 
much more than required (seconds instead of microseconds)

Greg, if my analysis is correct, please rollback this change.

Nishanth, I'd be nice if you CC'ed me with this patch, my e-mail is at 
the top of that source file.

--
Eugene

