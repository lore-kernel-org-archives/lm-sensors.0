From: paul@andreassen.com.au (Paul Andreassen)
Date: Fri, 12 May 2006 05:34:19 +0000
Subject: [lm-sensors] [PATCH] prog/pwm/fancontrol
Message-Id: <200605121534.19346.paul@andreassen.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Attached is a patch for prog/pwm/fancontrol to remove the use of awk, cut and 
cat from the main loop.

Attached also is a replacement for prog/pwm/fancontrol written in c.  It uses 
a lot less memory and processor resources while still using the 
same /etc/fancontrol file.

Four additional options for the /etc/fancontrol file:
    - VERBOSE=1 to display current values
    - KEEPON=1 always keep fans moving at least MINSTOP
    - SMOOTH=0-4 temperature filtering of +/- SMOOTH for noisy readings
    - WORKKICK=0-100,0-255 if cpu working more that 1-100% of the time 
interval add 0-255 to pwm

Paul
-- 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fancontrol.patch
Type: text/x-diff
Size: 3433 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060512/4aa32fbb/fancontrol-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fancontroller.c
Type: text/x-csrc
Size: 22334 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060512/4aa32fbb/fancontroller-0001.bin
