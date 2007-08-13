From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Aug 2007 12:29:18 +0000
Subject: Re: [lm-sensors]
Message-Id: <20070813142918.788fd597@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

On Mon, 13 Aug 2007 10:39:00 +0200, Christian Hohnstaedt wrote:
> On Sun, Aug 12, 2007 at 01:13:52PM +0200, Jean Delvare wrote:
> > On Tue, 24 Jul 2007 15:43:28 +0200, Christian Hohnstaedt wrote:
> > > Then LM75_TEMP_FROM_REG() should also return a long instead of an int.
> > 
> > This doesn't really matter. A long is needed for LM75_TEMP_TO_REG()
> > because that's what simple_strtol() gives, but in the other direction,
> > we use sprintf, which can handle both an int or a long.
> 
> I will keep the "static inline int LM75_TEMP_FROM_REG(u16 reg)" ,
> because I don't want to change all the sprintf("%d") to sprintf("%ld").

Agreed.

> What about w83627hf.c
> 	return sprintf(buf,"%ld\n", \
> 		(long)LM75_TEMP_FROM_REG(data->reg##_add[nr-2]));
> ?

The cast to long could be removed together with the "l" length modifier
in the format string, independently of the rest of your patch.

> > > Other drivers using LM75_TEMP_TO_REG:
> > > 
> > > driver          temp.type   func
> > > ------------------------------------
> > > asb100.c        long        strtoul
> > > ds1621.c        direct      strtoul
> > > w83627e?hf.c    u32         strtoul
> > > w83781d.c       s32         strtol
> > > 
> > > Looks like there is some kind of general inconsistency :-)
> > 
> > Indeed. Can you please send a patch fixing all the affected drivers?
> 
> I could, but I only can test the LM75 driver.

I can test the ds1621, w83627hf, w83627ehf and w83781d drivers (given
enough time) when you're done.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
