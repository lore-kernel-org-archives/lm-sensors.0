From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: SiS645 driver additions
Message-Id: <Pine.OSF.4.50.0301240608430.6743-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030120002638.A8515@earth.solarsys.net>
In-Reply-To: <20030120002638.A8515@earth.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 23 Jan 2003, Mark M. Hoffman wrote:
>
> E.g. although I have an Asus P4S333 which has 645/961, the south
> bridge claims to be 503 anyway.  I assume this is some kind of
> compatability mode.  Anyway, I can't be sure it's really a 961
> unless I check against the list of compatible north bridges.

The name "sis645" should have been "sis691" then ?

> Yes what this driver really wants is to register against the SMBus
> (sub) device only... and that all the detection and magic enabling
> stuff belongs elsewhere; perhaps in a separate module.

Well, maybe not. Make the magic enabler code another struct pci_driver,
with the current list of ids. Always return with failure from probe,
so we leave no driver associated with the southbridge, but still return
with SMBus part enabled.

Next, call pci_module_init for the SMBus function only.

In the PCI code, we may want to use pci_{request/release}_region, it
will call {release/request}_region with the device's idea of the
resources the driver will use.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
