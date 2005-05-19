From: emak@free.fr (Boris de Laage)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Can't compile.
Message-Id: <1004795203.3be3f5436c8d7@imp3-1.free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I can't compile the I2C modules: 

gcc -I/usr/src/linux/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE
-fomit-frame-pointer -DEXPORT_SYMTAB -c kernel/i2c-core.c -o kernel/i2c-core.o
In file included from /usr/src/linux/include/linux/module.h:21,
                 from kernel/i2c-core.c:25:
/usr/include/linux/modversions.h:1:2: #error Modules should never use
kernel-headers system headers,
/usr/include/linux/modversions.h:2:2: #error but rather headers from an
appropriate kernel-source package.
/usr/include/linux/modversions.h:3:2: #error Change -I/usr/src/linux/include (or
similar) to
/usr/include/linux/modversions.h:4:2: #error -I/lib/modules/$(uname
-r)/build/include
/usr/include/linux/modversions.h:5:2: #error to build against the
currently-running kernel.
