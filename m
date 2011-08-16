From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Aug 2011 14:27:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (KConfig) avoid building drivers
Message-Id: <20110816162706.698d2ef5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110725195206.4097.45688.email-sent-by-dnelson@localhost6.localdomain6>
In-Reply-To: <20110725195206.4097.45688.email-sent-by-dnelson@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dean,

On Tue, 26 Jul 2011 09:35:35 -0500, Dean Nelson wrote:
> On 07/26/2011 04:25 AM, Jean Delvare wrote:
> >> @@ -933,7 +938,7 @@ config SENSORS_S3C_RAW
> >>
> >>   config SENSORS_SIS5595
> >>   	tristate "Silicon Integrated Systems Corp. SiS5595"
> >> -	depends on PCI
> >> +	depends on PCI&&  !PPC
> >>   	help
> >>   	  If you say yes here you get support for the integrated sensors in
> >>   	  SiS5595 South Bridges.
> >
> > This one is a PCI driver, it doesn't do random I/O, so it should be
> > left as is. You did not experience a crash on PowerPC by loading this
> > driver, did you?
> 
> Okay. Thanks. And no, I didn't experience an Oops.
> 
> When sm_sis5595_init() gets called at module load time, it calls
> pci_register_driver() to register sis5595_pci_probe(), which never
> gets called.
> 
> Had sis5595_pci_probe() been called, it could have called
> platform_driver_register() to register sis5595_probe(), which is
> where we could potentially read/write the ISA address.

This is really a PCI I/O address and not an ISA address, by
construction. Any system with this PCI device would presumably properly
support said I/O operations.

> I'd added the " && !PPC" to this driver because it was in the list
> of drivers you mentioned that I hadn't, when I first introduced this
> issue. Sorry for misunderstanding. It's been removed from v2 of this
> patch.

Oops, this is my fault then, sorry for the confusion. For my excuse,
this was before my pretty needed vacation ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
