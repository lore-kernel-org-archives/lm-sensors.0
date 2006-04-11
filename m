From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 11 Apr 2006 20:42:50 +0000
Subject: [lm-sensors] scx200_acb: Use PCI I/O resource when appropriate
Message-Id: <20060411224250.9f2b2ead.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060331230309.GE17261@cosmic.amd.com>
	<LYRIS-4270-45297-2006.04.11-06.08.18--jordan.crouse#amd.com@whitestar.amd.com>
	<20060411161942.GB13334@cosmic.amd.com>
	<443BD961.3050807@sh.cvut.cz>
In-Reply-To: <443BD961.3050807@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@sh.cvut.cz>, Jordan Crouse <jordan.crouse@amd.com>
Cc: info-linux@ldcmail.amd.com, BGardner@Wabtec.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Rudolf, Jordan,

> Well we had the problem with i2c-viapro and vi686a. Best solution was
> to fail from the probe function - like this:
> 
>          /* Always return failure here.  This is to allow other drivers to bind
>           * to this pci device.  We don't really want to have control over the
>           * pci device, we only wanted to read as few register values from it.
>           */
>          return -ENODEV;
> 
> release_region:
>          release_region(vt596_smba, 8);
>          return error;
> }

True, but we were lucky. You can only do that if you don't need to
access the PCI configuration space during run-time (after the
initialization step) in either driver "sharing" the PCI device. The
i2c-viapro driver qualified, but for example we couldn't do that for
the i2c-i801 driver (block transactions in I2C mode require PCI
configuration register access.)

So depending on the exact hardware context, Jordan may or may not be
able to use the same trick. The other (cleaner) solution is to have an
additional module which registers the PCI device and exports some kind
of interface for the other modules to access the parts they need - but
this requires extra code and makes things much more complex too.

-- 
Jean Delvare

