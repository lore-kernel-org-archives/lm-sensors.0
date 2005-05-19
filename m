From: s.blomfield@cox.net (Scott Blomfield)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: lm_sensors installation success after errors
Message-Id: <066201c4ab25$e8f27540$0a01a8c0@bullwinkle>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

IRC Log of #linux-sensors on irc.freenode.net
[16:41] <ruik> sensors@Stimpy.netroedge.com
[16:41] <ruik> write email to this mail address
[16:41] <ruik> write there that you have some TV cards
[16:41] <ruik> and Fedora Core2
[16:42] <CyberKnet> to let them know that my sensors work now?
[16:42] <ruik> and write that the fedora has only i2c-0 i2c-1  
[16:43] <ruik> and just mentioned the mknod command
[16:42] <ruik> and write that the fedora has only i2c-0 i2c-1  
[16:43] <ruik> and just mentioned the mknod command
[16:43] <ruik> yes.
[16:43] <ruik> and the reason was that fedora core 2 has too low numbers
of i2c-* files
 
commands referred to are:
 
mknod  i2c2 c 89 2
mknod  i2c-2 c 89 2
mknod i2c3 c 83 3
mknod i2c-3 c 83 3
 
ruik figured out that since my two tv tuner cards were also exporting an
i2c interface that there were not enough i2c files available under
fedora core 2 to support the two tuner cards plus the two motherboard
sensors. The guy deserves a medal, he ran a veritable marathon trying to
figure it out and never once referred me to the documentation. Which I
did read, too. Good stuff.
 
Anyways, just reporting success.
 
Thanks,
 
Scott Blomfield
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041005/06ee6ab3/attachment.html
