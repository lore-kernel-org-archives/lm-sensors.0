From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 11 Apr 2006 16:29:21 +0000
Subject: [lm-sensors] scx200_acb: Use PCI I/O resource when appropriate
Message-Id: <443BD961.3050807@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060331230309.GE17261@cosmic.amd.com>	<LYRIS-4270-45297-2006.04.11-06.08.18--jordan.crouse#amd.com@whitestar.amd.com> <20060411161942.GB13334@cosmic.amd.com>
In-Reply-To: <20060411161942.GB13334@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Jean Delvare <khali@linux-fr.org>, info-linux@ldcmail.amd.com, BGardner@Wabtec.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hello all,

> And so our dirty laundry is out... :)
> 
> We have a sad history here - back a few parts, we had less descriptors to 
> describe IO, so we opted to combine several components under the same PCI
> header to save resources.  So the bottom line is that we have at least three
> desirable devices (timers, GPIO pins and the SMBus) that all lay claim to
> the same device.  So a proper PCI header would be difficult to implement - 
> either we would have 1 device that registered with three different
> subsystems, or we would have three individual devices, the first of which
> would get the PCI resources to the ruin of the others.

Well we had the problem with i2c-viapro and vi686a. Best solution was
to fail from the probe function - like this:

         /* Always return failure here.  This is to allow other drivers to bind
          * to this pci device.  We don't really want to have control over the
          * pci device, we only wanted to read as few register values from it.
          */
         return -ENODEV;

release_region:
         release_region(vt596_smba, 8);
         return error;
}

> 
> So this is the solution I came up with, for older parts.  For newer parts,
> I sat the BIOS guys down in a room with a guy name Bruno, and they agreed
> to make a separate header for each component.

This is good ;)

Regards
Rudolf

