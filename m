From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Feb 2014 17:52:42 +0000
Subject: Re: [lm-sensors] sensors.conf for Gigabyte B75-D3V
Message-Id: <20140227175242.GA18919@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <005901cf33ae$ccc48130$664d8390$@gmx.de>
In-Reply-To: <005901cf33ae$ccc48130$664d8390$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 27, 2014 at 06:20:54PM +0100, Jean Delvare wrote:
> Hello Dominik,
> 
> On Thu, 27 Feb 2014 12:26:46 +0100, Dominik Egert wrote:
> > after playing around for a day or so, i've come up with a new config file
> > for the Gigabyte B75-D3V Mainboard.
> > 
> > The chip in use is the it8728, and sensor input is differently wired to
> > other Gigabyte mainboards. 
> > 
> >  
> > 
> > I wasn't able to ignore the sensors from pkg-*
> 
> First time I see this. I don't know which driver does this but this
> looks pretty wrong, "pkg" is way too generic as a device name. This
> should be fixed quickly.
> 
Not sure, but it might come in through drivers/thermal/x86_pkg_temp_thermal.c.
It registers thermal zones named pkg-temp-<processor id>.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
