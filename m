From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 22 Mar 2006 22:12:26 +0000
Subject: [lm-sensors] [PATCH] w83627ehf: Add alarms support
Message-Id: <4421CBCA.5050907@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060322220625.1b389b02.khali@linux-fr.org>
In-Reply-To: <20060322220625.1b389b02.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Here is a patch adding alarms support to the w83627ehf driver. It
> applies on top of Yuan Mu's patch converting the driver to use arrays
> of attributes [1] and Rudolf Marek's patch adding voltage inputs
> support [2]. Owners of W83627EHF/EHG chips are invited to give it
> testing and report how it works. Note that you'll need lm_sensors2 CVS
> on the user-space side.

I added to CVS sensors.conf.eg some voltage formulas too.


> 
> [1] http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-w83627ehf-use-attr-arrays.patch
> [2] http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-w83627ehf-add-voltages.patch

Much more is needed:

Order:
1 hwmon-allow-sensor-attr-arrays.patch
2 hwmon-convert-semaphores-to-mutexes.patch
5 hwmon-w83627ehf-add-alarms.patch
4 hwmon-w83627ehf-add-voltages.patch
3 hwmon-w83627ehf-use-attr-arrays.patch

Some other drivers will fail to patch but it does not matter.

I did the testing except the fan4/fan5 which look OK anyway.
(I did not try the voltage alarms, I assume you did not changed the numbers)

There is only one problem:

> +	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 10),
> +	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 11),
10 and 11 needs to be swapped.

Thank you for the patch.

regards
Rudolf


