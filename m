From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Oct 2012 15:43:40 +0000
Subject: Re: [lm-sensors] [PATCH v2 8/9] hwmon: (it87) Manage device specific features with table
Message-Id: <20121029154340.GB14525@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-9-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-9-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 29, 2012 at 04:30:00PM +0100, Jean Delvare wrote:
> On Mon, 29 Oct 2012 06:53:47 -0700, Guenter Roeck wrote:
> > On Mon, Oct 29, 2012 at 01:39:58PM +0100, Jean Delvare wrote:
> > > On Sun, 28 Oct 2012 11:20:00 -0700, Guenter Roeck wrote:
> > > > diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> > > > index 340c4ea..f3f3e79 100644
> > > > --- a/drivers/hwmon/it87.c
> > > > +++ b/drivers/hwmon/it87.c
> > > > @@ -228,6 +228,59 @@ static const u8 IT87_REG_TEMP_OFFSET[]	= { 0x56, 0x57, 0x59 };
> > > >  #define IT87_REG_AUTO_TEMP(nr, i) (0x60 + (nr) * 8 + (i))
> > > >  #define IT87_REG_AUTO_PWM(nr, i)  (0x65 + (nr) * 8 + (i))
> > > >  
> > > > +struct it87_devices {
> > > > +	const char * const name;
> > > 
> > > What is the second const good for?
> >
> > 	const char (equivalent to char const)	The content is const
> > 	* const					The pointer is const
> 
> I know that. My question was: what is the point of making "name" a
> const pointer here? I don't think it adds any value.
> 
Ok, now I get it. Only reason would be that it makes sure that name is not
overwritten. Granted, that applies to features as well, so, yes, it doesn't make
much sense here. I'll drop it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
