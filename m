From: jeff@jdfiles.org (Jeff Sacksteder)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: i2c for Alpha
Message-Id: <200310131613.49854.jeff@jdfiles.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Most (all?) of the code is CPU independant.  You'll need to figure out
> what the I2C/SMBus host is and see if it is supported

I suppose I should start by asking has anyone has built it successfully on any 
64-bit platform- Alpha, Itanium or AMD?

My operating assumption is that I will use the i2c package to patch my kernel, 
replacing the existing i2c code with the current rev. I can then build the 
sensors package to create the user programs to manipulate the hardware.

This mainboard has an Intel chipset of some sort on it- possibly PIIX4. It 
says PCIset on it, not AGPset. Not sure what chipset that is. Actually has 
USB in the chip, though there are no physical bus connections to add devices.
Does the I2C controller live in there(Intel chipset)?

   

