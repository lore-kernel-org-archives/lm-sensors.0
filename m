From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Mar 2010 08:38:51 +0000
Subject: Re: [lm-sensors] Support for W83627DHG
Message-Id: <20100331103851.1b4daa6b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BB0BE38.2090502@kaskonetworks.it>
In-Reply-To: <4BB0BE38.2090502@kaskonetworks.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fabio,

On Wed, 31 Mar 2010 10:07:56 +0200, fabio.antonini@kaskonetworks.it wrote:
> Hi Jean
> I have realized that the BIOS doesn't set the SIO_REG_ADDR as it should. 
> So I have added a new parameter (force_addr) to let the user to write 
> the LPC base address to the register.
> Now the modified section is
> 
>     /* initialize SIO_REG_ADDR if BIOS doesn't set it */
>     if (force_addr) {
>         printk(KERN_WARNING DRVNAME ": Writing SIO_REG_ADDR 0x%x.\n", 
> force_addr);
>         superio_outb(sioaddr, SIO_REG_ADDR, force_addr >> 8);
>         superio_outb(sioaddr, SIO_REG_ADDR + 1, force_addr & 0x00FF);
>         /* Activate logical device if needed */
>         val = superio_inb(sioaddr, SIO_REG_ENABLE);
>         if (!(val & 0x01)) {
>             printk(KERN_WARNING DRVNAME ": Enabling Super-I/O.\n");
>             superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
>         }
>     }
>    
>     /* We have a known chip, find the HWM I/O address */
>     superio_select(sioaddr, W83627EHF_LD_HWM);
>     val = (superio_inb(sioaddr, SIO_REG_ADDR) << 8)
>         | superio_inb(sioaddr, SIO_REG_ADDR + 1);
>     printk(KERN_ERR DRVNAME ": val = 0x%x\n", val);
>     *addr = val & IOREGION_ALIGNMENT;
>     if (*addr = 0) {
>         printk(KERN_ERR DRVNAME ": Refusing to enable a Super-I/O "
>                "device with a base I/O port 0.\n");
>         superio_exit(sioaddr);
>         return -ENODEV;
>     }
> 
> I'm not sure that this approach is correct. In your opinion is this 
> reasonable or not?

I would like to avoid this. If the BIOS is broken, let's have the BIOS
fixed by the manufacturer. But I don't think this is your care, see
below.

> Now i can load the driver by the following command:
> 
> # modprobe w83627ehf force_addr=0x290
> 
> I have attached a text file with the sensors-detect and sensors output 
> message.
> Now the driver is properly loaded. The tempeature and voltage detected 
> are meaningless because the board I'm working on doesn't use the 
> W83627EHF for temperature and voltage monitoring.

Indeed. Which is why they don't initialize the base I/O for the
hardware monitoring block: they don't use this feature.

> I need to use it for its GPIOs and parallel port. Do you know if anyone 
> else has already worked on the GPIO or parallel section of the 
> W83627ehf. At the moment my feeling is that both are not supported in 
> the current driver.

The w83627ehf driver only cares about the hardware monitoring block.
The parallel port should already work fine, being handled by more
generic code (PC parallel port is fully standardized.) For GPIOs, I am
not aware of any driver for this chip or anyone working on it, but
again setting the I/O address of the hardware monitoring block isn't
needed at all to get GPIOs to work. So the change you proposed isn't
going to help you with that.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
