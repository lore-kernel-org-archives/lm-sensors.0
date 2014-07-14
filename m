From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 14 Jul 2014 20:06:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon, k10temp: Add support for AMD F15h M60h processor
Message-Id: <20140714200612.GA29123@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405369388-12729-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
 <20140714195128.GA25124@pd.tnic>
 <53C4368E.9090103@amd.com>
In-Reply-To: <53C4368E.9090103@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, clemens@ladisch.de, jdelvare@suse.de, rdunlap@infradead.org, bhelgaas@google.com, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

On Mon, Jul 14, 2014 at 02:59:10PM -0500, Aravind Gopalakrishnan wrote:
> On 7/14/2014 2:51 PM, Borislav Petkov wrote:
> >On Mon, Jul 14, 2014 at 03:23:08PM -0500, Aravind Gopalakrishnan wrote:
> >>@@ -211,6 +228,7 @@ static const struct pci_device_id k10temp_id_table[] = {
> >>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F3) },
> >>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M10H_F3) },
> >>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F3) },
> >>+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F3) },
> >>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
> >>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
> >>  	{}
> >>diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> >>index 7fa3173..3c8e328 100644
> >>--- a/include/linux/pci_ids.h
> >>+++ b/include/linux/pci_ids.h
> >>@@ -520,6 +520,7 @@
> >>  #define PCI_DEVICE_ID_AMD_15H_M10H_F3	0x1403
> >>  #define PCI_DEVICE_ID_AMD_15H_M30H_NB_F3 0x141d
> >>  #define PCI_DEVICE_ID_AMD_15H_M30H_NB_F4 0x141e
> >>+#define PCI_DEVICE_ID_AMD_15H_M60H_NB_F3 0x1573
> >I'm assuming this is used somewhere else besides k10temp.c?
> >
> 
> Yeah, will most likely need to add EDAC bits. But that is something
> I can't test now.
> 
Sorry, I can not add this to a common file unless it is used elsewhere.
I would suggest to add it locally for now. It can be moved to the
common file once it is used elsewhere.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
