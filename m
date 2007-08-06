From: Boris Losev <bolo@akontech.ru>
Date: Mon, 06 Aug 2007 08:54:19 +0000
Subject: [lm-sensors] modprobe f71882fg trouble
Message-Id: <46B6E1BB.5090609@akontech.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

I've tried to install lm-sensors for fan monitoring. sensor-detect from 
2.10.4 detected me `Fintek F71882FG/F71883FG Super IO Sensors' and 
writed "modprobe f71882fg". I've tried to modprobe f71882fg, but it was 
unsuccessuful:

root@luck:~/soft/lm_sensors-2.10.4# modprobe f71882fg
FATAL: Module f71882fg not found.

Where should I get module for f71882fg ?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
