From: paul@andreassen.com.au (Paul Andreassen)
Date: Sat, 01 Apr 2006 10:34:11 +0000
Subject: [lm-sensors] update to fancontroller
Message-Id: <200604012034.11847.paul@andreassen.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi lm-sensors developers,

Attached is a replacement for 'fancontrol' written in c.  It uses a lot less 
memory and processor resources.

I've also added four more options for the '/etc/fancontrol' file.
    - VERBOSE=1 to show whats going on to screen
    - KEEPON=1 always keep fans moving at least MINSTOP
    - SMOOTH=0-4 use temperature smoother/dampener of +/- SMOOTH for noisy 
readings
    - WORKKICK=0-100,0-255 if cpu working more that 1-100% of the time 
interval add 0-255 to pwm

Thanks,
Paul
-- 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fancontroller.c
Type: text/x-csrc
Size: 22334 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060401/aac2b87c/fancontroller.bin
