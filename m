From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Jun 2013 17:35:20 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 v2] hwmon (ds1621): Add DS1731 chip support to ds1621 driver
Message-Id: <20130627173520.GA11118@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370915163-30293-2-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1370915163-30293-2-git-send-email-rob.coulson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 27, 2013 at 10:29:24AM +0200, Jean Delvare wrote:
> Sorry for joining late in the game again...
> 
> On Mon, 10 Jun 2013 18:46:02 -0700, Robert Coulson wrote:
> > These changes add DS1731 chip support to the ds1621 driver,
> > Kconfig, and documentation.
> 
> Just two minor things I noticed while testing the ds1621 patches:
> 
> > --- a/Documentation/hwmon/ds1621
> > +++ b/Documentation/hwmon/ds1621
> > (...)
> > @@ -72,7 +77,7 @@ Temperature conversion of the DS1621 takes up to 1000ms; internal access to
> >  non-volatile registers may last for 10ms or below.
> >  
> >  The DS1625 is pin compatible and functionally equivalent with the DS1621,
> > -but the DS1621 is meant to replace it. The DS1631 and DS1721 are also
> > +but the DS1621 is meant to replace it. The DS1631, DS1721, & DS1731 are also
> 
> Please don't use "&" for "and" in plain English sentences, it hurts readability.
> 
> > @@ -84,26 +89,27 @@ explicitly instantiated, one device per address, in this address
> >  range: 0x48..0x4f.
> >  
> >  The DS1721 is pin compatible with the DS1621, has an accuracy of +/- 1.0
> > -degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
> > -default setting of 75 and 80 degrees respectifully, and a maximum conversion
> > -time of 750ms.
> > +degree Celius (from -10 to +85 degrees), a minimum/maximum alarm default
> 
> Typo: Celsius. The typo was already present before, it's not added by
> this patch, but you have the opportunity to fix it.
> 
I must be blind to have overlooked this one ;)

I patched both up in my tree, no need to re-send (the Celius error was
introduced with an earlier patch submitted by Rob, and it was spreading
through later patches as well; I fixed all those as well).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
