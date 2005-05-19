From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: max1617a
Message-Id: <20040509133827.04734a7e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexey,

> I have an notebook
> "SAMSUNG NV5000" with linux it working pritty well bat I can't use
> termo-chip "max1617a" for processor. With Windows it was recogniset as
> max1617a and from Linux with sensors-detect as max6650 :-) modul
> max6650 starts and show fan-speed :-)  bat i dont hawe fan speed chip,
> and wan iwen fan dont working it show prity hi speed. modul adm1201 or
> somting like this, wich supous to work with max1617a can't rekognise
> it, at all. if you hawe, a time please halp me or jast tell me wat i
> need to chenge.

The MAX1617A and MAX6650 are completely different chips, they can't even
have the same address on the I2C bus. So this cannot be a misdetection,
you have probably both on your laptop.

Please provide the following information:

1* Version of lm_sensors you are running.

2* Version of the Linux kernel you are running.

3* Full output of sensors-detect. The "script" tool may help. Don't
forget to unload all chip drivers (I guess max6650 and possibly eeprom)
before running sensors-detect.

> please excuse me with my english, i jast began to lern it.

I can see that ;) No problem.

-- 
Jean Delvare
http://khali.linux-fr.org/
