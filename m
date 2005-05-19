From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: Patch for AMD8111 support in 2.8.x
Message-Id: <20031130092346.169a1d6a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC98E59.2050302@penguincomputing.com>
In-Reply-To: <3FC98E59.2050302@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here is a long promised patch to add the support for the AMD8111 back 
> into the i2c-amd756 driver.  This is a patch against CVS.
> 
> The AMD8111 chip has two lm_sensors bus interfaces.  A "classic" i2c 
> interface that matches the amd756 register model to which most 
> motherboards connect the interesting peripherals and a new SMBus 2.x? 
> compliant interface supported by the i2c-amd8111 driver which rarely
> has any devices on it.
> 
> This compiles and loads on my system at home which is a dual Athlon 
> system with a AMD768, but I don't have an Opteron desktop yet to test
> it on...

Will apply.

This would apply to Linux 2.6.0-test11 as well. Do you want me to port
the patch and send it to Greg?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
