From: aronayette@free.fr (aronayette)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: vt1211 2.6.6-mm4 patch
Message-Id: <40AE4BC9.8060805@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <010201c43f3c$a3b14d30$2500920a@bruce>
In-Reply-To: <010201c43f3c$a3b14d30$2500920a@bruce>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks aaron ,
your patch is working on my kernel.
But the values are strange :

vt1211-isa-6000
Adapter: ISA adapter
Algorithm: ISA algorithm
in0:       +1.87 V  (min =  +0.00 V, max =  +2.55 V)  
in1:       +1.95 V  (min =  +0.00 V, max =  +2.55 V)  
in2:       +1.15 V  (min =  +0.00 V, max =  +2.55 V)  
in3:       +1.89 V  (min =  +0.00 V, max =  +2.55 V)  
in4:       +2.03 V  (min =  +0.00 V, max =  +2.55 V)  
ERROR: Can't get IN5 data!
fan1:     4519 RPM  (min =    0 RPM, div = 2)         
fan2:        0 RPM  (min =    0 RPM, div = 2)         
temp2:    +187.0 C  (high =  +255 C, hyst =    +0 C)                    
! really high for Celsius
temp3:    +107.2 C  (high =  +255 C, hyst =    +0 C)  
ERROR: Can't get TEMP4 data!
ERROR: Can't get TEMP5 data!
ERROR: Can't get TEMP6 data!
ERROR: Can't get TEMP7 data!


and if i do a sensors -f (fahrenheit)

vt1211-isa-6000
Adapter: ISA adapter
in0:       +1.87 V  (min =  +0.00 V, max =  +2.55 V)  
in1:       +1.95 V  (min =  +0.00 V, max =  +2.55 V)  
in2:       +1.15 V  (min =  +0.00 V, max =  +2.55 V)  
in3:       +1.89 V  (min =  +0.00 V, max =  +2.55 V)  
in4:       +2.03 V  (min =  +0.00 V, max =  +2.55 V)  
ERROR: Can't get IN5 data!
fan1:     4519 RPM  (min =    0 RPM, div = 2)         
fan2:        0 RPM  (min =    0 RPM, div = 2)         
temp2:    +368.6 F  (high =  +491 F, hyst =   +32 F)  
temp3:    +225.0 F  (high =  +491 F, hyst =   +32 F)  
ERROR: Can't get TEMP4 data!
ERROR: Can't get TEMP5 data!
ERROR: Can't get TEMP6 data!
ERROR: Can't get TEMP7 data!


Is it a configuration problem or something like that ?

Thks for all.

Nicolas



