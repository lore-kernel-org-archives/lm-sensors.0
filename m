From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: parport driver
Message-Id: <20050417222104.1382f2db.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andreas,

> So I tried to load the following modules: i2c_core, i2c_algo_bit,
> i2c_pport, i2c_dev, i2c_sensor, pcf8574.
> Should I be able to se my pcf8574 chip that is hooked up on my
> parallel port now? Cause I can not! Do I have to consider cables
> (length and others) or have I done anything else wrong? Some hints on
> trouble shooting would be apreciated.

First thing to try is to load i2c-algo-bit with bit_test=1. This will
test the lines when you load i2c-pport. If it fails, then you have a
wiring issue, most probably. The debug message should tell you where.

If the i2c-pport driver loads, try i2cdetect on the bus. This will give
you an idea of whether the bus works as intended or not.

Hope that helps,
-- 
Jean Delvare
