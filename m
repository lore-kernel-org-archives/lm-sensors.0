From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 12 Aug 2005 22:38:51 +0000
Subject: [lm-sensors] How to changing config values of sensor (LM77) ?
Message-Id: <20050812223844.1ecbab40.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42FD064F.8050308@infovia.com.ar>
In-Reply-To: <42FD064F.8050308@infovia.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Beat,

> How is it possible to change config values for LM77 driver?
> Is this only possible with userspace support?
> What I want to do is to change the critical temp of the sensor for
> example.

echo 60000 > /sys/bus/i2c/devices/0-0048/temp1_crit

(or similar) should do the trick (setting the critical limit to 60
degrees C). Usually this is done using /etc/sensors.conf and "sensors
-s" but as the lm77 driver lacks user-space support at the moment,
writing to /sys directly is the only way.

-- 
Jean Delvare
