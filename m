From: hoyt@cavtel.net (Hoyt)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Winbond W83782D
Message-Id: <200206151303.12037.hoyt@cavtel.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm using a Tiger MPX (S2466) http://www.tyan.com/products/html/tigermpx.html

It uses a Winbond W83782D chip.

I haven't had any luck with sensors-detect; the detection would lock up.

But I was able to get some success by following what I found at 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.1/1519.html

I see:

w83627hf-i2c-1-2c
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
 . . . and the readings . . .

I'm not sure how to set up /etc/modules.conf. Any advice?


Thanks,

Hoyt
