From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: device matching
Message-Id: <20021024182809.0e939ee4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <011f01c27b57$49a53450$5100a8c0@office>
In-Reply-To: <011f01c27b57$49a53450$5100a8c0@office>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> 1* CPU temp is always higher that SYS temp. PS temp is usually bewteen
> CPU and SYS temp.

I have to correct myself here. See my own temps:
M/B Temp:    +35?C  (limit =  +42?C, hysteresis =  +40?C)        
CPU Temp:  +50.4?C  (limit =  +60?C, hysteresis =  +56?C)        (beep)
P/S Temp:  +30.0?C  (limit =  +42?C, hysteresis =  +40?C)        
The CPU has the higher temperature, but M/B is hotter than P/S. So, take
care not to conclude too fast.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
