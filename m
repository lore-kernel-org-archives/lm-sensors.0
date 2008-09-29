From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Sep 2008 08:04:20 +0000
Subject: Re: [lm-sensors] [PATCH] i2c: add support for MAX1618 in MAX1619
Message-Id: <20080929100420.6c56631c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080916133542.GA2072@www.tglx.de>
In-Reply-To: <20080916133542.GA2072@www.tglx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 28 Sep 2008 15:42:27 -0700, Andrew Morton wrote:
> > On Sun, 28 Sep 2008 18:02:40 +0200 Jean Delvare <khali@linux-fr.org> wrote:
> > > +static int TEMP_FROM_REG(int val)
> > > +{
> > > +	return ((val & 0x80 ? val-0x100 : val) * 1000);
> > > +}
> > > +
> > > +static int TEMP_TO_REG(int val)
> > > +{
> > > +	return (val < 0 ? val+0x100*1000 : val) / 1000;
> > > +}
> > >  
> > >  /*
> > >   * Functions declaration
> > > _
> > > 
> > >           text    data     bss     dec     hex filename
> > > before:   3927    1148      28    5103    13ef drivers/hwmon/max1619.o
> > > after:    3743    1148      28    4919    1337 drivers/hwmon/max1619.o
> > > 
> > > 
> > > That's a 6% reduction in the number of instructions in the whole driver!
> > > 
> > > Not only that, it generates nicer-to-read code and it fixes the bugs
> > > which will occur if someone calls one of these macros with an
> > > expression which has side-effects.
> > > 
> > > 
> > > Macros suck, suck, suck, suck and the kernel is just littered with the
> > > stupid things in places where they were completely unnecessary.
> > 
> > I totally support this change. We are trying to get rid of these macros
> > in all hwmon drivers but there are still a number drivers that had not
> > been cleaned up. One down, thanks.
> > 
> > I'm taking this patch in my hwmon tree. I've added a proper summary and
> > fixed checkpatch warnings.
> 
> Fair enough, thanks.  However there's no reason now for those functions
> to have upper-case names.  Perhaps you changed that as well.

Correct, done.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
