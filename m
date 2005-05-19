From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Patch: SiS651 support in i2c-sis645
Message-Id: <3ED8C65D.5070509@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EAD0D9F.5010509@cluster-labs.com>
In-Reply-To: <3EAD0D9F.5010509@cluster-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark H,
should this be applied?

Norbert Roos wrote:
> 
> Hello!
> 
> The following patch adds support for the SiS651, which is register 
> compatible to the SiS650.
> 
> I'm a little bit suprised that your list with the supported hardware 
> says the SiS651 is already supported - the i2c-sis645 driver (version 
> 2.7.0) does not look for the SiS651 device ID..
> 
> So if you the patch useful, here it is; it changes i2c-sis645.c and 
> sensors-detect:
> 
> ----------
> 
> diff -ru lm_sensors-2.7.0-unpatched/kernel/busses/i2c-sis645.c 
> lm_sensors-2.7.0/kernel/busses/i2c-sis645.c
> --- lm_sensors-2.7.0-unpatched/kernel/busses/i2c-sis645.c       Sun Dec 
>  1 22:02:46 2002
> +++ lm_sensors-2.7.0/kernel/busses/i2c-sis645.c Mon Apr 28 12:15:00 2003
> @@ -67,6 +67,11 @@
>  #define PCI_DEVICE_ID_SI_650 0x0650
>  #endif
> 
> +/* SiS651 north bridge */
> +#ifndef PCI_DEVICE_ID_SI_651
> +#define PCI_DEVICE_ID_SI_651 0x0651
> +#endif
> +
>  /* SiS735 combo chipset */
>  #ifndef PCI_DEVICE_ID_SI_735
>  #define PCI_DEVICE_ID_SI_735 0x0735
> @@ -273,6 +278,8 @@
>                                 PCI_DEVICE_ID_SI_646, NULL))
>                         && (NULL = pci_find_device(PCI_VENDOR_ID_SI,
>                                 PCI_DEVICE_ID_SI_650, NULL))
> +                       && (NULL = pci_find_device(PCI_VENDOR_ID_SI,
> +                               PCI_DEVICE_ID_SI_651, NULL))
>                         && (NULL = pci_find_device(PCI_VENDOR_ID_SI,
>                                 PCI_DEVICE_ID_SI_735, NULL))) {
>                         printk("i2c-sis645.o: Error: Can't find suitable 
> host bridge!\n");
> diff -ru lm_sensors-2.7.0-unpatched/prog/detect/sensors-detect 
> lm_sensors-2.7.0/prog/detect/sensors-detect
> --- lm_sensors-2.7.0-unpatched/prog/detect/sensors-detect       Tue Nov 
> 26 18:03:02 2002
> +++ lm_sensors-2.7.0/prog/detect/sensors-detect Mon Apr 28 12:15:20 2003
> @@ -238,6 +238,14 @@
>       } ,
>       {
>         vendid => 0x1039,
> +       devid  => 0x0651,
> +       func => 0,
> +       procid => "Silicon Integrated Systems SIS651",
> +       driver => "i2c-sis645",
> +       match => sub { $_[0] =~ /^SMBus SiS645 adapter at 
> 0x[0-9,a-f]{4}/ },
> +     } ,
> +     {
> +       vendid => 0x1039,
>         devid  => 0x0735,
>         func => 0,
>         procid => "Silicon Integrated Systems SIS735",
> 
> ----------
> 
> bye
> Norbert
> 
