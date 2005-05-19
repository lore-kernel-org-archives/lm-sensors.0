From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH 2.5.xx] - i2c-prosavage driver
Message-Id: <20030618003546.GB2132@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0306180041260.31258-200000@axp.arion.loc>
In-Reply-To: <Pine.LNX.4.21.0306180041260.31258-200000@axp.arion.loc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 18, 2003 at 01:30:17AM +0200, henk wrote:
> 
> Had too much fun -> adapted codingstyle

Oh so close:

> +static void bit_s3via_setscl(void *cr, int val)
> +{
> +	unsigned int r;
> +	r = getCR1((unsigned int)cr);
> +	r |= I2C_ENAB;
> +	if(val)	{

Put a space after if and for statments, before the '('.

> +	switch(reg) {
> +	case IOREG_SERIAL1:
> +	    snprintf(p->adap.dev.name, sizeof(p->adap.dev.name),
> +		"ProSavage I2C bus at %02x:%02x.%x", dev->bus->number,
> +		PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> +	    break;

You still need to indent the lines within the case statment with a tab,
not 4 spaces :)

> +		if(tmp != (u8)getCR1(IOREG_SUBSYS + i)) {
> +		    printk(DRIVER_ID ": Video IO registers redirected?\n");   
> +		    return -ENODEV;
> +		}

More tabs needed...

> +static void __devexit prosavage_remove(struct pci_dev *dev)
> +{
> +	int ret;
> +	while(i2c_bus_cnt > 0) {
> +		i2c_bus_cnt--;
> +	        ret = i2c_bit_del_bus(&i2c_bus[i2c_bus_cnt].adap);
> +	        if(ret) {
> +        	    printk(DRIVER_ID ": %s not removed\n",
> +			i2c_bus[i2c_bus_cnt].adap.dev.name);
> +		}
> +	}
> +}

And yet more here too.

thanks,

greg k-h
