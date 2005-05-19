From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [PATCH 2.6] Remove spaces from PCI I2C pci_driver.name fields
Message-Id: <20040810234115.GB22039@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040810003824.GA8643@plexity.net>
In-Reply-To: <20040810003824.GA8643@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

On Mon, Aug 09, 2004 at 05:38:24PM -0700, Deepak Saxena wrote:
> 
> Greg,
> 
> Same thing as IDE...spaces in PCI driver names show up in sysfs file 
> names.  I've also cleaned up all the .name fields to be in the format 
> (${NAME}_i2c|${NAME}_smbus) so they are consistent.
> 
> Please apply,

Applied, thanks.

greg k-h
