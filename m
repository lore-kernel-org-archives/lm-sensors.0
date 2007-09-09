From: Greg KH <greg@kroah.com>
Date: Sun, 09 Sep 2007 17:25:15 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.23-rc4][reRESEND] irq: irq and pci_ids
Message-Id: <20070909172515.GB14004@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200708302033.48362.jason.d.gaston@intel.com> <39B20DF628532344BC7A2692CB6AEE0701B9A4C4@orsmsx420.amr.corp.intel.com>
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0701B9A4C4@orsmsx420.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, khali@linux-fr.org, LM Sensors <lm-sensors@lm-sensors.org>

On Thu, Sep 06, 2007 at 10:24:54AM -0700, Gaston, Jason D wrote:
> >-----Original Message-----
> >From: Gaston, Jason D
> >Sent: Thursday, August 30, 2007 8:34 PM
> >To: gregkh@suse.de; linux-kernel@vger.kernel.org; linux-
> >pci@atrey.karlin.mff.cuni.cz; khali@linux-fr.org; i2c@lm-sensors.nu;
> >Gaston, Jason D
> >Subject: [PATCH 2.6.23-rc4][reRESEND] irq: irq and pci_ids patch for
> Intel
> >Tolapai
> >
> >Resend with uppercase define.
> >
> >This updated patch adds the Intel Tolapai LPC and SMBus controller
> DID's.
> >
> >Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> >
> >--- linux-2.6.23-rc4/arch/i386/pci/irq.c.orig	2007-08-27
> >18:32:35.000000000 -0700
> >+++ linux-2.6.23-rc4/arch/i386/pci/irq.c	2007-08-30
> 20:23:49.000000000 -
> >0700
> >@@ -550,6 +550,7 @@
> > 		case PCI_DEVICE_ID_INTEL_ICH9_3:
> > 		case PCI_DEVICE_ID_INTEL_ICH9_4:
> > 		case PCI_DEVICE_ID_INTEL_ICH9_5:
> >+		case PCI_DEVICE_ID_INTEL_TOLAPAI_0:
> > 			r->name = "PIIX/ICH";
> > 			r->get = pirq_piix_get;
> > 			r->set = pirq_piix_set;
> >--- linux-2.6.23-rc4/include/linux/pci_ids.h.orig	2007-08-27
> >18:32:35.000000000 -0700
> >+++ linux-2.6.23-rc4/include/linux/pci_ids.h	2007-08-30
> >20:23:08.000000000 -0700
> >@@ -2293,6 +2293,8 @@
> > #define PCI_DEVICE_ID_INTEL_MCH_PC	0x3599
> > #define PCI_DEVICE_ID_INTEL_MCH_PC1	0x359a
> > #define PCI_DEVICE_ID_INTEL_E7525_MCH	0x359e
> >+#define PCI_DEVICE_ID_INTEL_TOLAPAI_0	0x5031
> >+#define PCI_DEVICE_ID_INTEL_TOLAPAI_1	0x5032
> > #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
> > #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
> > #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
> 
> Greg,
> 
> Is this patch acceptable?  I need to get this in before the i2c-i801
> patch will be accepted.

I've just applied it to my trees.

thanks,

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
