From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Hydra i2c
Message-Id: <20040118124957.GA7585@lst.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0401181323130.653@callisto>
In-Reply-To: <Pine.LNX.4.58.0401181323130.653@callisto>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <greg@kroah.com>, sensors@stimpy.netroedge.com, Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>

On Sun, Jan 18, 2004 at 01:28:22PM +0100, Geert Uytterhoeven wrote:
> +static int __devinit hydra_probe(struct pci_dev *dev,
> +				 const struct pci_device_id *id)
> +{
> +	unsigned int base_addr;
> +
> +	base_addr = dev->resource[0].start;

I think you should use pci_resource_start here.

> +	hydra_bit_data.data = ioremap(base_addr, 0x100);

And pci_resource len instead of hardcoding it?  Also you need to
check the ioremap return value.

You should also add a safety exit for the case the probe callback is
called more than once.  Or dynamic allocate a per-device struct instead
of using hydra_bit_data.

> +static void __exit i2c_hydra_exit(void)
> +{
> +	pci_unregister_driver(&hydra_driver);
> +	iounmap(hydra_bit_data.data);

The ioremap should move into the hydra_remove.
