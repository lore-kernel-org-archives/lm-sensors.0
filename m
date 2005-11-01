From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 01 Nov 2005 09:30:21 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <20051101093000.0b9d91e1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

Sorry for the delay.

> I noticed that the vt8231 driver would not start if the i2c-viapro module
> was installed. I suspect this is because they both try and control the same
> PCI device (the VT8231 chip) and therefore you can only have one installed
> at a time.  If you install the i2c-viapro first then the vt8231 driver never
> gets started and you never get the temp/voltage information.
> 
> The i2c-viapro driver allows the i2c bus to be accessed, so if it is
> installed then I can see the RAMs that are on the bus.  If I remove the
> i2c-viapro and install the vt8231 then I get the voltage and temperature
> information.

There was a similar conflict between i2c-viapro and via686a, but it was
solved in Linux 2.6.10. These drivers do not actually use the PCI
device, they only need it to read some resource values at load time, so
they now release the PCI device when they are done. That way, both
drivers can be loaded in sequence.

A similar change would be required for your vt8231 driver. Just look at
how the via686a driver does in Linux 2.6.14, and do the same. That
should work just fine.

> 1)       Does anyone know what the plan is for combining the vt8231 and
> i2c-viapro modules so that a single module can access both the I2C bus and
> the temperature/voltage information at the same time ?

We were able to fix the issue in a different way (see above) so merging
the drivers won't be necessary. Else we would have had to merge the
i2c-viapro, vt8231, vt1211 and via686a drivers all in one. What a mess!

-- 
Jean Delvare
