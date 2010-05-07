From: Greg KH <greg@kroah.com>
Date: Fri, 07 May 2010 16:13:14 +0000
Subject: Re: [lm-sensors] [PATCH] Device driver for DA9052 PMIC IC
Message-Id: <20100507161314.GA20909@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3495EC08FA53E94AAA00CC4743D5BA7E010C1E94@pandora.diasemi.com>
In-Reply-To: <3495EC08FA53E94AAA00CC4743D5BA7E010C1E94@pandora.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Dajun Chen <Dajun.Chen@diasemi.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>, sameo@linux.intel.com, lm-sensors@lm-sensors.org, rpurdie@rpsys.net, lrg@slimlogic.co.uk, dmitry.torokhov@gmail.com

On Fri, May 07, 2010 at 12:43:27PM +0100, David Dajun Chen wrote:
> Dear all,
> 
> It is device driver for DA9052 Power Management IC from Dialog Semiconductor.

What are we supposed to do with this?

Please read Documentation/SubmittingPatches for how to submit a patch
(hint, you need to break it up, and provide a "Signed-off-by:" line, and
send it to the correct people and subsystem mailing lists.)

And why did you add a selinux file?  I think something is wrong with how
you generated your patch.

thanks,

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
