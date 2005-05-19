From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH] i2c-nforce2: add support for support nForce4
Message-Id: <slRwC4bV.1108638647.6808110.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502170010.10368.hfvogt@gmx.net>
In-Reply-To: <200502170010.10368.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Hans-Frieder,

> please find attached a little patch (against CVS of today) that adds
> support for the two SMBusses of the nForce4 in the i2c-nforce2 i2c bus
> driver. The patch is reported to work on the standard nForce4 (i.e.
> non-Ultra, non-SLI), but I expect that it works as well for the other
> nForce4 chipsets, that seem to have the same PCI-id for the SMBus-device.

I'm a bit surprised by the PCI ID for that device (I expected something
greater than those of the nForce3 and ending with a 4 like the other
ones) but if you say it was tested to work, fine with me.

Patch looks good, will apply this evening. This reminded me that we need
to update the i2c-nforce2 documentation to list the newly supported
devices.

Care to prepare a similar patch for Linux 2.6 (against 2.6.11-rc3-mm2
would be fine) and send it to Greg KH (with CC to the sensors list)?

Thanks,
--
Jean Delvare
