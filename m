From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 06 Oct 2011 19:07:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon class driver registration with a
Message-Id: <20111006190752.GA28455@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317834791-2803-1-git-send-email-hschauhan@nulltrace.org>
 <20111005193359.GB26664@kroah.com>
 <20111006041011.GB2125@ubuntu.ubuntu-domain>
 <20111006182500.GA18607@kroah.com>
In-Reply-To: <20111006182500.GA18607@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Himanshu Chauhan <hschauhan@nulltrace.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>

On Thu, Oct 06, 2011 at 02:25:00PM -0400, Greg KH wrote:
> On Thu, Oct 06, 2011 at 09:40:11AM +0530, Himanshu Chauhan wrote:
> > Hi Greg,
> > 
> > > 
> > > How do you later remove a device created with this new interface?  As it
> > > is, I think the existing calls will fail, right?
> > > 
> > If I have not missed out anything from hwmon_device_unregister(), it shouldn't
> > fail. Why did you point that out?
> 
> If you create a device with a call to device_create() with a dev_t set,
> it is usually cleaned up with a call to device_destroy(), but you are
> right, a simple call to device_unregister() will still work properly.
> 
> So nevermind, sorry for the noise.
> 
Not entirely noise. Since the new registration call is not exported in the patch,
any code using it won't be compilable as module, which in turn means
that hwmon_device_unregister() was never called.
So while we know that it _should_ work, we also know that it was not tested.

> What you do need to determine is if this is a device node you really
> want to be creating in this manner, as it is a new user/kernel API,
> right?
> 
And why, and what for.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
