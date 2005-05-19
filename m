From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH] i2c-sis630 for 2.6.0-test11 get rid of pci init
Message-Id: <20031217233549.GB6140@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312160048.17954.amalysh@web.de>
In-Reply-To: <200312160048.17954.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 15, 2003 at 07:46:32PM -0500, Mark Studebaker wrote:
> 
> Greg, can you give us some guidance here? Unless we can bypass
> pci_module_init() in 2.6 a lot of the bus drivers are not going to
> load.

Then we need to merge the drivers together.  We can only allow 1 pci
driver to bind to a pci device at a time due to lots of reasons.  We
can't use the pci_find_device (or pci_get_device) to work safely (what
happens when the pci device is removed from the system on a pci hotplug
system...)

thanks,

greg k-h
