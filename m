From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Oct 2008 08:48:41 +0000
Subject: Re: [lm-sensors] [PATCH 08/12] i5k_amb: Load automatically on all
Message-Id: <20081015104841.1813155e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011904.12701.37660.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011904.12701.37660.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

Sorry for the late answer.

On Fri, 10 Oct 2008 10:54:15 -0700, Darrick J. Wong wrote:
> On Thu, Oct 09, 2008 at 01:43:53PM +0200, Jean Delvare wrote:
> 
> > sure why the AMB device would be any different. How comes that the PCI
> > devices know the AMB memory address if they aren't related? If the PCI
> > devices do not own this memory mapping, who does?
> 
> On _most_ of my systems it's listed in the ACPI DSDT as one of the
> "system board resources" (SBD1).  Unfortunately, this SBD1 object lists
> a bunch of memory regions and I/O ports, without any indication of what
> each of those regions is for, other than "not for general OS use".  It's
> a little confusing here--the PCI config register has ultimate control
> over where the region lives, but ACPI claims it as part of its own
> system board "do not use" map.

ACPI being weird and inconsistent? Wow, that's totally news to me! ;)

> I suppose it wouldn't be hard to do this with a pci_device_id and
> MODULE_DEVICE_TABLE instead of a direct MODULE_ALIAS.  But since I only
> need the PCI device for a brief moment I'm trying to avoid bloating the
> driver with all the pci_driver support code.

I'm not sure why a pci driver would be more code than a platform driver
looping over pci_get_device(). In fact I suspect it would be less code.
And if we are going to auto-load the driver based on PCI devices, then
it makes a lot of sense for i5k_amb to be a pci driver.

Back to the initial object of the patch: please do not hard-code the
PCI device aliases. No other driver does this. Instead, please define
the IDs in a proper pci_device_id null-terminated array and call
MODULE_DEVICE_TABLE(pci, x) on it. This is easier to read and not
subject to break if the format of the pci aliases ever changes.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
