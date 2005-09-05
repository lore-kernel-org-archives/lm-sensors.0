From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 05 Sep 2005 23:15:15 +0000
Subject: [lm-sensors] Random values with pcf8591 chip driver (Now as a new
Message-Id: <20050905231512.186be23a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <431CAFE8.7020008@buholzer.com>
In-Reply-To: <431CAFE8.7020008@buholzer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mirko,

> I load the modules as follows:
> 
> modprobe scx200_i2c scl4 sda5
> modprobe pcf8591 input_mode=0

Do you have any other chip on that I2C bus? Maybe the bus isn't working
at all and it's not the PCF8591 fault. How did you come to these values
for scl and sda?

-- 
Jean Delvare
