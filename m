From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: cpu temperature discovering problem on w83627hf
Message-Id: <20030519113938.39e0279f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <70486737687.20030519114320@org.ukr.net>
In-Reply-To: <70486737687.20030519114320@org.ukr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> temp1:       +46?C  (limit =  +40?C, hysteresis =  +37?C)
> temp2:      +0.0?C  (limit =  +80?C, hysteresis =  +75?C)
> temp3:     +1.5?C  (limit =  +80?C, hysteresis =  +75?C)

> Temp1 is probably normal, but the other two  - ???
> I have no idea how to cope with it. Could you help?

You don't necessarily have them on your motherboard. They're here
because they're supported by the chipset, but they may not be wired at
all on your specific motherboard.

Anyway, if you think they are, here are some hints.

1* Try changing the sensor type (edit the relevant lines in
/etc/modules.conf). Don't forget to run "sensors -s" each time you
change the value (I can't remember if it's actually required, but it
won't hurt).
2* Try overloading your system (compile something big such as a kernel)
and see if the values change or not. If they don't change, they're
probably nor wired.
3* You may need to plug external thermal sensors onto your motherboard
in order to have the values reported. Though most sensors are internal,
there used to be external ones.

Finally, if you come to the conclusion they are not wired, simply add
some ignore statements to /etc/modules.conf in order not to have them
displayed anymore.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
