From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <20040716171702.GA10598@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10898500322333@kroah.com> <10898500321009@kroah.com> <20040716170716.GD8264@openzaurus.ucw.cz>
In-Reply-To: <20040716170716.GD8264@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Fri, Jul 16, 2004 at 07:07:16PM +0200, Pavel Machek wrote:
> Hi!
> 
> > +menu "Dallas's 1-wire bus"
> > +
> > +config W1
> > +	tristate "Dallas's 1-wire support"
> > +	---help---
> > +	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices 
> > +	  such as iButtons and thermal sensors.
> 
> Just out of curiosity... are such devices really connected using one wire only,
> or is it GND+5V+one data wire, or GND+power&data wire?

I'm pretty sure it's just 1 wire, at least for the devices I've seen.

thanks,

greg k-h
