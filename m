From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: about tempX information
Message-Id: <20021202210217.4ee69f94.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DEA8D23.7080002@fis.ub.edu>
In-Reply-To: <3DEA8D23.7080002@fis.ub.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've installed lm-sensors 2.6.5 and I use i2c-isa and via686a modules.
> 
> I get:
> 
> S01:/proc# cat /proc/sys/dev/sensors/via686a-isa-6000/temp2
> 59.9 55.1 41.3
> S01:/proc# cat /proc/sys/dev/sensors/via686a-isa-6000/temp1
> 44.9 39.9 45.3
> S01:/proc# cat /proc/sys/dev/sensors/via686a-isa-6000/temp3
> 65.4 59.9 26.4
> 
> 
> What is the meaning of thins numbers ?

As a human, you are not supposed to read these numbers by yourself. Run
"sensors" (and "sensors -s" before this) and it will tell you everything
you want to know.

(If you still want to know: these are, in this order, the critical
temperature, the hysteresis temperature and the current temperature for
each temperature probe, in degrees Celcius.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
