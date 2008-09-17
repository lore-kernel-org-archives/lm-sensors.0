From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 17 Sep 2008 22:08:58 +0000
Subject: Re: [lm-sensors] [PATCH] i2c: add support for MAX1618 in MAX1619
Message-Id: <20080917150858.9243ec48.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080916133542.GA2072@www.tglx.de>
In-Reply-To: <20080916133542.GA2072@www.tglx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Sep 2008 15:35:42 +0200
Sebastian Siewior <bigeasy@linutronix.de> wrote:

> +	return sprintf(buf, "%d\n", TEMP_FROM_REG((data->kind = max1618) ?
> +						data->remote : data->local));

oh dear.

#define TEMP_FROM_REG(val)	((val & 0x80 ? val-0x100 : val) * 1000)

Imagine how truly awful the code generation must be here.

Look:

--- a/drivers/hwmon/max1619.c~a
+++ a/drivers/hwmon/max1619.c
@@ -75,8 +75,15 @@ I2C_CLIENT_INSMOD_2(max1619, max1618);
  * Conversions and various macros
  */
 
-#define TEMP_FROM_REG(val)	((val & 0x80 ? val-0x100 : val) * 1000)
-#define TEMP_TO_REG(val)	((val < 0 ? val+0x100*1000 : val) / 1000)
+static int TEMP_FROM_REG(int val)
+{
+	return ((val & 0x80 ? val-0x100 : val) * 1000);
+}
+
+static int TEMP_TO_REG(int val)
+{
+	return (val < 0 ? val+0x100*1000 : val) / 1000;
+}
 
 /*
  * Functions declaration
_

          text    data     bss     dec     hex filename
before:   3927    1148      28    5103    13ef drivers/hwmon/max1619.o
after:    3743    1148      28    4919    1337 drivers/hwmon/max1619.o


That's a 6% reduction in the number of instructions in the whole driver!

Not only that, it generates nicer-to-read code and it fixes the bugs
which will occur if someone calls one of these macros with an
expression which has side-effects.


Macros suck, suck, suck, suck and the kernel is just littered with the
stupid things in places where they were completely unnecessary.



argh.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
