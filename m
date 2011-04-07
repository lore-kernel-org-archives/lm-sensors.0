From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Date: Thu, 07 Apr 2011 09:13:21 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add driver for AMD family 15h
Message-Id: <20110407091321.GA17820@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110404160733.GA11818@alberich.amd.com>
 <20110405144536.GA5054@alberich.amd.com>
 <20110406135424.GC2177@alberich.amd.com>
 <20110406185044.16e5f92a@endymion.delvare>
In-Reply-To: <20110406185044.16e5f92a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Thomas Renninger <trenn@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>

On Wed, Apr 06, 2011 at 06:50:44PM +0200, Jean Delvare wrote:
> Hi Andreas,
> 
> On Wed, 6 Apr 2011 15:54:24 +0200, Andreas Herrmann wrote:
> > --- /dev/null
> > +++ b/Documentation/hwmon/f15h_power
> > @@ -0,0 +1,37 @@
> > +Kernel driver f15h_power
> > +============
> > +
> > +Supported chips:
> > +* AMD Family 15h Processors
> > +
> > +  Prefix: 'f15h_power'
> > +  Addresses scanned: PCI space
> > +  Datasheets:
> > +  BIOS and Kernel Developer's Guide (BKDG) For AMD Family 15h Processors
> > +    (not yet published)
> > +
> > +Author: Andreas Herrmann <andreas.herrmann3@amd.com>
> 
> BTW, please consider adding an entry in MAINTAINERS.

Yep.

> > +
> > +Description
> > +-----------
> > +
> > +This driver permits reading of registers providing power information
> > +of AMD Family 15h processors.
> > +
> > +For AMD Family 15h processors the following power values can be
> > +calculated using different processor northbridge function registers
> 
> A trailing ":" would be nice.
> 
> > +
> > +* BasePwrWatts: Specifies in watts the maximum amount of power
> > +  consumed by the processor for NB and logic external to the core.
> > +* ProcessorPwrWatts: Specifies in watts the maximum amount of power
> > +  the processor can support.
> > +* CurrPwrWatts: Specifies in watts the current amount of power being
> > +  consumed by the processor.
> > +
> > +This driver provides ProcessorPwrWatts and CurrPwrWatts:
> > +* power1_max (ProcessorPwrWatts)
> 
> I see you changed this name once already, but... What is expected to
> happen if the power consumed exceeds this limit? If you expect the CPU
> to get damaged, then power1_crit would be more appropriate.
> 
> Another way to decide if _max or _crit is more appropriate is by
> answering the question: if a second limit was added in the future,
> would it more likely be below or above this one?

It might make sense to use it as _crit and the interim result of

  (tdp_limit + base_tdp) * tdp_to_watts

being less than ProcessorPwrWatts as _max.

> > +* power1_input (CurrPwrWatts)
> > +
> > +On multi-node processors the calculated value is for the entire
> > +package and not for a single node. Thus the driver creates sysfs
> > +attributes only for internal node0 of a multi-node processor.
> 
> > (...)
> > +	return sprintf(buf, "%u\n", (u32) ptdp);
> 
> Maybe I'm just nitpicking, but I still don't think it's correct. %u
> wants unsigned int, not u32. It might be the same but that's by luck.
> 
> > --- a/drivers/hwmon/k10temp.c
> > +++ b/drivers/hwmon/k10temp.c
> > @@ -205,7 +205,7 @@ static void __devexit k10temp_remove(struct pci_dev *pdev)
> >  	dev_set_drvdata(&pdev->dev, NULL);
> >  }
> >  
> > -static const struct pci_device_id k10temp_id_table[] = {
> > +static DEFINE_PCI_DEVICE_TABLE(k10temp_id_table) = {
> >  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
> >  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_11H_NB_MISC) },
> >  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
> 
> Such cleanups should go to separate patches, as they don't have
> anything to do with your initial effort. And that way you can fix
> k8temp i5k_amb too.


This slipped in by accident. I might send a separate patch to clean this
up in several hwmon drivers.


Andreas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
