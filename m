From: littlejohn@knology.net (LittleJohn)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Sensors On VIA Motherboard
Message-Id: <42090B06.2040209@knology.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Howdy:

	I just installed lm_sensors on a VIA EPIA-V motherboard and had 
everything working great. That is, until I started mucking with the 
calculations. Now everything still seems to work as expected, but I have 
an alarm on the CPU temp that won't clear.

	I created alarms on the voltages, but they cleared normally after the 
values came back into their expected ranges.  I tried everything to 
clear the CPU alarm, but nothing helped.  Even tried writing zeros to 
the alarm register and the magic Windoze trick of powering down the 
machine.  No help.

	If you know the trick to clearing it, I'll trade you some new constant 
(K) values that make the sensors output agree with the bios readings. 
And I'll even toss in the VIA data sheet on the VT8231.

John Littleton
LittleJohn@knology.net
