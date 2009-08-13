From: clubsoda@hushmail.com
Date: Thu, 13 Aug 2009 21:09:41 +0000
Subject: [lm-sensors] w83781d - Unable to set fan1_div
Message-Id: <20090813210941.8E3F9B0048@smtp.hushmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Board is ASUS P4T requiring i2c-i801 and w83781d modules, with 
sensors reporting as99127f-i2c-0-2d.  Tried setting fan1_div, 
fan2_div and fan3_div to 8 in sensors3.conf and sensors.conf but 
even after reboot div=2 so the minimum reportable fan speed is 2657 
RPM.

BIOS is not too great at displaying low fan speeds either but ASUS 
Probe in Windows goes down to 900 RPM or lower so the hardware is 
capable.

Xubuntu Karmic alpha 3 system plus all updates.
sensors, libsensors v3.0.2
kernel 2.6.31-5-generic

Thanks in advance for any assistance.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
