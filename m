From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Date: Thu, 19 Aug 2010 10:00:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon,
Message-Id: <20100819100041.GA4801@loge.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100622084557.GA4524@loge.amd.com>
In-Reply-To: <20100622084557.GA4524@loge.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 19, 2010 at 10:34:42AM +0200, Jean Delvare wrote:
  [...]
> > Here is the updated patch considering single core and dual core ASB1
> > CPUs. Tested with model 0x6b ASB1 CPU. I don't have instant access to
> > model 0x6f and 0x7f CPU models.
> 
> Great, thanks. Looks much more in line with the datasheet.
> 
> I presume we will have to update is_rev_g_desktop() every time a new
> ASB1 K8 processor is released? :(

My personnel assumption is that the number of new ASB1 K8 models (if
any) is quite low.

> > diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> > index b9bb3e0..bbfc0ad 100644
> > --- a/drivers/hwmon/k8temp.c
> > +++ b/drivers/hwmon/k8temp.c
> > @@ -143,6 +143,34 @@ static const struct pci_device_id k8temp_ids[] = {
> >  
> >  MODULE_DEVICE_TABLE(pci, k8temp_ids);
> >  
> > +static int is_rev_g_desktop(u8 model)
> 
> Can be marked __devinit.

Ok.

> > +{
> > +	u32 brandidx;
> > +
> > +	if (model < 0x69)
> > +		return 0;
> > +
> > +	if (model = 0xc1 || model = 0x6c || model = 0x7c)
> > +		return 0;
> > +
> > +	/*
> > +	 * differentiate between AM2 and ASB1
> > +	 */
> > +
> > +	brandidx = cpuid_ebx(0x80000001);
> > +	brandidx = (brandidx >> 9) & 0x1f;
> > +	if (model = 0x6b &&
> > +	    (brandidx = 0xb || brandidx = 0xc))
> > +		return 0;
> > +
> > +	if ((model = 0x6f || model = 0x7f) &&
> > +	    (brandidx = 7 || brandidx = 9 ||
> 
> I've made these constants hexadecimal for consistency. I've also
> inverted the tests so they are in the same order as in the datasheet,
> and added some comments to make the code easier to follow.

Fine with me.

> > +	     brandidx = 0xc))
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +
> >  static int __devinit k8temp_probe(struct pci_dev *pdev,
> >  				  const struct pci_device_id *id)
> >  {
> > @@ -179,17 +207,13 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
> >  				 "wrong - check erratum #141\n");
> >  		}
> >  
> > -		if ((model >= 0x69) &&
> > -		    !(model = 0xc1 || model = 0x6c || model = 0x7c ||
> > -		      model = 0x6b || model = 0x6f || model = 0x7f)) {
> > -			/*
> > -			 * RevG desktop CPUs (i.e. no socket S1G1 or
> > -			 * ASB1 parts) need additional offset,
> > -			 * otherwise reported temperature is below
> > -			 * ambient temperature
> > -			 */
> > +		/*
> > +		 * RevG desktop CPUs (i.e. no socket S1G1 or ASB1
> > +		 * parts) need additional offset, otherwise reported
> > +		 * temperature is below ambient temperature
> > +		 */
> > +		if (is_rev_g_desktop(model))
> >  			data->temp_offset = 21000;
> > -		}
> >  
> >  		break;
> >  	}
> 
> I've adjusted your second patch so that it applies cleanly. Both
> patches after my changes are available at:
>   ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/
> Please check.

It looks good.


Thanks,

Andreas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
