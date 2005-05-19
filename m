From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: bus lines in sensors.conf
Message-Id: <20030716174620.474793c6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The "bus lines" feature described in sensors.conf.eg doesn't seem to
work. Or is it just me? Please, someone else tries and tell me if it
works.

I have the following in my config file:

bus "i2c-1" "NVIDIA display adapter bus 1" "Bit-shift algorithm"

chip "w83781d-i2c-1-2d"

(and the config there). My config is not read. If I write
"w83781d-i2c-*-2d" instead, it works. So it looks like the bus line did
not match my I2C bus. I triple-checked, the line is correct.

Where should I look to see what may be causing the problem?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
