From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: SAA1064 driver
Message-Id: <200307082233.13758.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

the SAA1064 is an I2C-driver to drive LED-Displays (4-digit with dots). I 
have written a user-space program to access it through i2c-dev 
(http://www.magoa.net/linux/index.php?view=kathrein) but I'm thinking about 
writing an lmsensors chip-driver for it. I'd like to know if that driver 
would be of any use to you if it's finished?

Greetings,
Sascha Volkenandt
