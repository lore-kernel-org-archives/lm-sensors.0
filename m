From: David Kremer <david.kremer.dk@gmail.com>
Date: Tue, 07 Feb 2012 19:52:33 +0000
Subject: [lm-sensors] [BUG] kernel 3.0.19 LTS and archlinux
Message-Id: <4F318101.7050407@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I cannot load the w83627ehf kernel driver into linux.

$sudo modprobe  w83627ehf
ERROR: could not insert 'w83627ehf': Device or resource busy

fancontrol stopped to work since I upgraded my kernel to the 3.0.19 LTS 
version.

Can you help ?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
