From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: [PATCH 2.6] I2C: Use PCI_DEVICE in bus drivers
Message-Id: <20041221191041.GC8916@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041218191234.4fc7fd76.khali@linux-fr.org>
In-Reply-To: <20041218191234.4fc7fd76.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 18, 2004 at 07:12:34PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> > Hint, the PCI_DEVICE() macro makes this a lot simpler :)
> 
> What about this cleanup patch then? It generalizes the use of
> PCI_DEVICE() among i2c/busses drivers (with some pci ids cleanups for
> free).

Nice.  Applied, thanks.

greg k-h
