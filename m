From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: second report (was: tests)
Message-Id: <20020712224337.07bdd6b8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The lm92 driver still needs fixing to compile correctly on 2.2.x kernel
systems.

I tried to play around with i2c-riva and friends, but without succes so
far. I think it would require some extra documentation, but it's not
that important and I suggest we don't care about it for the 2.6.4
realease. Keep it for later.

One change in the sensors.conf file don't please me, for chipset
w83782d-*:
    set in1_min 1.5 * 0.95
    set in1_max 1.5 * 1.05
became
    set in1_min vid*0.95
    set in1_max vid*1.05
It used to be good for my motherboard (MSI-6163), now it isn't anymore
(since vid is 2.0).

I still have one more system to test, but I'll be off for two days so
don't expect anything before Monday July 15th. Once the compilation
problem with module lm92 will be fixed, I think we should be OK for the
release (if I don't encounter problems on the last system, of course).

Good job guys, go on
Thanks.

PS: I plan to add Sony Vaio EEPROM support to sensors-detect and sensors
(*not* for 2.6.4, of course ; for later). I didn't look at the files for
now, but I guess I won't understand everything at first sight. I may beg
for help soon (Frodo, Philip, are you still around?). Any suggestion
welcome. Also, note that I am still looking for some recent Vaio owner,
in order to test my EEPROM decoder on another laptop that just mine.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
