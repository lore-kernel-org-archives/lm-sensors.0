From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: sensors-detect and 2.6.0-test3
Message-Id: <20030827033753.GA1867@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 24, 2003 at 01:13:48PM +0200, Geert Uytterhoeven wrote:
> On Sat, 23 Aug 2003, Greg KH wrote:
> > On Thu, Aug 21, 2003 at 06:02:53PM +0200, Geert Uytterhoeven wrote:
> > > On Thu, 21 Aug 2003, Greg KH wrote:
> > > > On Thu, Aug 21, 2003 at 11:34:32AM +0200, Geert Uytterhoeven wrote:
> > > > > Hmm... And all I have on the i2c bus is the SPD EEPROMs on my SDRAM DIMMs.
> > > > > AFAIK there's no kernel `driver' for these?
> > > > 
> > > > There's one in my bk tree, but it's not "correct" and I haven't taken
> > > > the time to fix it up in order to get it into shape for submission to
> > > > the main kernel.
> > > > 
> > > > If you want, I can send a patch so you can test with.
> > > 
> > > Please do so, thanks!
> > 
> > Oops, forgot to send this out, sorry for the delay.
> > 
> > Here's a patch against 2.6.0-test3.  It should work just fine against
> > 2.6.0-test4 too.  Let me know if you have any problems.
> 
> Thanks!
> 
> After applying this additional patch (BTW, can't this be done using Kconfig's
> `select'?):

Yes it should, that's a better idea.  Care to make a patch for it?  :)

> it links and detects 2 EEPROMs (0-0051 and 0-0052), so I guess the Hydra i2c
> driver is working.

Good.

> The Hydra i2c driver patch is below. BTW, it shows up as a legacy i2c device in
> sysfs.  How can I link it to the Hydra's PCI device in sysfs?

Try adding this line:

> +static int __devinit hydra_probe(struct pci_dev *dev,
> +				 const struct pci_device_id *id)
> +{
> +	unsigned int base_addr;
> +
> +	base_addr = dev->resource[0].start;
> +	hydra_bit_data.data = ioremap(base_addr, 0x100);
> +
> +	pdregw(hydra_bit_data.data, 0);		/* clear SCLK_OE and SDAT_OE */

	hydra_adap.dev.parent = &dev->dev;

> +	return i2c_bit_add_bus(&hydra_adap);
> +}

Let me know if that doesn't work.

thanks,

greg k-h
