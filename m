From: prymitive@go2.pl (prymitive)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Ticket # 1526
Message-Id: <200401191914.36534.prymitive@go2.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040118191822.43f7a2d7.khali@linux-fr.org>
In-Reply-To: <20040118191822.43f7a2d7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dnia nie 18. stycznia 2004 19:18, napisa?e?:
> This still doesn't explain why the eeprom driver doesn't work on your
> system. Maybe you don't care, but I'm curious, so it'd be great if you
> could answer the questions I was asking to you in the ticket:
> 1* What are the permissions of file /sys/bus/i2c/devices/0-0050/eeprom?
> 2* Can you send us the contents of this file for analysis?
I've rebuild the kernel with ISA disabled but eeprom works without problems, 
I've changed few things in modules.conf and system settings so maybe the 
problem was there, if You want I can try to reproduce it, but I don't know if 
I can remember every thing I've changed.

Lucas

