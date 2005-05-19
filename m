From: dieter.jurzitza@t-online.de (Dr. Ing. Dieter Jurzitza)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Tyan 2460 MB
Message-Id: <XFMail.20020614214139.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear people from the lm_sensors team,
first of all: thank you for your work! The program is  highly functional and
satisfies (nearly ...) all things that could be interesting.
You know (from tickets 813,808,781,765) about the Tyan 2460MB:
- there are two sensor chips on it working on different areas.
I have an 1.04 bios in use and can tell from my experience:
- temperature readings are correct if the initialization has not occured (in
contrast to what has been written in ticket 812), the chip w83782d-i2c-0-2d
seems to monitor the processor temperature
- the fan readings are not the ones from the processors, the voltage data are
hard to interpret. Maybe the due to the voltage divider, as you readily
mentioned.
- after initialization the temperature values are identical to those in the
bios *prior* to initialization and show high numbers (77?C and 78?C).
- the rpm values from the fans are in an odd relationship to the actual speed,
I have to recheck. However, the fan data appear to be more plausible after
initialization.

If there are any additional checks I could supply for your help, please let me
know. Basically one would need to access both chips for different data, but
this seems impossible from the current lm_sensors package.

Hope you can use the information!
Take care



Dieter Jurzitza

-- 
-----------------------------------------------------------
E-Mail: Dr. Ing. Dieter Jurzitza <dieter.jurzitza@t-online.de>
Date: 14-Jun-2002
Time: 21:21:30                 |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------
