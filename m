From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: pwmconfig
Message-Id: <20030721154510.7f5b3348.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721115123.11b859d1.khali@linux-fr.org>
In-Reply-To: <20030721115123.11b859d1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> BTW, I think I'll give a try to FanSpeed. That way I'll know what my
> hardware supports.

OK, this was an interesting experience I guess. FanSpeed 4.08 detected
almost everything accurately, even some things I didn't get first with
lm_sensors (and some things lm_sensors just doesn't do, such as the HDD
temperature, 44 deg C). It detects two fan regulators, just as
lm_sensors do, and they don't work, just as with lm_sensors. So that
must be my hardware not supporting it, period.

But at least this doesn't break my temperature readings.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
