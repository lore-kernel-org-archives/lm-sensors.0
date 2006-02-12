From: paul@andreassen.com.au (Paul Andreassen)
Date: Sun, 12 Feb 2006 13:00:17 +0000
Subject: [lm-sensors] update for fancontrol
Message-Id: <200602122300.18074.paul@andreassen.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi lm-sensors developers,

I finally decided to do something about my noisy machine and thankfully it 
turned out to be easy.  The thanks will have to go to your hard work.

Attached is an updated 'fancontrol' file where I've remove the use of awk, cut 
and cat from the main loop.  I would have done the 'LoadConfig' function but 
figured that redoing the '/etc/fancontrol' format would be easier.  But that 
would required changing 'pwmconfig' and everyone rerunning it.

Please someone using /proc/sys/dev/sensors test the three cut replacements.  
They are indicated with '# untested'

Thanks,
Paul
-- 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fancontrol
Type: application/x-shellscript
Size: 8375 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060212/f2d2f70d/fancontrol.bin
