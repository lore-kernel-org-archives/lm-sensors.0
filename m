From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Mon, 05 May 2014 17:13:11 +0000
Subject: [lm-sensors] coretemp.0 folder contents changed
Message-Id: <5367C6A7.5020008@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Linux Kernel <linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Hi,

for kernel : 3.15.rc3 .

Is there any change in the coretemp? Previously we used to see, tempx 
data (like temp2_input, temp2_max etc.)
/sys/devices/platform/coretemp.0/.

Now We don't see them. Now we have to go 
/sys/devices/platform/coretemp.0/hwmon/hwmon?/ to get these values.

Thanks,
Srinivas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
