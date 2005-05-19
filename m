From: jonsmirl@yahoo.com (Jon Smirl)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: I2C on 2.6
Message-Id: <20040212032124.80345.qmail@web14918.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
In-Reply-To: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- Greg KH <greg@kroah.com> wrote:
> > /sys/class is starting to feel a little confusing to me. And there are a lot
> > more devices that don't have sysfs enabled yet that are going to end up in
> > /sys/class too.  Currently /sys/classs holds two classes of entries: hosts
> and
> > devs. Are you sure you don't want to get the hosts out of there before
> software
> > get written using them and it's too late to move them?
> 
> And how do you propose doing this?  It will take some driver core
> mangling to do this.
> 
> And what's really wrong with it?
> 
> > Is anything already using /class/sys/'host' entries? Or is the driver work
> just
> > what is needed to move the location of the directory?
> 
> Driver core work and driver bus work would be needed.
> 
> It's much simpler the way things currently are.  Leave this as a 2.7
> thing to do if you really don't like it :)

This just feels to me like one of those things we're going regret not doing
before a bunch of code gets built on top of it and it becomes impossible to
change.

Does changing this involve anything except the syfs specific code in the drivers
that creates the entries? In other words is there non-sysfs code that relies on
where these directories are located? Right now there are only four buses that I
know of that need to be moved.

This problem isn't too bad on a desktop, but what about a mainframe that might
have a hundred different buses?

> 
> thanks,
> 
> greg k-h

==Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
