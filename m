From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: SiS645 driver additions
Message-Id: <20030120184356.A23898@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030120002638.A8515@earth.solarsys.net>
In-Reply-To: <20030120002638.A8515@earth.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Ky?sti M?lkki <kmalkki@cc.hut.fi> [2003-01-20 11:06:56 +0200]:
> On Mon, 20 Jan 2003, Mark M. Hoffman wrote:
> 
> > FYI: I tested this on my 645/961 vs. a recent RedHat 2.4.
> > Besides adding PCI ids, are there any other changes I
> > should make to accomodate Ky?sti's recent work?
> 
> Functionally it doesn't matter, but you should avoid all that
> pci_find_device in sis645_setup(), a call to pci_module_init has done
> the work for you. You can take i2c-amdXX as a sample that got accepted
> in Linus's 2.5 tree.

OK, I understand.  Some of that I can't avoid though.  The BIOS tends
to hide the device I really want; so I have to flip a magic bit then
search for it.

> As with any PCI device, the driver should support multiple instances
> of a device. Yes, even if it is unlikely. Do it right for i2c-sis645
> and we get to copy it for other busses.

I'll see what I can do...

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
