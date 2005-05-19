From: sesshoumaru@altern.org (Sesshoumaru)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: SMbus problem ?
Message-Id: <20030602222815.14c7b37f.sesshoumaru@altern.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello !

I have a few problems with lm_sensors. I installed i2c-2.7.0 packages
and after that i do a depmod -a.
But when i compile lm_sensors i have this errors at make step :

[root@calculus:/tmp/lm_sensors-2.7.0]# make
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.20/build/include   -O2   -c kernel/busses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
kernel/busses/i2c-amd8111.c:25:2: #error Your i2c is too old - i2c-2.7.0 or greater required!
kernel/busses/i2c-amd8111.c: In function `amd8111_access':
kernel/busses/i2c-amd8111.c:238: `I2C_CLIENT_PEC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:238: (Each undeclared identifier is reported only once
kernel/busses/i2c-amd8111.c:238: for each function it appears in.)
kernel/busses/i2c-amd8111.c:298: `I2C_SMBUS_BLOCK_PROC_CALL' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:309: `I2C_SMBUS_WORD_DATA_PEC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:310: `I2C_SMBUS_BLOCK_DATA_PEC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:311: `I2C_SMBUS_PROC_CALL_PEC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:312: `I2C_SMBUS_BLOCK_PROC_CALL_PEC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c: In function `amd8111_func':
kernel/busses/i2c-amd8111.c:385: `I2C_FUNC_SMBUS_BLOCK_PROC_CALL' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:386: `I2C_FUNC_SMBUS_HWPEC_CALC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c: In function `amd8111_probe':
kernel/busses/i2c-amd8111.c:426: `I2C_HW_SMBUS_AMD8111' undeclared (first use in this function)
make: *** [kernel/busses/i2c-amd8111.o] Error 1

However i have installed i2c-2.7.0.

An ideas ?

Regards

-- 
La modestie est au m?rite ce que les ombres 
sont aux figures dans un tableau: elle lui 
donne de la force et du relief.
