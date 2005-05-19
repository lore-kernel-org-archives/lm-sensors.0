From: synaptical@linuxquestions.net (synaptical)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: no sensors found! with 2.6.0 kernel
Message-Id: <20040110193132.BAC04396E@sitemail.everyone.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109220819.F0E2E3945@sitemail.everyone.net>
In-Reply-To: <20040109220819.F0E2E3945@sitemail.everyone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thank you again. i had indeed somehow forgotten to load i2c-isa -- i guess i thought it was loaded already and skipped over it during detect. it seems, however, that w83627hf is required for my hardware after all, as no temps are detected with w83781d.

root@homer:/home/sero # lsmod
Module                  Size  Used by
i2c_isa                 2368  0 
w83781d                33984  0 
i2c_sensor              3392  1 w83781d
i2c_dev                10944  0 
i2c_core               25992  4 i2c_isa,w83781d,i2c_sensor,i2c_dev

root@homer:/home/sero # modprobe w83627hf
FATAL: Module w83627hf not found.

root@homer:/home/sero # sensors
w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.55 V  (min =  +1.89 V, max =  +2.29 V)              
VCore 2:   +1.71 V  (min =  +1.89 V, max =  +2.29 V)              
+3.3V:     +2.74 V  (min =  +2.82 V, max =  +3.79 V)              
+5V:       +4.84 V  (min =  +4.73 V, max =  +5.24 V)              
+12V:     +12.22 V  (min = +10.82 V, max = +13.19 V)              
-12V:     -13.10 V  (min = -13.18 V, max = -10.88 V)              
-5V:       -5.15 V  (min =  -5.25 V, max =  -4.75 V)              
V5SB:      +5.48 V  (min =  +4.73 V, max =  +5.24 V)              
VBat:      +3.04 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:        0 RPM  (min = 3000 RPM, div = 2)                     
fan2:        0 RPM  (min = 3000 RPM, div = 2)                     
fan3:     3590 RPM  (min =  750 RPM, div = 8)                     
ERROR: Can't get TEMP1 data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!

it seems i will have to wait until w83627hf is ported to the kernel. ? so thanks for all your help. in small return, i will make a few comments on the English on your webpage:

1.
Should you be there by pure luck
Should you be HERE by pure luck (voici vs. voila? sorry, my french is quite bad)

2. 
somthing interesting 
just a typo, i presume: should be "something"

3.
Actuality
i believe in English you meant to say something like "Employment" ? (if you are referring to your job)

4.
Organisation
a small point -- organisation is fine, mostly that is seen in british english, in american it usually is rendered organization, with a "z," as you have it right below for "organized" (might as well be consistent, eh? :-))

5. 
All your commentaries
strictly speaking not wrong, but in the context, "comments" instead of commentaries is much better. "All of your comments are welcome"

6. 
language error
should be: language errors

7.
For any remark
a bit awkward. perhaps better as something like: If you have any remarks, etc.

once again, thank you for all your work on lm_sensors, and i hope that was of some small help to you.

###

--- Jean Delvare <khali@linux-fr.org> wrote:
> thanks for the quick reply. i patched the kernel to 2.6.1 and
> recompiled it, and now w83781d is detected and loads, but still the
> sensors do not work. 

You forgot to load i2c-isa. OTOH it seems that you don't have to load
i2c-nforce2, it's unused.

-- 


_____________________________________________________________
Thank you for choosing LinuxQuestions.
http://www.linuxquestions.org
