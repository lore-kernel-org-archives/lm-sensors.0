From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: device matching
Message-Id: <20021024150619.27295291.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <011f01c27b57$49a53450$5100a8c0@office>
In-Reply-To: <011f01c27b57$49a53450$5100a8c0@office>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I want to know which value is linked with which device.
> The guess is easy for a fan. When I cease a fan, the fan?'s value
> will be reported 0. But it is difficult for a temperature,
> and more difficult for a voltage.
> 
> Please tell me which value is connected with which pin of W83627HF.
> Or tell me how can I find the pin.
It's not that easy. In fact, it depends on the MB manufacturer's
choices.

Suggested ways for voltages:
1* You usually have CPU voltages first, then the
+3.3V/+5V/+12V/-12V/-5V. You should be able to easily isolate these five
ones and few should be left.
2* For the ones left, look at the values repported by your BIOS and
compare.

Suggested ways for temperature:
1* CPU temp is always higher that SYS temp. PS temp is usually bewteen
CPU and SYS temp.
2* Look at the values reported by your BIOS, and compare with what
lm_sensors reports.

Anyway, if you have a correct sensors.conf in /etc, most values should
be already correctly labelled (but again, we can't prevent manufacturers
from connecting the probes the way they want).


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
