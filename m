From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710085158.42e68c95.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I followed your advice and compiled again with the CVS-Version, both i2c and lm-sensors.

Before I done make I done cvs update -d

i2c goes grest but lm-sensors gives me:

kernel/busses/i2c-nforce2.c: In function `nforce2_access':
kernel/busses/i2c-nforce2.c:154: `I2C_CLIENT_PEC' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:154: (Each undeclared identifier is reported only once
kernel/busses/i2c-nforce2.c:154: for each function it appears in.)
kernel/busses/i2c-nforce2.c:218: `I2C_SMBUS_BLOCK_PROC_CALL' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:233: `I2C_SMBUS_WORD_DATA_PEC' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:234: `I2C_SMBUS_BLOCK_DATA_PEC' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:235: `I2C_SMBUS_PROC_CALL_PEC' undeclared (first use in this function)
kernel/busses/i2c-nforce2.c:236: `I2C_SMBUS_BLOCK_PROC_CALL_PEC' undeclared (first use in this function)
make: *** [kernel/busses/i2c-nforce2.o] Error 1
make: *** Waiting for unfinished jobs....
kernel/busses/i2c-ali1535.c:538: unknown field `owner' specified in initializer
kernel/busses/i2c-ali1535.c:538: warning: missing braces around initializer
kernel/busses/i2c-ali1535.c:538: warning: (near initialization for `ali1535_adapter.name')
kernel/busses/i2c-ali1535.c:538: warning: initialization makes integer from pointer without a cast
kernel/busses/i2c-ali1535.c:538: initializer element is not computable at load time
kernel/busses/i2c-ali1535.c:538: (near initialization for `ali1535_adapter.name[0]')
kernel/busses/i2c-ali1535.c:539: initializer element is not constant
kernel/busses/i2c-ali1535.c:539: (near initialization for `ali1535_adapter.name')
make: *** [kernel/busses/i2c-ali1535.o] Error 1

Any ideas what I am doing wrong or what I could correct in the Makefile?

Thanks for your time and help.

Zeno
