From: Matthew Wilcox <matthew@wil.cx>
Date: Wed, 27 May 2009 15:44:31 +0000
Subject: Re: [lm-sensors] PCI: Quirk for hwmon access on MSI MS-7031 board
Message-Id: <20090527154430.GH5816@parisc-linux.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090525220652.04c2468f@hyperion.delvare>
In-Reply-To: <20090525220652.04c2468f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 25, 2009 at 10:06:52PM +0200, Jean Delvare wrote:
> The MSI MS-7031 is based on an ATI IXP300 south bridge. On this south
> bridge, accessible I/O ports must be enabled explicitly. Unfortunately
> the BIOS forgets to enable access to the hardware monitoring chip I/O
> ports, so hardware monitoring fails.
> 
> Add a quirk enabling access to the required ports (0x295-0x296). This
> is exactly what MSI's own hardware monitoring application is doing, so
> it has to be the right way.

> +#if defined CONFIG_X86 && (defined CONFIG_HWMON || defined CONFIG_HWMON_MODULE)

I don't like this.  It goes against the principle that enabling a module
shouldn't cause the base kernel to get rebuilt.  Is there a reason that
the hardware monitoring code can't contain this quirk instead of the
generic PCI code?

> +/* Open access to 0x295-0x296 (hardware monitoring chip) on MSI MS-7031 */
> +static void __devinit ati_ixp300_open_ioport(struct pci_dev *dev)
> +{
> +	u16 base;
> +	u8 enable;
> +
> +	if (!(dev->subsystem_vendor = 0x1462 &&	/* MSI */
> +	      dev->subsystem_device = 0x0031))		/* MS-7031 */
> +		return;
> +
> +	pci_read_config_byte(dev, 0x48, &enable);
> +	pci_read_config_word(dev, 0x64, &base);
> +
> +	if (base = 0 && !(enable & BIT(2))) {
> +		dev_info(&dev->dev, "Opening wide generic port at 0x295\n");
> +		pci_write_config_word(dev, 0x64, 0x295);
> +		pci_write_config_byte(dev, 0x48, enable | BIT(2));
> +	}
> +}
> +
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x436c, ati_ixp300_open_ioport);
> +#endif	/* CONFIG_X86 && CONFIG_HWMON */
> +
>  static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>  			  struct pci_fixup *end)
>  {
> 
> 
> -- 
> Jean Delvare
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
