From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: make all error of lm-sensors source
Message-Id: <1053003347.622.63.camel@zrr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I have a ASUS PU-DLS. As Debian User I downloaded:

lm-sensors
lm-sensors-source
i2c-source

First I installed the i2c source that went well.

Then I untared the source into /usr/src/modules 

an then done make all in the lm-sensors directory. That gave me the
following error (after a lot of correct compiling):

t-frame-pointer -I. -Ikernel/include -I/usr/include/linux
-I/usr/src/linux/include   -O2   -c kernel/busses/i2c-amd8111.c -o
kernel/busses/i2c-amd8111.o
kernel/busses/i2c-amd8111.c:25:2: #error Your i2c is too old - i2c-2.7.0
or greater required!
kernel/busses/i2c-amd8111.c: In function `amd8111_access':
kernel/busses/i2c-amd8111.c:238: `I2C_CLIENT_PEC' undeclared (first use
in this function)
kernel/busses/i2c-amd8111.c:238: (Each undeclared identifier is reported
only once
kernel/busses/i2c-amd8111.c:238: for each function it appears in.)
kernel/busses/i2c-amd8111.c:298: `I2C_SMBUS_BLOCK_PROC_CALL' undeclared
(first use in this function)
kernel/busses/i2c-amd8111.c:309: `I2C_SMBUS_WORD_DATA_PEC' undeclared
(first use in this function)
kernel/busses/i2c-amd8111.c:310: `I2C_SMBUS_BLOCK_DATA_PEC' undeclared
(first use in this function)
kernel/busses/i2c-amd8111.c:311: `I2C_SMBUS_PROC_CALL_PEC' undeclared
(first use in this function)
kernel/busses/i2c-amd8111.c:312: `I2C_SMBUS_BLOCK_PROC_CALL_PEC'
undeclared (first use in this function)
kernel/busses/i2c-amd8111.c: In function `amd8111_func':
kernel/busses/i2c-amd8111.c:385: `I2C_FUNC_SMBUS_BLOCK_PROC_CALL'
undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:386: `I2C_FUNC_SMBUS_HWPEC_CALC' undeclared
(first use in this function)
kernel/busses/i2c-amd8111.c: In function `amd8111_probe':
kernel/busses/i2c-amd8111.c:426: `I2C_HW_SMBUS_AMD8111' undeclared
(first use in this function)
make: *** [kernel/busses/i2c-amd8111.o] Error 1

Any idea what I could be doing wrong?

Thanks for your time and help.

Zeno

-- 
Mit freundlichen Gr?ssen / best regards

Zeno Davatz
Strategie & Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.generika.cc
