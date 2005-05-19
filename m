From: hyc@highlandsun.com (Howard Chu)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: Asus A8V Deluxe
Message-Id: <421EAA13.40108@highlandsun.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42120C36.6000107@highlandsun.com>
In-Reply-To: <42120C36.6000107@highlandsun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, one last update, I think I have this right.

Still using the w83627thf-* config, but there's no -12V supply and 
there's no battery since this is a desktop machine, so I commented out 
label in4 and label in8 and replaced them with "ignore" ...

I set the vrm to 2.4 since this is an AMD64 and the single datasheet for 
AMD64, 64FX, and Opteron all use this same spec.
http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_739_7203,00.html
document #30430 "Amd Athlon64 Processor Power and Thermal Data Sheet"
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/30430.pdf

It turns out Vcore was correct all along; I thought it was wrong before 
because the chip is spec'd for 1.4V/1.0V and I was seeing ~1.7V here. 
But in fact, I had left Vcore on [AUTO] in the BIOS and it chose 1.7V! I 
fixed the BIOS setting, so the chip is running cooler now.

Asus PC Probe didn't report the 3rd temperature sensor, so I really had 
no idea what it was, and it wasn't in the BIOS screens either. But in 
the Asus A8V manual there's a screenshot showing this labeled as Power 
temperature. Also, SiSoft Sandra reported it as Power / Aux so I'm now 
using these labels:

     label temp1 "M/B Temp"
     label temp2 "CPU Temp"
     label temp3 "Pwr Temp"

I believe it's correct. The M/B temp changes very little, +/- one degree 
over many hours. With a room at 18C ambient, M/B seems to stay around 
27C. At the same time, CPU idle, the CPU temp reads 31C, and the Pwr 
Temp reads 18C. When I run something CPU-intensive (like super_pi) the 
Pwr Temp rises a couple degrees immediately, and the CPU Temp ramps up 
slowly.

The PWM controller for Fan2 works fine to control the CPU fan. I haven't 
tested Fan1 or Fan3 because they're plugged into my Antec power supply 
and that's controlling them.

     set fan1_div 8
     set fan1_min 1000
     set fan2_div 4
     set fan2_min 1000
     label fan1 "Case Fan"
     label fan2 "CPU Fan"
     label fan3 "PSU Fan"

I had to set fan1_div to get any reading at all, and fan2_div to get 
something close to reality. fan3 seemed to come up with correct defaults 
already.

I hope this helps any other Asus A8V owners out there...


Jean Delvare wrote:
> Hi Howard,
> 
> 
>>I think the CPU temp readings are a little low compared to
>>what the BIOS reports too, but it's hard to verify.
> 
> 
> See FAQ 4.12:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e12
> 
> 
>>I also started powernowd, and when the CPU goes into low power mode not
>>only does the clock frequency drop from 1.8GHz to 1.0GHz, but VCore also
>>drops from 1.75V to 1.41V, which triggers an alarm. I suppose I can just
>>set a lower minimum for VCore, but I wonder if that might mask a fault
>>somewhere down the road?
> 
> 
> No, that's actually what you should do. I don't know exactly how
> powernowd works, but if it generates events when the speed and vcore
> change, you might use these to reprogram the limits on the fly. That'd
> allow you to have one short range for each nominal vcore, instead of one
> large range covering both, which somewhat limits the efficiency of the
> monitoring.
> 
> I have to admit that our current architecture doesn't really cover this
> situation, so it's left to you to implement the limts change as a hack
> if you think it's worth the effort.
> 
> --
> Jean Delvare
> 


-- 
   -- Howard Chu
   Chief Architect, Symas Corp.       Director, Highland Sun
   http://www.symas.com               http://highlandsun.com/hyc
   Symas: Premier OpenSource Development and Support
