From: sfendt@octagonsystems.com (Sean S Fendt)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: I2C Bit algorithm question
Message-Id: <200402101931.i1AJVAY07933@sfendt.octagonsystems.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

To anyone who may be able to help.

I'm writing drivers for custom hardware on Octagon System's line of embedded 
PCs. ?I'm busy with an I2C bus and chip driver set for our GX1 based products.

A simple (I hope) question:
Why doesn't bit_func() in i2c-algo-bit.c not return with the I2C_FUNC_I2C bit 
set?

My chip driver needs to use i2c_master_send() and i2c_master_recv(), and I 
cant' find any other functionality bit that makes sense. ?If I skip the 
functionality check, it seems to work. ?Did I miss something in the 
documentation, that is am I checking for the wrong functionality bit(s)?

Thanks in advance for any thoughts or suggestions.
-- 
-- Sean Fendt
sfendt@octagonsystems.com
Ph: 303 430 1500 Ext 3048
