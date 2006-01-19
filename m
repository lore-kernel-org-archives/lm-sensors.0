From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 Jan 2006 03:34:10 +0000
Subject: [lm-sensors] i82875p: OOPS with latest EDAC and Bluesmoke
Message-Id: <20060119033410.GA17365@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060119021924.GA13729@khazad-dum.debian.net>
In-Reply-To: <20060119021924.GA13729@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:

* Henrique de Moraes Holschuh <hmh at debian.org> [2006-01-19 00:19:25 -0200]:
> I've just tried to get 2.6.15.1 going with both the latest EDAC and
> Bluesmoke patches available at sf.net, and no go.  Both caused exactly the
> same OOPS.  The test platform is an Intel D875PBZ motherboard with 1GB ECC
> RAM, and their latest BIOS.

Err... wrong mailing list?  This one (lm-sensors) doesn't deal with that.

> The problem showed up when trying to enable EDAC for i82875P.  For the
> record, Bluesmoke version 2005-11-17 works fine on this hardware, so it is a
> regression bug.
> 
> I think the oops has to do with the weirdness needed for i82875P support. As
> some may recall, Intel "strongly suggests" that the i82875P secondary PCI
> config space device (primary device is 0:0:0.0, secondary device is 0:0:6.0)
> be hidden.  This means that the i82875P EDAC driver must enable the hidden
> 0:0:6.0 PCI device to access the data it needs.  Also, since the device is
> *hidden* by the BIOS, but it is still there, the resources are marked as
> reserved by the BIOS (at least Intel is consistent :-) ).  
> 
> So, users of "properly Intel-compliant BIOS" i82875P mobos get:
> 
> PCI: Unable to reserve mem region #1:1000 at fecf0000 for device 0000:00:06.0
> which is fine, really: it is *supposed* to be reserved, or something that
> doesn't know about the hidden PCI device might trample over it.  I wish we
> could avoid trying to reserve that memory if it is already reserved, to
> remove this misleading message.
> 
> So far so good.  I think there is a minor bug somewhere in the i82875P
> device activation code, in that lspci does not show the 0:0:6.0 device
> unless told to probe the hardware directly.  IMHO we are still not doing
> something we should, as the kernel is not being told to add that device to
> the tree.

The best place to "unhide" a PCI device is in drivers/pci/quirks.c.  Then,
(1) the device will get added to the kernel tables properly and show up
in 'lspci', and (2) the driver itself will be much simpler, using the
normal PCI ID registration.

Several I2C/SMBus drivers do it that way; OEMs love to hide those.

> Now, with the latest EDAC and bluesmoke releases, MC somehow gets confused
> and MC tries to handle the 0:0:0.0 device to the i82875P driver *twice*.
> This triggers some nasty bug that causes an immediate OOPS and kills the
> kernel very dead indeed.
> 
> The messages before the OOPS happens are a *repeat* of the PCI error above
> about not being able to reserve the mem region, directly followed by
> "i82875P init one" (i.e. it is being initialized *again*...).  Then, MC
> issues a new (non-repeated) message complaining that "82875P already
> assigned 0000:00:00.0, and immediately after that, the kernel OOPSes.
> 
> I didn't do a full OOPS transcription, but it blows up inside i82875_probe1
> which calls pci_release_regions, which oopses.
> 
> I don't exactly have the time to track down that bug and fix it right now,
> but I thought I should give you guys a head's up in case some of you have an
> idea of what could be wrong.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


