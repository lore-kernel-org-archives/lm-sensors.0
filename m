From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Mar 2009 08:48:47 +0000
Subject: Re: [lm-sensors] Compaq Evo D51S hidden sensor
Message-Id: <20090302094847.39f58f4a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
In-Reply-To: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2 Mar 2009 08:37:25 +1000, David O'Shea wrote:
> 
> Hi Jean,
> 
> > From: khali@linux-fr.org
> [...]
> > Your patch looks OK and it applies fine to 2.6.29-rc6. All it is
> > missing is a proper subject, header comment, and your Signed-off-by
> > as per Documentation/SubmittingPatches' "Sign your work" section.
> 
> Thanks for the pointer, is the below okay?

Yes it's OK.

>  I hope hotmail doesn't reformat this :)

It did :( But I copied the patch from your previous mail so it's OK.

I will now forward your patch to the PCI subsystem maintainer.

> 
> Regards,
> David
> 
> Subject: [PATCH] pci: Compaq Evo D510 SMBus quirk using USB instead of VGA
> 
> From: David O'Shea 
> 
> On the Compaq Evo D510 SFF/CMT, a PCI quirk activated the SMBus device
> based on detection of the on-board VGA controller, but the on-board
> VGA is disabled if an AGP card is inserted, so look for one of the USB
> controllers instead.
> 
> Signed-off-by: David O'Shea 
> ---
>  Patch against 2.6.27 re-generated with '-p' and '-X' flags:
> 
> diff -upr -X linux-2.6.27.i686.orig/Documentation/dontdiff linux-2.6.27.i686.orig/drivers/pci/quirks.c linux-2.6.27.i686.compaq_evo_d51s_sensors/drivers/pci/quirks.c
> --- linux-2.6.27.i686.orig/drivers/pci/quirks.c    2009-01-18 13:31:39.000000000 +1030
> +++ linux-2.6.27.i686.compaq_evo_d51s_sensors/drivers/pci/quirks.c    2009-03-01 20:03:19.000000000 +1030
> @@ -1067,10 +1067,15 @@ static void __init asus_hides_smbus_host
>                   * its on-board VGA controller */
>                  asus_hides_smbus = 1;
>              }
> -        else if (dev->device = PCI_DEVICE_ID_INTEL_82845G_IG)
> +        else if (dev->device = PCI_DEVICE_ID_INTEL_82801DB_2)
>              switch(dev->subsystem_device) {
>              case 0x00b8: /* Compaq Evo D510 CMT */
>              case 0x00b9: /* Compaq Evo D510 SFF */
> +                /* Motherboard doesn't have Host bridge
> +                 * subvendor/subdevice IDs and on-board VGA
> +                 * controller is disabled if an AGP card is
> +                 * inserted, therefore checking USB UHCI
> +                 * Controller #1 */
>                  asus_hides_smbus = 1;
>              }
>          else if (dev->device = PCI_DEVICE_ID_INTEL_82815_CGC)
> @@ -1095,7 +1100,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82915GM_HB, asus_hides_smbus_hostbridge);
>  
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82810_IG3,    asus_hides_smbus_hostbridge);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82845G_IG,    asus_hides_smbus_hostbridge);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_2,    asus_hides_smbus_hostbridge);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82815_CGC,    asus_hides_smbus_hostbridge);
>  
>  static void asus_hides_smbus_lpc(struct pci_dev *dev)
> diff -upr -X linux-2.6.27.i686.orig/Documentation/dontdiff linux-2.6.27.i686.orig/include/linux/pci_ids.h linux-2.6.27.i686.compaq_evo_d51s_sensors/include/linux/pci_ids.h
> --- linux-2.6.27.i686.orig/include/linux/pci_ids.h    2009-01-18 13:32:39.000000000 +1030
> +++ linux-2.6.27.i686.compaq_evo_d51s_sensors/include/linux/pci_ids.h    2009-03-01 19:43:42.000000000 +1030
> @@ -2322,6 +2322,7 @@
>  #define PCI_DEVICE_ID_INTEL_82801CA_12    0x248c
>  #define PCI_DEVICE_ID_INTEL_82801DB_0    0x24c0
>  #define PCI_DEVICE_ID_INTEL_82801DB_1    0x24c1
> +#define PCI_DEVICE_ID_INTEL_82801DB_2    0x24c2
>  #define PCI_DEVICE_ID_INTEL_82801DB_3    0x24c3
>  #define PCI_DEVICE_ID_INTEL_82801DB_5    0x24c5
>  #define PCI_DEVICE_ID_INTEL_82801DB_6    0x24c6

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
