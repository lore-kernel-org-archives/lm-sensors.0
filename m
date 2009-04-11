From: Jonathan Winters <jonathan.winters11@gmail.com>
Date: Sat, 11 Apr 2009 08:57:00 +0000
Subject: [lm-sensors] You're taking wrong route on K8 monitoring
Message-Id: <1239440220.18797.5.camel@ip68-13-241-188.ok.ok.cox.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You have a valid k8 monitoring system. Ticket 2278 is showing you what
to do about it as kernel 2.26.29 won't fix this.

This is from core temp project.

The formula for the K8 is: 'Core Temp = Value - 49'.

Add: AMD AM2 65nm K8 based processors get a 21c offset to fix incorrect
temperature reporting (info from AMD).

If you would just look at ticket 2278 and add 21c to the value you might
have a working temp monitor.
You report 7 c on my amd 4850e which is g2 step K8.
add 21c to that and you have 28c which is what my bios reports and what
windows programs report. So why put off something that is done. ;)




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
