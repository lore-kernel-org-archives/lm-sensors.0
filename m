From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Date: Wed, 18 Aug 2010 09:10:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon,
Message-Id: <20100818091052.GB5080@loge.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100622084557.GA4524@loge.amd.com>
In-Reply-To: <20100622084557.GA4524@loge.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 17, 2010 at 06:21:38PM +0200, Jean Delvare wrote:

 [...]

> > +static int is_rev_g_desktop(u8 model)
> > +{
> > +	u32 brandidx;
> > +
> > +	if (model < 0x69)
> > +		return 0;
> > +
> > +	if (model = 0xc1 || model = 0x6c || model = 0x7c ||
> > +	    model = 0x6f || model = 0x7f)
> > +		return 0;
> > +
> > +	if (model = 0x6b) {
> > +		/* differentiate between AM2 and ASB1 */
> > +		brandidx = cpuid_ebx(0x80000001);
> > +		brandidx = (brandidx >> 9) & 0x1f;
> > +		if (brandidx > 0xa)
> 
> This will only catch the "AMD Sempron(tm) Processor 2RRU" entry, if I
> read both the code and the datasheet right?

No, it will catch only the dual-core CPUs

	0Bh 0h AMD Turion(tm) Neo X2 Dual Core Processor L6RR (ASB1)
	0Ch 0h AMD Athlon(tm) Neo X2 Dual Core Processor L3RR (ASB1)

See revision 3.46 of the RG:
http://support.amd.com/us/Processor_TechDocs/33610.pdf


> Is this correct? What about the 3 other ASB1 entries in table 8? And
> why are you comparing with 0xa while this specific value doesn't
> match any CPU model?

Hmm, wait let me double check this. (Thought the single core variants were
not affected by this problem)

Damn!

Need to update this patch. I did not check table 2 which lists
single-core AM2 CPUs.

model 0x6f and 0x7f (both single core) are also provided as ASB1 and
AM2.

> > +			return 0;
> > +	}
> > +
> > +	return 1;
> > +}
> > +
> >  static int __devinit k8temp_probe(struct pci_dev *pdev,
> >  				  const struct pci_device_id *id)
> >  {
> > @@ -179,9 +201,7 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
> >  				 "wrong - check erratum #141\n");
> >  		}
> >  
> > -		if ((model >= 0x69) &&
> > -		    !(model = 0xc1 || model = 0x6c || model = 0x7c ||
> > -		      model = 0x6b || model = 0x6f || model = 0x7f)) {
> > +		if (is_rev_g_desktop(model))
> >  			/*
> >  			 * RevG desktop CPUs (i.e. no socket S1G1 or
> >  			 * ASB1 parts) need additional offset,
> > @@ -189,7 +209,6 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
> >  			 * ambient temperature
> >  			 */
> >  			data->temp_offset = 21000;
> > -		}
> >  
> >  		break;
> >  	}
> 
> I also do not like the brace change. While technically correct, it
> could lead to mistakes on future changes, because the large comment
> doesn't make it immediately obvious that this is currently a
> single-statement branch.

Ok.

Thanks a lot for reviewing.
I'll come up with an updated patch.



Andreas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
