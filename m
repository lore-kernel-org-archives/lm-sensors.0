From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: no sensors found! with 2.6.0 kernel
Message-Id: <20040110211358.1368049d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109220819.F0E2E3945@sitemail.everyone.net>
In-Reply-To: <20040109220819.F0E2E3945@sitemail.everyone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> it seems, however, that w83627hf is required for my hardware
> after all, as no temps are detected with w83781d.
> 
> root@homer:/home/sero # lsmod
> Module                  Size  Used by
> i2c_isa                 2368  0 
> w83781d                33984  0 
> i2c_sensor              3392  1 w83781d
> i2c_dev                10944  0 
> i2c_core               25992  4 i2c_isa,w83781d,i2c_sensor,i2c_dev
> 
> root@homer:/home/sero # modprobe w83627hf
> FATAL: Module w83627hf not found.
> 
> root@homer:/home/sero # sensors
> w83627hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +1.55 V  (min =  +1.89 V, max =  +2.29 V)              
> VCore 2:   +1.71 V  (min =  +1.89 V, max =  +2.29 V)              
> +3.3V:     +2.74 V  (min =  +2.82 V, max =  +3.79 V)              
> +5V:       +4.84 V  (min =  +4.73 V, max =  +5.24 V)              
> +12V:     +12.22 V  (min = +10.82 V, max = +13.19 V)              
> -12V:     -13.10 V  (min = -13.18 V, max = -10.88 V)              
> -5V:       -5.15 V  (min =  -5.25 V, max =  -4.75 V)              
> V5SB:      +5.48 V  (min =  +4.73 V, max =  +5.24 V)              
> VBat:      +3.04 V  (min =  +2.40 V, max =  +3.60 V)              
> fan1:        0 RPM  (min = 3000 RPM, div = 2)                     
> fan2:        0 RPM  (min = 3000 RPM, div = 2)                     
> fan3:     3590 RPM  (min =  750 RPM, div = 8)                     
> ERROR: Can't get TEMP1 data!
> ERROR: Can't get TEMP2 data!
> ERROR: Can't get TEMP3 data!
> 
> it seems i will have to wait until w83627hf is ported to the kernel. ?

Negative. The problem is due to the fact that you are using lm_sensors
CVS on Linux 2.6.0, or lm_sensors 2.8.2 on Linux 2.6.1, and this doesn't
work. Use lm_sensors 2.8.2 if under Linux 2.6.0, CVS if under Linux
2.6.1-rc1 or above, and you should get the temperature readings OK.

> so thanks for all your help. in small return, i will make a few
> comments on the English on your webpage:

Could have been in a private e-mail, don't you think? ;))

> 3.
> Actuality
> i believe in English you meant to say something like "Employment" ?
> (if you are referring to your job)

This is the place for latest things that happend to me. It is about
employment this time, but could be completely different. So I renamed it
to "Breaking News".

All other comments gladly accepted, fixes applied. This page was written
about four years ago, and back to that time I wasn't very active on
english-speaking mailing-lists, nor in the open-source community at all.
Needless to say that the quality of my English has improved a lot since
(although I am still able to make ugly mistakes) and reading my old words
is... well, simply awful. I should really rework these pages, shame on
me. But no time for this, of course.

> once again, thank you for all your work on lm_sensors, and i hope that
> was of some small help to you.

Thanks a lot for the proofreading job :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
