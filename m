From: Greg KH <greg@kroah.com>
Date: Fri, 07 May 2010 16:18:58 +0000
Subject: Re: [lm-sensors] [PATCH] Device driver for DA9052 PMIC IC
Message-Id: <20100507161858.GB20909@kroah.com>
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

Oh, also please run your code through the scripts/checkpatch.pl script.
It found:
	total: 4635 errors, 1558 warnings, 24394 lines checked
with this patch.

If you don't want to do the work to fix this up, please let me know and
I'll be glad to move these drivers into the staging tree, where they can
live until stuff like this is cleaned up.

thanks,

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
