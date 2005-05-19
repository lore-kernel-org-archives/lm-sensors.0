From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <20030314082142.B11701@infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033153504@kroah.com> <1047603318248@kroah.com>
In-Reply-To: <1047603318248@kroah.com>; from greg@kroah.com on Thu, Mar 13, 2003 at 04:55:00PM -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:
> ChangeSet 1.1106, 2003/03/13 10:50:41-08:00, greg@kroah.com
> 
> i2c: get i2c-ali15x3 driver to actually bind to a PCI device.

OOPS, should take a look at all patches first before complaining :)

>  static struct pci_device_id ali15x3_ids[] __devinitdata = {
> +	{
> +	.vendor =	PCI_VENDOR_ID_AL,
> +	.device =	PCI_DEVICE_ID_AL_M7101,
> +	.subvendor =	PCI_ANY_ID,
> +	.subdevice =	PCI_ANY_ID,
> +	},

The indentation looks a bit b0rked..
