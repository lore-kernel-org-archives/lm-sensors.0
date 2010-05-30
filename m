From: Ron <ronouel@verizon.net>
Date: Sun, 30 May 2010 06:09:57 +0000
Subject: [lm-sensors] implementation
Message-Id: <loom.20100530T075626-327@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For the uninitiated, how would I implement this patch? 
Asus P5L-VM-1394 motherboard
My kernel is 2.6.32-22 instead of -3
Sensors detect is returning winbond 83627.ehf driver, 
referencing it in etc/modules, but then no sensors are 
detected on the sensors command after reboot.

Would I save the patch as a driver (renamed) with.ehf 
extension, put it into the same driver directory as the 
83267 driver,then reference it in etc/modules? In
other words, is this patch a working stand-alone driver?  




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
