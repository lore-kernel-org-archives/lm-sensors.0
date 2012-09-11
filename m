From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 19:06:08 +0000
Subject: Re: [lm-sensors] [PATCH] sensors: add humidity data to output of sensors command
Message-Id: <20120911190608.GA15811@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FE063E1.5050301@gmail.com>
In-Reply-To: <4FE063E1.5050301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 11, 2012 at 09:04:00AM +0200, Jean Delvare wrote:
> On Mon, 10 Sep 2012 21:17:27 -0700, Guenter Roeck wrote:
> > Hi Jean,
> > 
> > On Tue, Jun 19, 2012 at 11:34:57AM +0000, Iain Paton wrote:
> > > Testing out a humidity sensor recently and was thinking the driver wasn't working somehow. 
> > > Discovered instead that the driver works fine, but the sensors command was ignoring the 
> > > humidity data.
> > > This adds output of humidity data for sensors that support it.
> > > 
> > > Please consider applying it.
> > > 
> > > Thanks,
> > > Iain 
> > > 
> > mind if I apply this patch to lm-sensors ?
> 
> Please do, I could never find the time to review or test it :(
> 
Cleaned up a bit, tested, and committed.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
