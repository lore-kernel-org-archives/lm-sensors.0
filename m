From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: SiS645 driver additions
Message-Id: <20030123220006.A22947@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030120002638.A8515@earth.solarsys.net>
In-Reply-To: <20030120002638.A8515@earth.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Ky?sti M?lkki <kmalkki@cc.hut.fi> [2003-01-21 12:39:44 +0200]:
> On Mon, 20 Jan 2003, Mark M. Hoffman wrote:
> 
> > * Ky?sti M?lkki <kmalkki@cc.hut.fi> [2003-01-20 11:06:56 +0200]:
> > > Functionally it doesn't matter, but you should avoid all that
> > > pci_find_device in sis645_setup(), a call to pci_module_init has done
> > > the work for you. You can take i2c-amdXX as a sample that got accepted
> > > in Linus's 2.5 tree.
> >
> > OK, I understand.  Some of that I can't avoid though.  The BIOS tends
> > to hide the device I really want; so I have to flip a magic bit then
> > search for it.
> 
> It looks to me, that the SMBus device has its own PCI_ID,
> and test for southbridge is only required if SMBus is disabled.
> 
> I don't get the point of testing the north bridge type,
> if the SMBus is somewhere else.

E.g. although I have an Asus P4S333 which has 645/961, the south
bridge claims to be 503 anyway.  I assume this is some kind of
compatability mode.  Anyway, I can't be sure it's really a 961
unless I check against the list of compatible north bridges.

> I don't know if the PCI subsystem cares, but I get the impression
> that i2c-sis645 driver is not registered to control the SMBus
> device, but the device listed in sis645_ids.

Yes what this driver really wants is to register against the SMBus
(sub) device only... and that all the detection and magic enabling
stuff belongs elsewhere; perhaps in a separate module.

MDS first suggested separate modules; I should have taken his advice.

i2c-sis645-pci-fixup.c?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
