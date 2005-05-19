From: aacs@subdimension.com (A&A Computer Solutions)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: lm-sensors
Message-Id: <000801c2cd43$27daf880$0300a8c0@ZYNTH>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C61EE92.392A5D31@paradyne.com>
In-Reply-To: <3C61EE92.392A5D31@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hey!

I have a Fullyes 82440LX motherboard, with a pentiumII 300MHz.
I compiled i2c and lm-sensors with no problems (I guess).
But unfortunately there is a problem :)

On my motherboard there is an gl518sm sensor chip,
which should be supported.
Unfortunately sensors-detect only detects an eeprom, but not the gl518sm chip.
When I modprobe gl518sm, it nicely adds the module,
but then a "sensors -a" results in an: sensors not found!

can you help please?
if you need more info, just ask me,
and I'll be happy to send it.

greetz,
Anne
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030205/abfbec18/attachment.html
