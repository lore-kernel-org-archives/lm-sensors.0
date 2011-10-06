From: Greg KH <greg@kroah.com>
Date: Thu, 06 Oct 2011 18:25:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon class driver registration with a
Message-Id: <20111006182500.GA18607@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317834791-2803-1-git-send-email-hschauhan@nulltrace.org>
 <20111005193359.GB26664@kroah.com>
 <20111006041011.GB2125@ubuntu.ubuntu-domain>
In-Reply-To: <20111006041011.GB2125@ubuntu.ubuntu-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Himanshu Chauhan <hschauhan@nulltrace.org>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org, lm-sensors@lm-sensors.org

On Thu, Oct 06, 2011 at 09:40:11AM +0530, Himanshu Chauhan wrote:
> Hi Greg,
> 
> > 
> > How do you later remove a device created with this new interface?  As it
> > is, I think the existing calls will fail, right?
> > 
> If I have not missed out anything from hwmon_device_unregister(), it shouldn't
> fail. Why did you point that out?

If you create a device with a call to device_create() with a dev_t set,
it is usually cleaned up with a call to device_destroy(), but you are
right, a simple call to device_unregister() will still work properly.

So nevermind, sorry for the noise.

What you do need to determine is if this is a device node you really
want to be creating in this manner, as it is a new user/kernel API,
right?

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
