From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Dec 2008 20:27:41 +0000
Subject: Re: [lm-sensors] sensord exits on any error
Message-Id: <20081205212741.6cf7ea3a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.0812051215080.9967@andydesk.realbig.com>
In-Reply-To: <alpine.DEB.2.00.0812051215080.9967@andydesk.realbig.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andy,

On Fri, 5 Dec 2008 12:34:47 -0600 (CST), Andy Poling wrote:
> We are using lm-sensors in an embedded system, and have noticed that when
> errors occur, sensord exits.

This is an known issue, tracked as ticket #2330:
http://www.lm-sensors.org/ticket/2330

> We occasionally encounter SMBus collisions which cause transient errors on
> SMBus reads by the sensor chip driver.

Multi-master bus?

> We modified the most recent w83793 driver (which is much improved in dealing
> with SMBus issues) to return cached data for up to 30 seconds in the case of
> SMBus errors, and then to return EAGAIN on the sysfs file read if the SMBus
> errors persist.
> 
> However sensord exits when it gets EAGAIN.  We have patched sensord not to
> exit on errors, but instead to log them and continue.  This seems to us to be
> the robust behavior for an important system monitoring daemon - if the error
> is transient it rides it out, and if it is permanent it complains to get
> attention.  It's about a 2-line change in the main loop of sensord.
> 
> I'd like to push these patches upstream, but wanted to first see if it is
> acceptable to change the behavior of the w83793 driver and sensord in this
> way.

Your changes to the w83793d drivers are IMHO not acceptable. It is up
to user-space to decide what to do when a sensor value can't be read.
Silently caching the values for an arbitrary period of 30 seconds isn't
nice. Returning errors immediately, OTOH would probably be better than
returning 0 as the driver does at the moment. Whether the error value
should be -EAGAIN or -EIO can be discussed. This is however a
non-trivial change due to the 2-second caching strategy that the driver
implements. But you probably already know that if you modified the
driver for your own use already. An easier approach would be to simply
retry on read failures, as I suspect the second read attempt would
almost always succeed.

Your fix to sensord is totally welcome. I could never find the time to
work on ticket #2330, so if you have a working patch I will be very
happy to review and apply it.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
