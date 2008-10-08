From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 08 Oct 2008 18:19:42 +0000
Subject: Re: [lm-sensors] [PATCH 08/12] i5k_amb: Load automatically on
Message-Id: <20081008181941.GD7726@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011904.12701.37660.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011904.12701.37660.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 08, 2008 at 01:13:02PM +0200, Jean Delvare wrote:

> > +MODULE_ALIAS("pci:v00008086d000025F0sv*sd*bc*sc*i*");
> > +MODULE_ALIAS("pci:v00008086d00004030sv*sd*bc*sc*i*");
> 
> This looks wrong to me. If these PCI devices provide the feature this
> driver supports, then why is this a platform driver and not a PCI
> driver? You would get the right module aliases for free.

The AMB registers live at an arbitrary location in memory.  That
location is given in those PCI devices' config data, but the memory
address is not part of the device's memory.  The driver only attaches to
the PCI device long enough to read the location, and then it doesn't
need PCI or the device anymore.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
