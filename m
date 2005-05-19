From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: Ticket 1605
Message-Id: <20040306094016.32fd841e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2963.1078536518@www19.gmx.net>
In-Reply-To: <2963.1078536518@www19.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I use the 2.6.2 Kernel and configurate it with menuconfig. The problem
> is that I cannot find the via686a 
> module. The I2C section "I2C Hardware Sensors Chip support" is
> disabled (I cannot enter it) so I cannot select the i2c-viapro and
> i2c-isa ever.
> 
> Do I need a patch for the kernel?

No, all you need is to configure it properly. Make sure that the
following options are set:

Code maturity level options -> Prompt for development and/or incomplete code/drivers
Bus options (PCI, PCMCIA, EISA, MCA, ISA) -> PCI support

I'm pretty sure that you did not enable the first one, at least.

With these options, you should be able to see all bus and chip drivers
while configuring your kernel.

Not that you must *NOT* build both i2c-viapro and via686a into your
kernel, because they are mutually exclusive. In fact, I'd recommend that
you build all bus and chip drivers you may need as modules, until you
know which ones you really need.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
