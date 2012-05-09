From: ACCART Julien <bigjulius@free.fr>
Date: Wed, 09 May 2012 23:08:26 +0000
Subject: [lm-sensors] asus_atk0110 doesn't work on motherboard P8B WS
Message-Id: <4FAAF8EA.3070202@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm trying to get sensors informations on Asus P8B WS but it doesn't work.

kernel : 3.2.15
lm-sensors : 3.1.2

When I launch :
modprobe asus_atk0110
the module loads successfully (no message in dmesg and it is visible in 
lsmod) but it doesn't create anything in /sys/class/hwmon/

Could you help me?

Thanks.

-- 
Julius


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
