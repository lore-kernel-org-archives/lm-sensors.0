From: bweber@imsconsultants.com (Bob Weber)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: New i2c driver for ETX-mgx board from Kontron
Message-Id: <1056749667.1873.35.camel@linux.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello. I recently wrote (ported, actually) an i2c driver for the ETX-mgx
board from Kontron. This board uses a Winbond chip for I/O. The I2c
driver bit-bangs a couple I/O pins. 

How do I contribute this to the lm_sensors project? Besides the driver,
I modified Config.in and Makefile in the kernel drivers directory, and
i2c-id.h in the include/linux directory.

- Bob Weber
  R&B Embedded Technologies
  email: bweber@imsconsultants.com
  email: rjweber@ieee.org

