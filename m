From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [PATCH 2.5.xx] - i2c-prosavage driver
Message-Id: <20030623222326.GB11297@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0306180041260.31258-200000@axp.arion.loc>
In-Reply-To: <Pine.LNX.4.21.0306180041260.31258-200000@axp.arion.loc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 21, 2003 at 07:36:42PM +0200, henk wrote:
> 
> Using the MMIO method now, the driver should be able to handle multiple
> video cards.
> 
> The driver could potentialy also handle other s3 devices. You can try this
> by adding more pci id's to the prosavage_pci_tbl.
> 
> 
> Have fun,
> 
> henk
> 
> PS.
> The i2c-prosavage dirver is also compatible with the lm_sensors2 CVS tree.
> Greg is the coding style sufficient now for integration in the CVS trees?

I don't have write access to the cvs tree, but it looks good.  I'll send
it off to be included in the main 2.5 kernel.org kernel in a bit.

thanks,

greg k-h
