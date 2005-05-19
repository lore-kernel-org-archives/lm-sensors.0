From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030805235655.44585fd5.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805222340.3799d819.zdavatz@ywesee.com>
In-Reply-To: <20030805222340.3799d819.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Aug 2003 13:31:27 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Solution #1:
> You stick to 2.7.0 until kernel 2.4.23 is released. This kernel version
> should include the i2c update and solve the problem you had.
make of lm-sensors_2.7.0 gives me:

usses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
kernel/busses/i2c-amd8111.c:25:2: #error Your i2c is too old - i2c-2.7.0 or greater required!
kernel/busses/i2c-amd8111.c: In function `amd8111_access':
kernel/busses/i2c-amd8111.c:238: error: `I2C_CLIENT_PEC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:238: error: (Each undeclared identifier is reported only once
kernel/busses/i2c-amd8111.c:238: error: for each function it appears in.)
kernel/busses/i2c-amd8111.c:298: error: `I2C_SMBUS_BLOCK_PROC_CALL' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:309: error: `I2C_SMBUS_WORD_DATA_PEC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:310: error: `I2C_SMBUS_BLOCK_DATA_PEC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:311: error: `I2C_SMBUS_PROC_CALL_PEC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:312: error: `I2C_SMBUS_BLOCK_PROC_CALL_PEC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c: In function `amd8111_func':
kernel/busses/i2c-amd8111.c:385: error: `I2C_FUNC_SMBUS_BLOCK_PROC_CALL' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c:386: error: `I2C_FUNC_SMBUS_HWPEC_CALC' undeclared (first use in this function)
kernel/busses/i2c-amd8111.c: In function `amd8111_probe':
kernel/busses/i2c-amd8111.c:426: error: `I2C_HW_SMBUS_AMD8111' undeclared (first use in this function)
make: *** [kernel/busses/i2c-amd8111.o] Fehler 1

Any hints?

Thanks
Zeno
