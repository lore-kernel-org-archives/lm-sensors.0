From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-viapro and via686a don't mix with linux-2.6.0-test1
Message-Id: <20030715223700.GB6409@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030715142051.GA14443@h111.hadiko.de>
In-Reply-To: <20030715142051.GA14443@h111.hadiko.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 15, 2003 at 08:42:28PM +0200, Christoph Heine wrote:
> +	while ((dev = pci_find_device(PCI_VENDOR_ID_VIA, PCI_ANY_ID, dev)) != NULL) {
> +	id = pci_match_device(vt596_ids, dev);
> +       		if(id)
> +        		if(vt596_probe(dev, id) >= 0)
> +            			return 0;
> +	}
> +	return -ENODEV;

Heh, yes this is the "proper" way to do this on 2.5/2.6 to get the code
to build and run, but it's not the "real" fix.

It still has the same problems that pci_for_each_dev() has (minus a few
race conditions...)

thanks,

greg k-h
