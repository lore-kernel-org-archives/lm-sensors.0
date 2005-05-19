From: matthias@hentges.net (Matthias Hentges)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Ticket 1267
Message-Id: <1055301281.3897.821.camel@mhcln02>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055028795.11422.50.camel@mhcln02>
In-Reply-To: <1055028795.11422.50.camel@mhcln02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Die, 2003-06-10 um 03.53 schrieb Mark D. Studebaker :
> thanks for testing the 801 fix.

Nahh, *I* have to thank *you* guys!

> We've added the ID to CVS.

Yes, i just noticed, heh. CVS i2c-i801 now loads w/o oops and is
detected by sensors-detect.


> On the 627THF, if you are feeling brave you can try investigating what device
> ID is returned by super IO probing either by hacking sensors-detect
> or at line 683 or so in the w83627hf driver.

You mean line 631+, line 683 is never reached because w83627hf_find
bails out if no matching DEVID is found. I've inserted a printk to get
the DEVID, it's 0x82.

> Then add code to recognize it and see what happens.

[w83627hf.c, line 636 +/-1, added W627HF_DEVID and defined it with 0x82]
if(val != W627_DEVID && val != W697_DEVID && val != W627THF_DEVID) {
		superio_exit();
		return -ENODEV;
	}
[END]

AND

[w83627hf.c, line 689 +/-1, added W627THF_DEVID]
	if(val = W627_DEVID)
		kind = w83627hf;
	else if(val = W697_DEVID)
		kind = w83697hf;
	else if(val = W627THF_DEVID)
		kind = w83627hf;
[END]

The module now loads and IT WORKS!!

Output from sensors:

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +3.00 V  (min =  +0.00 V, max =  +0.00 V)              
VCore 2:   +3.21 V  (min =  +0.00 V, max =  +0.00 V)              
+3.3V:     +3.34 V  (min =  +2.97 V, max =  +3.63 V)              
+5V:       +5.04 V  (min =  +4.50 V, max =  +5.48 V)              
+12V:     +15.50 V  (min = +10.79 V, max = +13.11 V)              
-12V:     -14.91 V  (min = -13.21 V, max = -10.90 V)              
-5V:       -7.71 V  (min =  -5.51 V, max =  -4.51 V)              
V5SB:      +5.07 V  (min =  +4.50 V, max =  +5.48 V)              
VBat:      +3.29 V  (min =  +2.70 V, max =  +3.29 V)       ALARM  
fan1:        0 RPM  (min =  187 RPM, div = 32)                     
fan2:     2721 RPM  (min = 3000 RPM, div = 2)                     
fan3:        0 RPM  (min =   46 RPM, div = 128)                     
temp1:       +41?C  (limit =  +60?C)                       
sensor = thermistor           
temp2:     +33.5?C  (limit =  +60?C, hysteresis =  +50?C) 
sensor = PII/Celeron diode           
temp3:    +208.0?C  (limit =  +60?C, hysteresis =  +50?C) 
sensor = thermistor           
vid:      +0.000 V
alarms:   
beep_enable:
          Sound alarm disabled

As you can see the voltages are a bit off, so the driver needs a little
bit tweaking.
But the (in my eyes) more important fan and temperatures do work
correctly when compared with the bios.

Thanks a lot for your help. Since i don't speak C i couldn't have done
that on my own!

I have included a patch for w83627hf.c (i dunno if your list filters
attachments).


> There's no THF datasheet on the Winbond web site.

I have written a "request" to winbond for the datasheet, lets see what
happens. Maybe it'll help with the voltages.


Thanks alot for your time, i really would have hated it to life w/o
sensor readings :)

PS: If you need help fine-tuning the driver let me know.

-- 

Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian Woody: Geek by Nature, Linux by Choice

-------------- next part --------------
27a28
>     w83627thf	9	2	?	3	0x82	0x5ca3	no	yes
117a119
> #define W627THF_DEVID 0x82
632c634
< 	if(val != W627_DEVID && val != W697_DEVID) {
---
> 	if(val != W627_DEVID && val !=W627THF_DEVID && val != W697_DEVID) {
687a690,692
> 	else if(val = W627THF_DEVID)
> 		kind = w83627hf;
> 		
