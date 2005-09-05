From: mirko@buholzer.com (Mirko Buholzer)
Date: Mon, 05 Sep 2005 22:52:23 +0000
Subject: [lm-sensors] Random values with pcf8591 chip driver (Now as a new
Message-Id: <431CAFE8.7020008@buholzer.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am using a pcf8591 chip on a linux 2.6.8 Kernel. The Adapter Driver is 
the scx200_i2c. When I do a sensors command I get random values on each 
input channel. Channel 1/2/3 are all set to 0V.

voyage:~# sensors
pcf8591-i2c-1-49
Adapter: NatSemi SCx200 I2C
Chan. 0:    1.28 V
Chan. 1:    1.28 V
Chan. 2:    1.28 V
Chan. 3:    1.28 V
Output:     0.00 V (enabled)

Does anyone have any hints or tricks on how I can proceed with debugging 
and error correction? Or is this a known problem?

Thanks and best Regards,
Mirko

-- 

Mirko Buholzer
mirko@buholzer.com
