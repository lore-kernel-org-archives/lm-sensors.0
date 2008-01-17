From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Thu, 17 Jan 2008 20:38:57 +0000
Subject: [lm-sensors] [Bug 9514] it87 probe failure in 2.6.24-rc -- what now?
Message-Id: <200801171339.00887.bjorn.helgaas@hp.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: bugme-daemon@bugzilla.kernel.org, Shaohua Li <shaohua.li@intel.com>, Mike Houston <mikeserv@bmts.com>, Adrian Bunk <bunk@stusta.de>, Elvis Pranskevichus <el@prans.net>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Adam Belay <ambx1@neo.rr.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

Where are we with this problem?
(http://bugzilla.kernel.org/show_bug.cgi?id=9514)

I think (correct me if I'm misremembering), we started reserving more
motherboard resources, and then we started seeing conflicts between
some of those resources and something it87 needs.

We can't fix this by reserving fewer motherboard resources.  We
really want to reserve *all* the motherboard resources to prevent
conflicts.

We could fiddle with the PNP system driver to make it ignore
resources that overlap other resources (http://lkml.org/lkml/2007/12/9/186).
The system device has 0x290-0x29f and 0x290-0x294 ranges, and this
patch ignores the second.  I'm reluctant to do this because it just
seems like a hack in the system driver.  Also, Mike Houston found
that Windows lists both, and I think we should do the same
(http://lkml.org/lkml/2007/12/9/170).

The second option I see is to use my patch
(http://bugzilla.kernel.org/attachment.cgi?id=14267&action=3Dview)
to make it87 request only the ports it uses.

Jean rightly believes a platform device should reflect all the ports
a chip decodes, and my patch goes the other direction.  But in an
ACPI system, the BIOS has the responsibility of listing all the address
space that is in use, so I don't think we really should *have* platform
devices unless they come from ACPI.  Since we don't know how to get the
it87 functionality the "correct" way (i.e., via some ACPI device),
we have to kludge things a bit, and I think a reasonable start is to
rely on ACPI to tell us what address space is in use and change the
it87 driver to request only the ports it uses.

Whatever we do, it'd be nice to have a fix in 2.6.24, and I think my
patch is the least evil for now.

Possibly the situation could actually be improved slightly by removing
the platform device stuff from it87 altogether, at least for ACPI
systems, though I think this is a post-2.6.24 question.

Jean, you own the it87 driver, so do you want to chime in?  Any other
possibilities for a 2.6.24 fix?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
