From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Sep 2011 21:01:58 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (coretemp) Don't use
Message-Id: <20110921230158.6a237afa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316536503-26883-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316536503-26883-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 21 Sep 2011 13:35:28 -0700, Guenter Roeck wrote:
> On Wed, 2011-09-21 at 15:56 -0400, Jean Delvare wrote:
> > On Tue, 20 Sep 2011 09:35:02 -0700, Guenter Roeck wrote:
> > > +	if (c->x86_model > 0xe && c->x86_model != 0x1c) {
> > > +		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
> > > +					&eax, &edx);
> > > +		if (!err) {
> > 
> > I would appreciate a debug message on error, so that we can adjust the
> > tests above as needed. For example I'm not sure if the more recent Atom
> > series have this register. Furthermore, it might make sense to play it
> > safe and discard the value if it reads 0 (as I would expect if a CPU
> > doesn't support these bits.)
> > 
> We now have get_tjmax() reading the same register. That function already
> generates a warning message if the register can not be read. Do we
> really need another message ?

Good point, I had forgotten about this. No, we don't want duplicate
error messages. Instead, I think we should read
MSR_IA32_TEMPERATURE_TARGET only once, and set both tjmax and ttarget.
This could all get merged into init_temp_data().

I'm not saying that we want this in 3.1 though, it's not urgent. We can
go with your patch and improve the code later.

> Not sure about discarding the value either. If we drop the attribute if
> ttarget is 0, people will wonder where tempX_max disappeared to. Worst
> case tempX_max will show up at the same temperature as tempX_crit, so we
> would know (or learn) about it and users would still have the attribute
> available.

This is a read-only value, there's no point in making it "available" if
the value is known to be wrong.

Here again, I'm fine if your patch doesn't include that change, after
all you're mainly reverting to pre 3.0 behavior so it makes sense to
stick to what we had before for now. I can submit patches for the
proposed changes later, and we can discuss them again then.

> > > +			tdata->ttarget
> > > +			  = tdata->tjmax - (((eax >> 8) & 0xff) * 1000);
> > > +			tdata->attr_size++;
> > > +		}
> > >  	}
> > >  
> > >  	pdata->core_data[attr_no] = tdata;
> > 
> > Patch tested on a Xeon E5520 and a Core Duo T2600, works OK.
> > 
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> > 
> > (with or without the suggested improvements.)
> > 
> Thanks for the review!

Thanks for the patches :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
