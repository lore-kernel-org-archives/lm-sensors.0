From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: SiS645 driver additions
Message-Id: <Pine.OSF.4.50.0301201034580.6898-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030120002638.A8515@earth.solarsys.net>
In-Reply-To: <20030120002638.A8515@earth.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 20 Jan 2003, Mark M. Hoffman wrote:

> FYI: I tested this on my 645/961 vs. a recent RedHat 2.4.
> Besides adding PCI ids, are there any other changes I
> should make to accomodate Ky?sti's recent work?

Functionally it doesn't matter, but you should avoid all that
pci_find_device in sis645_setup(), a call to pci_module_init has done
the work for you. You can take i2c-amdXX as a sample that got accepted
in Linus's 2.5 tree.

As with any PCI device, the driver should support multiple instances
of a device. Yes, even if it is unlikely. Do it right for i2c-sis645
and we get to copy it for other busses.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
