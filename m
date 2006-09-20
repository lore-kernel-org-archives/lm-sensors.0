From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 20 Sep 2006 18:37:29 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and	minor	problems
Message-Id: <45118A69.9040403@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, Matthias

I checked once again, and it must work - it works for me. So maybe you have 
ignore fan5
in /etc/sensors.conf or you have too old version of lm-sensors.

Please check the fan5 directly in sysfs.

ruik at ruik:/sys/class/hwmon/hwmon0/device$ ls *fan5*
fan5_alarm  fan5_div  fan5_input  fan5_min

Thanks,

regards
Rudolf


