From: Mark Wagner <carnildo@gmail.com>
Date: Thu, 07 May 2009 21:14:42 +0000
Subject: [lm-sensors] Is the F71862FG supported?
Message-Id: <31073ef90905071414o4c75a208g1e2efd4a593a7a62@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to the website, the F71862FG chip is supported "since kernel
2.6.29".  However, I'm running 2.6.29 and lm-sensors 3.1.0, and
"sensors-detect" gives the following output:

===============
Found `Fintek F71862FG Super IO Sensors'                    Success!
    (address 0x295, driver `to-be-written')

Driver `to-be-written':
  * ISA bus, address 0x295
    Chip `Fintek F71862FG Super IO Sensors' (confidence: 9)

Note: there is no driver for Fintek F71862FG Super IO Sensors yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.
===============

Is it supported, or not?

-- 
Mark Wagner

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
