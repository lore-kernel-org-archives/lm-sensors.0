From: perrye@linuxmail.org (Perry Gilfillan)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: New vpx3224 module nearing readyness for submission
Message-Id: <20040204035408.21161.qmail@linuxmail.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'd appreciate it if you could take a little time to review my work on the vpx3224 module and make comments about it's readiness to submit to the kernel list.

I've ironed out all the wrinkles I can recognize, but with my limited experience, I'm sure to have missed some things that may seem rather basic.

The proc interface might as well be stripped out, and maintained separately from what gets submitted to the kernel.  

At this point I think I have all the maths correct, especially for the video_picture struct members being written to the vpx registers in the VIDIOCSPICT function vpx3224_set_picture.

I'll look forward to your comments and criticisms.

Regards,

Perry Gilfillan
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.

Powered by Outblaze
