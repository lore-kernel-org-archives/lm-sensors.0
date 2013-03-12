From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Mar 2013 17:19:53 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] Add support for the Dallas/Maxim DS1705
Message-Id: <20130312171953.GF30269@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130312155250.611baf07@endymion.delvare>
In-Reply-To: <20130312155250.611baf07@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 12, 2013 at 05:05:59PM +0100, Jean Delvare wrote:
> On Tue, 12 Mar 2013 08:49:30 -0700, Guenter Roeck wrote:
> > On Tue, Mar 12, 2013 at 03:52:50PM +0100, Jean Delvare wrote:
> > > Basically it's the same as the original DS17 but much faster.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > ---
> > >  Documentation/hwmon/lm75 |    8 ++++----
> > >  drivers/hwmon/Kconfig    |    2 +-
> > >  drivers/hwmon/lm75.c     |    7 +++++++
> > >  3 files changed, 12 insertions(+), 5 deletions(-)
> > > 
> > > --- linux-3.9-rc2.orig/Documentation/hwmon/lm75	2013-03-12 15:49:08.893730398 +0100
> > > +++ linux-3.9-rc2/Documentation/hwmon/lm75	2013-03-12 15:51:32.842053514 +0100
> > > @@ -12,11 +12,11 @@ Supported chips:
> > >      Addresses scanned: I2C 0x48 - 0x4f
> > >      Datasheet: Publicly available at the National Semiconductor website
> > >                 http://www.national.com/
> > > -  * Dallas Semiconductor DS75, DS1775
> > > -    Prefixes: 'ds75', 'ds1775'
> > > +  * Dallas Semiconductor (now Maxim) DS75, DS1775, DS7505
> > 
> > Hi Jean,
> > 
> > Headline says DS1705. Looking into the datasheets, I guess the headline
> > is wrong, or I am missing something.
> 
> Doh, yes, typo in the headline _and_ the header comment (DS75 not
> DS17.) Not sure how I managed to miss both. Thanks for spotting, will
> resend.
> 
> > Otherwise Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> BTW I'll take all these patches in my own tree if this is OK with you.
> Not sure why you took my previous lm75 patch (Update header inclusion)
> in yours.
> 
Mostly because you had asked me to handle 3.8. Maybe that was a
misunderstanding. Sorry if I stepped on your feet ... want me to drop it ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
