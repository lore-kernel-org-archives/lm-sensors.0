From: Jay Foster <jayf0ster@roadrunner.com>
Date: Wed, 15 Oct 2014 01:58:22 +0000
Subject: [lm-sensors] ITE 8620E Support
Message-Id: <543DD4BE.9000308@roadrunner.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a new Gigabyte Z97X-UD5H motherboard that has the ITE 8620E 
chip.  I see on the wiki/Devices site that there is no driver for it.  
The notes state that you can try loading the it87 module with the 
force_id=0x8728 option.  I can confirm that this did succeed and sensors 
reports voltages and fan speeds.  I don't know if fan speed control works.

Jay

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
