From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 19 Oct 2005 22:36:03 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <4356AE1F.2080206@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I noticed that the vt8231 driver would not start if the i22-viapro
> module was installed. I suspect this is because they both try and
> control the same PCI device (the VT8231 chip) and therefore you can only
> have one installed at a time.  If you install the i2c-viapro first then
> the vt8231 driver never gets started and you never get the temp/voltage
> information.

Yes. Correct. This should be fixed in recent kernels. (from 2.6.11)

> 1)       Does anyone know what the plan is for combining the vt8231 and
> i2c-viapro modules so that a single module can access both the I2C bus
> and the temperature/voltage information at the same time ?

Yes see above. It should be good to free the vt8231 from usage of PCI device too:
Like done in this patch:
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-February/010440.html

> 
> 2)       Does anyone know the CORRECT information for the scaling
> coefficients for the temperature and voltage ?

No, please ask the manufacturer of motherboard.

Aaron,
Have you some more recent version of your driver somewhere (seems you do not)?  I think it would help people if we could get it into mainline.
Thanks,

Regards
Rudolf
