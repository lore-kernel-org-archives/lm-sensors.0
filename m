From: TheOneAndOnlySM@hot.rr.com (Sandeep Mehta)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: News about PC87366
Message-Id: <40B75F0F.5020008@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516104801.568f2ad0.khali@linux-fr.org>
In-Reply-To: <20040516104801.568f2ad0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Unfortunately, I was unable to note any differences in the voltages 
after setting all pwm values back to 0. I also played around with it 
some more, but nothing changed in the output of sensors.

Strangely, all of a sudden, echoing new pwm values (0 means full speed 
and 255 is lowest) will change my fan speeds again and sensors will 
report overflows like it had been doing before. I have no clue what 
could have caused this sudden change, since I have not 
compiled/installed anything new or done anything different while booting 
my computer.
Also, I don't recall anytime when pwm might have been forceably enabled.

I played with changing min and max values in sensors.conf and all that 
works well.

sensors output (all pwm is 0, everything at default)
pc87366-isa-ecc0
Adapter: ISA adapter
+5V:       +3.46 V  (min =  +4.48 V, max =   5.47 V)       ALARM
Vcore:     +0.77 V  (min =  +3.02 V, max =   3.02 V)       ALARM
+12V:      +6.04 V  (min = +10.79 V, max =  13.18 V)       ALARM
5VSB:      +2.47 V  (min =  +4.48 V, max =   5.47 V)       ALARM
Vsb:       +3.36 V  (min =  +3.00 V, max =   3.60 V)
Vdd:       +3.32 V  (min =  +3.00 V, max =   3.60 V)
Vbat:      +0.00 V  (min =  +2.40 V, max =   3.02 V)
AVdd:      +3.32 V  (min =  +3.00 V, max =   3.60 V)
fan1:     3503 RPM  (min = 3000 RPM, div = 1)
fan2:     2162 RPM  (min = 2000 RPM, div = 2)
S-IO Temp:   +53 C  (low  =    +5 C, high =   +60 C)
S-IO Crit:   +70 C
temp4:       +36 C  (low  =    +0 C, high =   +70 C)
temp4_crit:
             -25 C
temp5:       +40 C  (low  =    +0 C, high =   +70 C)
temp5_crit:
             -25 C
temp6:       +36 C  (low  =    +0 C, high =   +70 C)
temp6_crit:
             -25 C

The chip dump is also attached.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pc87366-dump.tar.gz
Type: application/x-gzip
Size: 919 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040528/dc240574/pc87366-dump.tar.gz
