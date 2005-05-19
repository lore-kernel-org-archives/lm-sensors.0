From: ben@fluff.org.uk (Ben Dooks)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: lm75 with tmp101
Message-Id: <20050221164400.GI28744@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050221154410.GA14014@home.fluff.org>
In-Reply-To: <20050221154410.GA14014@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 21, 2005 at 05:27:37PM +0100, Jean Delvare wrote:
> 
> Hi Ben,
> 
> > I've done some quick tests, and the tmp101 seems to be
> > fine with the lm75 driver, using the following cmdline:
> >
> > "lm75.force_lm75=-1,0x48"
> 
> I didn't know that syntax, I guess this comes from the "new"
> module_param stuff? Good thing to know, thanks for pointing out.
> 
> Anyway, this at least proves that the TMP101 is LM75-compatible as Mark
> and I thought.
> 
> > Is there any way to pass the `kind` parameter of the
> > probe call via this method?
> 
> This is exactly what you did. The force_lm75 parameter sets the "kind"
> to lm75. force (without _lm75) would set the "kind" to 0 insead -
> which currently makes no difference for the lm75 driver.

thanks, it isn't entirely obvious what is going on.
 
> > Attached is a patch to add resolution to the sysfs, which
> > read-only if we detect an lm75, and r/w if it is forced.
> 
> I doubt it really does that. Quoting your code:
> 
> > +static DEVICE_ATTR(resolution, S_IWUSR | S_IRUGO,
> > +		   lm75_show_resolution, lm75_set_resolution);
> > (...)
> >  	if (kind <= 0)
> >  		kind = lm75;
> > +	else if (kind != lm75)
> > +		dev_attr_resolution.attr.mode |= S_IWUSR;
> 
> So in the first place the file is r/w, then you conditionally add the
> write permission - without any effect, needless to say.

It _should_ have been read-only by default
 
> Also note that this last line is actually never run - the first test
> copes with kind = -1 and kind = 0, and the only case left (kind =
> lm75) is explicitely excluded by the second test.
> 
> In short, that part of your patch is severly broken ;)
> 
> > I could add a small bit of code to probe the presence of
> > the resolution bits if the probe is forced.
> 
> I don't get what you mean here, but since your patch didn't seem to
> really reflect what you had in mind, it's not all that surprising.
> 
> Your patch is broken in several other respects, namely:
> 1* It creates the resolution file for any LM75-compatible chip, while
> most don't support resolution change. It will be fine (providing the
> file is read-only) for the LM75 itself because theses configuration bits
> are 0, so the resolution will properly be displayed as 9. However, I
> think that some compatible chips - there is a long list - may use these
> bits for something different. Did you check?
> 2* You do not make any use of the additional resolution bits. The current
> lm75 code will strip them. So what's the point?
> 
> I do not think that the benefit of the additional resolution is worth the
> effort. The TMP101 part is given with a 2 degrees accuracy, so a
> resolution of 0.5 degree seems to be just fine. I doubt we really need
> anything more precise than that in computer equipement. (When we have
> additional resolution at no cost, I'm all for it, but in this special
> case the cost exists and seems a bit high to me.)

Ok, will ignore this for the moment.
 
> What might be more useful to work on would be a TMP101 detection
> algorithm so that the chip is properly detected without the need of a
> force parameter. I can help you achieve that if you provide the output
> of i2cdump (in word mode) for your chip. The command would be "i2cdump
> <n> 0x48 w" where <n> is the number of the i2c bus the chip sits on.
> i2cdetect can help you find which bus number it is. You'll need to load
> i2c-dev before running both commands.

I think i've got something which will work, i'll post a patch once
i've tidied up the patch

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
