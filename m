From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [PATCH 2.6] Hydra i2c
Message-Id: <20040131003512.GD10465@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0401181323130.653@callisto> <20040118124957.GA7585@lst.de> <Pine.GSO.4.58.0401251200580.20527@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0401251200580.20527@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, sensors@stimpy.netroedge.com, Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>

On Sun, Jan 25, 2004 at 12:22:02PM +0100, Geert Uytterhoeven wrote:
> 
> Here's a new version, incorporating these comments, and making a few more
> changes:
>   - Use struct definition in <asm/hydra.h> instead of #defined offset
>   - Remove flushes are register writes, they are no longer needed
>   - Use pci_resource_start() instead of dev->resource[].start
>   - ioremap() the whole resource instead of the first 256 bytes
>   - Check for errors returned by ioremap() and i2c_bit_add_bus()
>   - Add resource management
>   - Call iounmap() in hydra_remove() instead of in i2c_hydra_exit()
>   - Let I2C_HYDRA depend on I2C and select I2C_ALGOBIT instead of depending on
>     I2C_ALGOBIT

Looks good, I've added this to my tree and will send it on in the next
round of i2c patches.

thanks,

greg k-h
