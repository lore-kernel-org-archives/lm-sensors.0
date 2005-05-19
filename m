From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: SiS645 driver additions
Message-Id: <Pine.OSF.4.50.0301211225530.28783-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030120002638.A8515@earth.solarsys.net>
In-Reply-To: <20030120002638.A8515@earth.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 20 Jan 2003, Mark M. Hoffman wrote:

> * Ky?sti M?lkki <kmalkki@cc.hut.fi> [2003-01-20 11:06:56 +0200]:
> > Functionally it doesn't matter, but you should avoid all that
> > pci_find_device in sis645_setup(), a call to pci_module_init has done
> > the work for you. You can take i2c-amdXX as a sample that got accepted
> > in Linus's 2.5 tree.
>
> OK, I understand.  Some of that I can't avoid though.  The BIOS tends
> to hide the device I really want; so I have to flip a magic bit then
> search for it.

It looks to me, that the SMBus device has its own PCI_ID,
and test for southbridge is only required if SMBus is disabled.

I don't get the point of testing the north bridge type,
if the SMBus is somewhere else.

I don't know if the PCI subsystem cares, but I get the impression
that i2c-sis645 driver is not registered to control the SMBus
device, but the device listed in sis645_ids.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
