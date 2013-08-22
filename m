From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 22 Aug 2013 15:28:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (emc6w201): Do not declare enum variable
Message-Id: <20130822152839.GA26534@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375621857-12274-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1375621857-12274-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 22, 2013 at 03:57:33PM +0200, Jean Delvare wrote:
> On Sun,  4 Aug 2013 06:10:57 -0700, Guenter Roeck wrote:
> > Fix the following smatch warning:
> > 
> > emc6w201.c:52:26: warning: symbol 'subfeature' was not declared.
> > Should it be static?
> > 
> > 'enum { } subtype' declares an enum as (global) variable which we don't want.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/emc6w201.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
> > index 936898f..82e661e 100644
> > --- a/drivers/hwmon/emc6w201.c
> > +++ b/drivers/hwmon/emc6w201.c
> > @@ -49,7 +49,7 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
> >  #define EMC6W201_REG_TEMP_HIGH(nr)	(0x57 + (nr) * 2)
> >  #define EMC6W201_REG_FAN_MIN(nr)	(0x62 + (nr) * 2)
> >  
> > -enum { input, min, max } subfeature;
> > +enum subfeature { input, min, max };
> >  
> >  /*
> >   * Per-device data
> 
> Good catch. Applied, thanks.
> 
Ok, I'll drop it from my queue.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
