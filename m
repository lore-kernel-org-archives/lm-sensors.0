From: itech@kfa.org (it)
Date: Tue, 12 Dec 2006 21:00:01 +0000
Subject: [lm-sensors] ERROR: Can't get adapter or algorithm?!?
Message-Id: <457F1851.6060902@kfa.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

What does this error mean?

Here's the output:
----------------------------------------------------------------------------------
root at storage02:/usr/share/doc/lm-sensors# sensors
bmc-i2c--1209221748-bfb9a7e8
 ERROR: Can't get adapter or algorithm?!?
in1:       +1.30 V  (min =  +0.00 V, max =  +0.00 V)
in2:       +0.07 V  (min =  +0.00 V, max =  +0.00 V)
in3:       +0.07 V  (min =  +0.81 V, max =  +0.98 V)
in4:       +0.13 V  (min = +10.42 V, max = +13.58 V)
in5:      +11.59 V  (min =  +4.45 V, max =  +5.56 V)
in6:       +4.99 V  (min =  +1.36 V, max =  +1.64 V)
in7:       +1.50 V  (min =  +3.03 V, max =  +3.61 V)
in8:       +3.29 V  (min =  +2.94 V, max =  +3.68 V)
in9:       +3.32 V  (min =  +1.64 V, max =  +1.99 V)
in10:      +1.97 V  (min =  +1.33 V, max =  +1.68 V)
fan1:        0 RPM  (min =  330 RPM)
fan2:        0 RPM  (min = 1221 RPM)
fan3:        0 RPM  (min = 1221 RPM)
temp1:      +0.0??C  (high =    +0??C, hyst =    +2??C)
temp2:      +0.0??C  (high =    +0??C, hyst =    +2??C)
temp3:    +772.2??C  (high =   +50??C, hyst =    +0??C)
temp4:      +0.0??C  (high =   +50??C, hyst =    +0??C)
temp5:    +1190.0??C  (high =   +48??C, hyst =    +2??C)
temp6:      +0.0??C  (high =   +66??C, hyst =    +2??C)
------------------------------------------------------------------------------

Also, how can I make each of the entries be more human-readable? Is 
there a spec sheet that I can look this up in for my board?

Thanks!
Andrey.

