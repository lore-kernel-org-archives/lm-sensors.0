From: lepalom@wol.es (Leopold Palomo Avellaneda)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: Problems patchkernel 2.4.22
Message-Id: <200309171142.05680.lepalom@wol.es>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear The Lm Sensors Group,

I hope I write to the correct address. I have read the
http://delvare.free.fr/i2c/ page about the installation of I2C and LM Sensors
2.8.0 in a kernel 2.4.22.

I think that I'm doing something wrong but I'm a bit lost. I have download a
vanilla kernel (2.4.22) and I have patched with your patch as you can see
below, but I have found some errors and I don't know if they are important or
no.

Also, I would like to ask if you know if I2C is compatible with OpenMosix and
RT-Linux.

Best regards,

Leopold Palomo


e01:/usr/src/linux-vanilla/linux-2.4.22# cat
/usr/src/linux-2.4.22-i2c-2.8.0.patch | patch -Np1
patching file drivers/acorn/char/i2c.c
patching file drivers/acorn/char/pcf8583.c
patching file drivers/i2c/Config.in
patching file drivers/i2c/Makefile
patching file Documentation/i2c/dev-interface
patching file Documentation/i2c/i2c-pport
patch unexpectedly ends in middle of line
patch: **** unexpected end of file in patch
