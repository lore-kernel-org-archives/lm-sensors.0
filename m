From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: LM Sensors and Kernel 2.5 (Nvidia Nforce2)
Message-Id: <20030711233150.GM23240@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307110439.33500.patrick@dreker.de>
In-Reply-To: <200307110439.33500.patrick@dreker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 11, 2003 at 04:39:30AM +0200, Patrick Dreker wrote:
> Hello...
> 
> After a lot of trying and reading I have realised that lm-sensors and Kernel 
> 2.5 are not yet usable with the Nvidia Nforce2 Chipset because of a missing 
> module and because libsensors is not ready for sysfs yet. (Using Asus 
> A7V8X-Deluxe Motherboard, so the sensor chip itself (w83781d) is supported 
> and works under 2.4)
> 
> As far as I could understand from the website the following things would have 
> to happen to make the above system work:
> 1) port or integrate i2c-nforce2 from LM-Sensors CVS into kernel 2.5
> 2) adapt libsensors to use sysfs
> (correct me if I am wrong...)

Yup, that sounds about right.

> Question: Is anybody already doing one or both of the above?

Nope, not that I know of.

> If not: How can I help? If yes: are there patches to try out, or
> something else to help with?

Can you port the i2c-nforce2 driver to the 2.5 kernel?  I outlined the
steps necessary to do this in an older email (it's in the archives
somewhere, if you can't find it I can dig it up.)

Or if you want to start working on the sysfs version of libsensors, that
would be great too.

thanks,

greg k-h
