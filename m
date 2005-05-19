From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Tyan 2720 answer
Message-Id: <3ED8C5B7.6030405@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EB181CC.3070900@nist.gov>
In-Reply-To: <3EB181CC.3070900@nist.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Very interesting.
This is certainly a 2720-specific implementation,
no hints about this use of GPIO27/28 in the ICH3 datasheet.
Our next release will have an ISA driver for the 627HF which
will mean you don't need this workaround to access sensors.
But this does seem to be a popular board - do you think
this should be included in our package?
I think so. It's a good example of how to do GPIO control.

Joseph Konczal wrote:
> I've seen questions in the archive, but no adequate answers about 
> exactly how to get the CPU temperature sensors working on the Tyan 2720 
> motherboard.  The trouble is that there are two alternate sets of SMB 
> devices that can not be activated at the same time.  They are controlled 
> by two GPIO lines on the Intel 82801CA ICH3-S.   When GPIO27 and GPIO28 
> are both high, the EEPROMs on the memory chips, and some clock chip are 
> activated.  When GPIO27 is low and GPIO28 is high, then the CPU 
> temperature sensors are activated.  Unfortunately, the default seems to 
> be to activate the EEPROMs in order to the information needed for 
> booting and to leave them active.  One must lower GPOI27 before the CPU 
> temperature sensors will work.  I have written a crude little device 
> driver that does that, and now I can monitor the temperatures of my CPUs 
> using the ADM1021 driver.  The driver autodetects the Xeon temperature 
> sensors as ADM1023, and that seems to work.  It also works when you 
> force them to ADM1021 as recommended in the module documentation.
> 
> My xeons appear to be lightly used and well cooled.  They read 25 to 27 
> deg C, with one spike up to 30 deg C.  I wonder, though, why my other 
> temperature sensor reads 74 deg C.  That seems too hot.
> 
> -- 
> Joe Konczal <joseph.konczal@nist.gov>
> 
> 
> 
> ------------------------------------------------------------------------
> 
> /* tyan2720-sensors.c - Look for the an ICH3 southbridge and activate GPIO
>  * 27.  On the Tyan 2720 motherboard, this turns on the CPU thermal
>  * sensors and the sensors on the W83627HF Super IO chip.
>  */
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/init.h>
> #include <linux/pci.h>
> 
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Joseph C. Konczal <joseph.konczal@nist.gov>");
> 
> #define MOD_NAME "tyan2720-gpio: "
> 
> #define GPIO_BAR     0x58
> #define GPIO_CNTL    0x5c
> #define GPIO_EN      0x10
> #define GP_LVL       0x0c
> #define GPIO_USE_SEL 0x00
> #define GP_IO_SEL    0x04
> #define GPI_INV      0x2c
> #define GPIO27       (1<<27)
> #define GPIO28       (1<<28)
> 
> const unsigned int vendor = PCI_VENDOR_ID_INTEL;
> const unsigned int device = PCI_DEVICE_ID_INTEL_82801CA_0;
> 
> static struct pci_dev *dev;
> static u32 gpio_base;
> 
> static int __init tyan2720_sensors_init(void)
> {
>   int status;
>   u8  gpio_cntl;
>   u32 gpio_use_sel, gp_io_sel, gp_lvl, gpi_inv, gp_lvl_new;
> 
>   dev = pci_find_device(vendor, device, NULL);
>   if (! dev)
>     {
>       printk(MOD_NAME "could not find INTEL 82801CA chip\n");
>       return 1;
>     }
> 
>   status = pci_read_config_dword(dev, GPIO_BAR, &gpio_base);
>   if (status)
>     {
>       printk(MOD_NAME "could not read GPIO_BAR, dword at %x\n", GPIO_BAR);
>       return 1;
>     }
>   gpio_base &= 0xFFC0;
> 
>   status = pci_read_config_byte(dev, GPIO_CNTL, &gpio_cntl);
>   if (status)
>     {
>       printk(MOD_NAME "could not read GPIO_CNTL, byte at %x\n", GPIO_CNTL);
>       return 1;
>     }
>   else if (! (gpio_cntl & 0x10))
>     {
>       printk(MOD_NAME "gpio not enabled\n");
>       return 1;
>     }
>   printk(MOD_NAME "GPIO_BAR %x, GPIO_CNTL %x\n", gpio_base, gpio_cntl);
> 
>   gpio_use_sel = inl(gpio_base + GPIO_USE_SEL);
>   gp_io_sel    = inl(gpio_base + GP_IO_SEL);
>   gp_lvl       = inl(gpio_base + GP_LVL);
>   gpi_inv      = inl(gpio_base + GPI_INV);
>   printk(MOD_NAME "GPIO_USE_SEL %x, GP_IO_SEL %x, GP_LVL %x, GPI_INV %x\n", 
> 	 gpio_use_sel, gp_io_sel, gp_lvl, gpi_inv);
> 
>   gp_lvl &= 0xF7FFFFFF;	/* Turn off GPIO_27. */
>   gp_lvl |= 0x10000000;	/* Turn on GPIO_28. */
> 
>   outl(gp_lvl, gpio_base + GP_LVL);
> 
>   gp_lvl_new = inl(gpio_base + GP_LVL);
>   printk(MOD_NAME "GP_LVL set %x, read %x\n", gp_lvl, gp_lvl_new);
> 
>   return 0;
> }
> 
> static void __exit tyan2720_sensors_exit(void)
> {
>   ;
> }
> 
> module_init(tyan2720_sensors_init);
> module_exit(tyan2720_sensors_exit);
