From: frank.beesley@aeroflex.com (Frank Beesley)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH 2.6] Add class definition to the elektor bus driver
Message-Id: <421F90D4.2040803@aeroflex.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050225211155.0d258af2.khali@linux-fr.org>
In-Reply-To: <20050225211155.0d258af2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>So I believe what you are asking for is the i2c_elektor driver for the
>>PCF8584 ISA to I2C chip.
>>    
>>
>
>Correct, I just checked and this one actually lacks its class. Patch
>follows.
>
>Greg, can you please apply this one to your tree?
>Thanks.
>
>  
>

The patch works BUT...
The PCF8584 device is a bridge, not a hardware monitor. One of the other 
I2C device types could very well be behind it such as a sound chip. 
Maybe we could add a BRIDGE type or have it as a I2C_CLASS_ALL device. 
This is just a suggestion - like I said, the patch works for me.

Frank


>This patch adds a class definition to the elektor i2c bus driver.
>Without this definition, hardware monitoring chips located on such
>busses cannot possibly be driven.
>
>Signed-off-by: Jean Delvare <khali@linux-fr.org>
>
>--- linux-2.6.11-rc5/drivers/i2c/busses/i2c-elektor.c.orig	2004-12-24 22:33:49.000000000 +0100
>+++ linux-2.6.11-rc5/drivers/i2c/busses/i2c-elektor.c	2005-02-25 20:41:26.000000000 +0100
>@@ -183,6 +183,7 @@
> 
> static struct i2c_adapter pcf_isa_ops = {
> 	.owner		= THIS_MODULE,
>+	.class		= I2C_CLASS_HWMON,
> 	.id		= I2C_HW_P_ELEK,
> 	.algo_data	= &pcf_isa_data,
> 	.name		= "PCF8584 ISA adapter",
>
>
>  
>
