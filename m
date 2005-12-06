From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Dec 2005 21:56:59 +0000
Subject: [lm-sensors] Sensors for ADM1032
Message-Id: <20051206225659.1a5d59ec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <DE69869583DEF2488E588C2908121E100DB839@vlmail1.versalogic.net>
In-Reply-To: <DE69869583DEF2488E588C2908121E100DB839@vlmail1.versalogic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jesse,

> I work in the support department for Versalogic Corporation. We have a
> board called the EBX-12. This board contains the ADM1032 chip that
> should be supported by the lm90 module. The Smbus adapter is
> successfully located but the Analog Devices chip is not successfully
> probed. I have attached my output from "sensors-detect", "i2cdetect" and
> "i2cdump". I know that this device works because I possess a DOS utility
> that detects the internal CPU temperature.

The chip detection failed because of an unusual configuration register
value (at 0x03). Bits 5-0 are tagged as unused in the datasheet and
should always read 0. The default value of this register is 0x00, which
is compatible with this assertion. However, your dump shows a value of
0x15. The only reason I can think of is that, between the power-up and
the probing/dump time, something wrote value 0x15 to address 0x09 (the
write address of register 0x03) of your ADM1032 chip. Maybe the BIOS of
your EBX-12 did that for some reason, or your system initialization
scripts include some misuse of i2cset. I can hardly guess, you'll have
to figure out by yourself.

In the meantime, you can issue the following command before loading the
lm90 driver:
  i2cset -y 0 0x4c 0x09 0x00
You'll need to load the i2c-dev driver beforehand. This will restore
the configuration file value to what the driver expects, so the chip
detection should work again.

Alternatively, you can load the lm90 driver with force_adm1032=0,0x4c,
this should work just fine.

Anyway, I would really suggest that you investigate the cause of that
incorrect configuration register value before resorting to this.

-- 
Jean Delvare

