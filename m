From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 30 Nov 2008 15:56:52 +0000
Subject: Re: [lm-sensors] Special handling of SiS south bridges in
Message-Id: <20081130155652.GF28501@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-11-30 13:47:40 +0100]:
> Hi Mark,
> 
> Now that support for Linux 2.4 has been dropped from sensors-detect, I
> am looking at possible clean-ups. One thing I am curious about is the
> handling of SiS south bridges. I remember that these required special
> handling for Linux 2.4 because they were all showing up with the same
> PCI ID. However I am surprised that we still have the following code
> even for Linux 2.6, where I seem to understand that PCI quirks in the
> kernel are taking care of revealing the actual device:
> 
> sub adapter_pci_detection_sis_96x
> {
> 	# Add the appropriate entries to @pci_adapters
> 	if (exists $pci_list{'1039:0016'}) {
> 		push @pci_adapters, @pci_adapters_sis96x;
> 	} elsif (exists $pci_list{'1039:0008'}) {
> 		push @pci_adapters, @pci_adapters_sis5595;
> 	}
> }
> 
> Can this go away now?

Very early 2.6.x did not yet have the SiS quirks code... so this was at one
time still necessary.

But yes, IMO this can go away now.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
