From: mihai@duras.ro
Date: Thu, 26 Mar 2009 06:57:25 +0000
Subject: [lm-sensors] Asus P5B Deluxe..sensors wrong ?
Message-Id: <36531.79.134.52.2.1238050645.squirrel@webmail.allsoft.ro>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi guys,


I'm some sort of a newbie regarding lm-sensors as so far I haven't configured
that much for a desktop computer with them.
Now I just switched from Windows XP at home to Ubuntu and I wanted to configure
fancontrol in order to not have a factory sound inside the house:) with all
coolers running at max.
But here comes the part that got me confused.

After installing the lm-sensors package and also giving it a sensors-detect I see:

http://pastebin.com/m46cfbbee

If you look at the copy paste from the link above some of the values are SCI-FI:
CPU Fan:    2033 RPM  (min = 84375 RPM, div = 4)  ALARM
for example the minimum here..and at 84375 I might consider buying a plane:)
in1:        +12.20 V  (min =  +8.55 V, max =  +3.91 V)   ALARM
or here with the maximum being lower then the minimum.

Can you tell me what is happening and how I might correct this ?

I know I can ignore the ALARMS and just use fancontrol after configuring it
perhaps without any bad luck, but somehow it bothers me to see with the sensors
command all those warnings and min/max problems.


Regards,
Mihai


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
