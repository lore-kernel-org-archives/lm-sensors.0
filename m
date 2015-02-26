From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Feb 2015 17:32:06 +0000
Subject: Re: [lm-sensors] [PATCH] Add Nuvoton NCT7904 hwmon driver
Message-Id: <20150226173206.GA10560@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424794188.8163.13.camel@vvlasov.dev.rtsoft.ru>
In-Reply-To: <1424794188.8163.13.camel@vvlasov.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 26, 2015 at 08:16:10PM +0300, Vadim V. Vlasov wrote:
> On Thu, 2015-02-26 at 08:16 -0800, Guenter Roeck wrote:
> > On Thu, Feb 26, 2015 at 06:55:18PM +0300, Vadim V. Vlasov wrote:
> 
> > 
> > > > > +static ssize_t
> > > > > +store_mode(struct device *dev,
> > > > > +	  struct device_attribute *devattr, const char *buf, size_t count)
> > > > > +{
> > > >>[...]
> > > > > +	ret = nct7904_write_reg(data, BANK_3, FANCTL1_FMR_REG + index, val);
> > > > > +
> > > > This is really combining two configurations into one, the fan control mode
> > > > (manual or automatic), and its association with a temperature source
> > > > as selected in bank 3 registers 0x09..0x0c. If you want to be able
> > > > to configure that, it will need to be two separate attributes, one for the
> > > > mode and one for the temperature source.
> > > > 
> > > > Configuring automatic mode without also providing the means to configure
> > > > registers 0x09..0x0c doesn't really make much sense.
> > > 
> > > No, I don't want to be able to configure automatic mode. I presume that
> > > BIOS would do that better. The only thing I want to provide is
> > > the ability to turn a fan into manual mode, play with RPM and return
> > > it back to whatever automatic settings were provided by BIOS.
> > > 
> > I seem to be missing something. The mode attribute as you wrote it does
> > configure manual vs.  automatic mode, and in your code you also associate
> > the automatic mode with a temperature source. Sorry, I don't see how it
> > would make sense to let the user configure which temperature source
> > to use without making sure that this temperature source points to
> > something useful.
> 
> I see the following use scenario:
> - the user reads fanX_mode which specifies temperature source for
> automatic mode, and remembers it;
> - the user writes 0 into the mode to set manual control;
> - manually increases the fan speed (or decreases it to make the fan
> silent);
> - after some time he restores automatic mode to what he has remembered.
> 
> Tweaking the values in smartfan configuration is not supposed and is
> not supported, yet.
> 
> Do you think that saving initial mode values and allowing only to set
> either 0 or the saved value is a better solution?
> 
Yes; you can not make assumptions like that. Since you don't let the user
configure the temperature source itself, you should also reject setting
automatic mode if it was not originally enabled.

> > I don't see what you changed in the patch that follows. Please provide a change
> > log.
> 
> 1. hwmon_dev removed from nct7904_data
> 2. 4 groups of sensors are registered instead of just one,
>   is_visible() with appropriate masks is used for configuring 3 
>   of the groups
> 3. bank_lock/release() are separate functions
> 4. redundant checks of bank number removed
> 5. nct7904_read_reg16() returns two registers in big-endian format
> 6. sensor attributes are initialized using common macros
>   (SENSOR_DEVICE_ATTR())
> 7. local temperature reading is a separate function rather than
>   a special case in voltage reading
> 8. fixed multi-line function declaration style
> 9. other minor changes that you suggested.
> 

Thanks a lot for the information. Please add to changelog for the next
version of the patch (after the '---' line).

> >  I still see
> > 
> > total: 0 errors, 1 warnings, 27 checks, 630 lines checked
> 
> OK. The warning is:
>    WARNING: added, moved or deleted file(s), does MAINTAINERS need
> updating?
> I'm not sure what to do about it.
> 
Your call. Ignore it, or if you want to spend the time add yourself as
maintainer for this driver.

> The checks:
> 
>    CHECK: Please don't use multiple blank lines (7 instances)
> Two blank lines separate 'logical sections' of the code. I can fix it
> if this is considered undesirable.
> 
Yes, it is considered undesirable.

>    CHECK: Alignment should match open parenthesis (19 instances)
> The 'CodingStyle' does not require such alignment.
> You suggested to make multi-line declarations just consistent and
> I did so.
> 
Not in the patch that was attached; that is where majority of the messages
comes from.

>    CHECK: struct mutex definition without comment
> No idea about this one.
> 
Ignore it; I consider this one to be noise.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
