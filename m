From: Rich.West@divatv.com (Rich West)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: Ticket # 748
Message-Id: <3C0C3F18.1070800@divatv.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Actually, believe it or not, I got it working.

I realized that I was using GCC 3.0.2 to compile up the lm_sensors 
modules, but the i2c modules (2.6.1), which are part of the kernel, were 
compiled with GCC 2.96 (RH 7.2).

Now, when I went back and recompiled everything using GCC 2.96, I was 
able to get it to work.  I had to insert the modules by hand, but, after 
all was said and done, lsmod gives:
eeprom                  2960   0 (unused)
gl520sm                 6688   0 (unused)
i2c-ali1535             4080   0
i2c-dev                 3616   0
i2c-proc                6128   0 [eeprom gl520sm]
i2c-core               13248   0 [eeprom gl520sm i2c-ali1535 i2c-dev 
i2c-proc]

And, from there, sensors gives decent output!

Thanks a lot for a great app!

-Rich
