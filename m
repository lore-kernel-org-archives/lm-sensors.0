From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Oct 2008 11:43:53 +0000
Subject: Re: [lm-sensors] [PATCH 08/12] i5k_amb: Load automatically on all
Message-Id: <20081009134353.310aa64f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011904.12701.37660.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011904.12701.37660.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Wed, 8 Oct 2008 11:19:42 -0700, Darrick J. Wong wrote:
> On Wed, Oct 08, 2008 at 01:13:02PM +0200, Jean Delvare wrote:
> 
> > > +MODULE_ALIAS("pci:v00008086d000025F0sv*sd*bc*sc*i*");
> > > +MODULE_ALIAS("pci:v00008086d00004030sv*sd*bc*sc*i*");
> > 
> > This looks wrong to me. If these PCI devices provide the feature this
> > driver supports, then why is this a platform driver and not a PCI
> > driver? You would get the right module aliases for free.
> 
> The AMB registers live at an arbitrary location in memory.  That
> location is given in those PCI devices' config data, but the memory
> address is not part of the device's memory.  The driver only attaches to
> the PCI device long enough to read the location, and then it doesn't
> need PCI or the device anymore.

Well, this is the case of several SMBus controller and hardware
monitoring device drivers: i2c-viapro, i2c-sis5595, via686a, vt8231,
sis5595... These drivers are PCI drivers, they read PCI registers to
find out the base I/O address of the function they support, and then
fail their probe. There are many other PCI SMBus controller drivers
which succeed their probe but technically don't really need to. I'm not
sure why the AMB device would be any different. How comes that the PCI
devices know the AMB memory address if they aren't related? If the PCI
devices do not own this memory mapping, who does?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
