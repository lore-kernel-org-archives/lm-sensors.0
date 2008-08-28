From: Kyle <kl@attitia.com>
Date: Thu, 28 Aug 2008 02:16:13 +0000
Subject: [lm-sensors] Why would lm_sensors destroy my KDE environment?
Message-Id: <48B60A6D.3010503@attitia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

after some assistance from Jean on this list, I determined I apparently 
don't need lm_sensors. So I decided to remove it from the system. Using 
the Package Manager, I uninstalled lm_sensors; but it also apparently 
removed half of my KDE environment (yum confirms the same from the CLI) 
removing things like 'kdeaddons' and 'kdeartwork' amongst others.

I don't know what its dependancy is exactly, but it appears to have some 
hook somewhere into KDE. And that dependancy then removes the rest of 
the KDE "stuff" (Tech. Term)

Consequently, I've lost half a day trying to figure out why I could no 
longer 'startx' successfully. This is confirmed by now groupinstall -ing 
KDE  and lm_sensors comes along with it.

WHY would a program designed to monitor low level MB, CPU and fan 
sensors have any dependency on a graphical desktop environment?

-- 
------------------------------------------------------------------------
Kind Regards

Kyle


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
