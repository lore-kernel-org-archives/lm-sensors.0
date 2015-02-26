From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Feb 2015 16:16:34 +0000
Subject: Re: [lm-sensors] [PATCH] Add Nuvoton NCT7904 hwmon driver
Message-Id: <20150226161634.GA10257@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424794188.8163.13.camel@vvlasov.dev.rtsoft.ru>
In-Reply-To: <1424794188.8163.13.camel@vvlasov.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 26, 2015 at 06:55:18PM +0300, Vadim V. Vlasov wrote:
> Hi Guenter,
> Thank you for the comments.
> 
> Please find the new version of the patch and my comments below.
> 
> Thanks.
> Vadim.
> 
> On Tue, 2015-02-24 at 09:56 -0800, Guenter Roeck wrote:
> > On Tue, Feb 24, 2015 at 07:09:48PM +0300, Vadim V. Vlasov wrote:
> >...
> > > +/* Access functions */
> > > +/* Read 1-byte register. Returns unsigned reg or -ERRNO on error. */
> > > +static int nct7904_read_reg(struct nct7904_data *data,
> > > +	unsigned bank, unsigned reg)
> > 
> > In practice you never access a register without its page.
> > Consider merging <bank, register> into a 16-bit value
> > and decode it here.
> 
> I don't think it is a good idea.

Your call.

> > 
> > This way a register define would automatically include the page,
> > which in turn would reduce the risk of accicdentially accessing
> > a register from the wrong page.
> 
> You wrote that I'm supposed to trust my code :)
> 
Different scope. Besides, the above isn't caught by your checks.
Separating page from register makes the checks even less useful.

> > > +static ssize_t
> > > +store_mode(struct device *dev,
> > > +	  struct device_attribute *devattr, const char *buf, size_t count)
> > > +{
> >>[...]
> > > +	ret = nct7904_write_reg(data, BANK_3, FANCTL1_FMR_REG + index, val);
> > > +
> > This is really combining two configurations into one, the fan control mode
> > (manual or automatic), and its association with a temperature source
> > as selected in bank 3 registers 0x09..0x0c. If you want to be able
> > to configure that, it will need to be two separate attributes, one for the
> > mode and one for the temperature source.
> > 
> > Configuring automatic mode without also providing the means to configure
> > registers 0x09..0x0c doesn't really make much sense.
> 
> No, I don't want to be able to configure automatic mode. I presume that
> BIOS would do that better. The only thing I want to provide is
> the ability to turn a fan into manual mode, play with RPM and return
> it back to whatever automatic settings were provided by BIOS.
> 
I seem to be missing something. The mode attribute as you wrote it does
configure manual vs.  automatic mode, and in your code you also associate
the automatic mode with a temperature source. Sorry, I don't see how it
would make sense to let the user configure which temperature source
to use without making sure that this temperature source points to
something useful.

I don't see what you changed in the patch that follows. Please provide a change
log. I still see

total: 0 errors, 1 warnings, 27 checks, 630 lines checked

when running the patch through checkpatch, so for sure you did not fix those.
Please follow coding style guidelines in respect to continuation lines,
and please don't use more than one empty line.

Please do not send new patch revisions as response to a previous patch revision.
That just makes it difficult to track.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
