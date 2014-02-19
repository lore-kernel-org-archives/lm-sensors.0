From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Feb 2014 17:38:57 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/4] hwmon: (lm90) Convert to use hwmon_device_register_with_groups
Message-Id: <20140219173857.GB30967@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392771679-14666-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392771679-14666-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 19, 2014 at 11:56:07AM +0100, Jean Delvare wrote:
> On Wed, 19 Feb 2014 11:18:50 +0100, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Tue, 18 Feb 2014 17:01:19 -0800, Guenter Roeck wrote:
> > > I tested this with MAX6695. Given that the pec attribute is now handled
> > > differently, it might make sense to test this chip explicitly.
> > > Jean, do you have one available, at least in simulation ?
> > 
> > Unfortunately simulation is done using i2c-stub which lacks support for
> > PEC, so it doesn't help.
> > 
> > I do have a physical ADM1032 chip, however it is on a parallel-port
> > evaluation board, and my workstation lacks such a port. I have one on
> > another machine in my office, but it's running kernel 3.11 and the
> > converted driver doesn't built there. So I'll have to build a new
> > kernel on that old machine first.
> 
> ... or install the latest stable kernel which is already packaged, and
> build the updated driver on top of it. I'm done with testing, and
> everything is OK.
> 
Excellent. Thanks a lot!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
