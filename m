From: jzhao@mountainviewdata.com (jack)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Hi, would you help me about lm87?
Message-Id: <000f01c16744$8c061350$0a09010a@cn.mvd>
List-Id: <lm-sensors.vger.kernel.org>
References: <000a01c16736$4d826290$0a09010a@cn.mvd>
In-Reply-To: <000a01c16736$4d826290$0a09010a@cn.mvd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Phil
        First, Thank you for your help very much.

        Yes, This package can get all the information, but the result is some different from the fact.
For example :
        The 2.5V and Vccp1 's ? Vccp2 's current value and min and max seem very strange. Or these 
value don't exist in fact at all?

        I think it maybe need some revise , but I don't know how to do it? 
Would you tell me a method to do it?     
        Thanks a lot.

        And I have read the latest sensors.conf,  but how I modify it ? 

    chip "lm87-*"
#
# This chip has non-standard entries in lib/chips.c so
# the feature names are quite different from other chips.
# For this chip, libsensors anticipates the correct labeling.
# This is great if it's correct but makes it a little more
# difficult if you want to change it.
#
# This may not have been a good idea, so it may be changed in the future.
# Here is an entry with everything commented out so you can
# uncomment the appropriate line if you want to change it.
#
# Warning - feature names starting with a number must be enclosed
# with double quotes.
#
#   label "2.5V" "xxx"
#   label Vccp1 "xxx"
#   label "3.3V" "xxx"
#   label "5V" "xxx"
#   label "12V" "xxx"
#   label Vccp2 "xxx"
#   label AIN1 "xxx"
#   label AIN2 "xxx"
#   label fan1 "xxx"
#   label fan2 "xxx"
#   label temp1 "xxx"
#   label CPU_Temp "xxx"
#   label CPU2_Temp "xxx"
#   set AmbTemp_min xxx
#   set Vccp1_min xxx
#   set "3.3V_min" xxx
#   set "5V_min" xxx
#   set "12V_min" xxx
#   set Vccp2_min xxx
#   set AIN1_min xxx
#   set AIN2_min xxx
#
#   set AmbTemp_max xxx
#   set Vccp1_max xxx
#   set "3.3V_max" xxx
#   set "5V_max" xxx
#   set "12V_max" xxx
#   set Vccp2_max xxx
#   set AIN1_max xxx
#   set AIN2_max xxx
#
#   set fan1_min xxx
#   set fan2_min xxx
#   set temp1_min xxx
#   set temp1_max xxx
#   set temp2_min xxx
#   set temp2_max xxx
#   set temp3_min xxx
#   set temp3_max xxx
#   set fan1_div xxx
#   set fan2_div xxx

#   compute "2.5V" xxx
#   compute Vccp1 xxx
#   compute "3.3V" xxx
#   compute "5V" xxx
#   compute "12V" xxx
#   compute Vccp2 xxx
#   compute AIN1 xxx
#   compute AIN2 xxx
#   compute temp1  
#   compute CPU_Temp 
#   compute CPU2_Temp 


> > My hardware is supermicro??s 370DER, and only one CPU.
> > 
> > http://www.supermicro.com/product/motherboards/rcc_he_sl/370DER.htm
> > 
> > When I run sensor to get the PC health, I get the output as following:
> > 
> > lm87-i2c-0-2d
> > Adapter: SMBus OSB4 adapter at 0580
> > Algorithm: Non-I2C SMBus adapter
> > 2.5V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> > Vccp1:     +1.29 V  (min =  +2.55 V, max =  +2.84 V)   ALARM
> > 3.3V:      +3.35 V  (min =  +3.12 V, max =  +3.47 V)
> > 5V:        +5.05 V  (min =  +4.73 V, max =  +5.26 V)
> > 12V:      +12.25 V  (min = +11.37 V, max = +12.62 V)
> > Vccp2:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> > fan1:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> > fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> > temp1:    +42.0?C   (min = +10?C, max = +60?C)
> > CPU_Temp: +128.0?C   (min = +10?C, max = +60?C)  FAULT
> > vid:       +1.30 V
> > 
> > lm87-i2c-0-2e
> > Adapter: SMBus OSB4 adapter at 0580
> > Algorithm: Non-I2C SMBus adapter
> > 2.5V:      +3.29 V  (min =  +1.41 V, max =  +1.57 V)   ALARM
> > Vccp1:     +1.68 V  (min =  +2.55 V, max =  +2.84 V)   ALARM
> > 3.3V:      +3.35 V  (min =  +3.12 V, max =  +3.47 V)
> > 5V:        +5.05 V  (min =  +4.73 V, max =  +5.26 V)
> > 12V:      +12.18 V  (min = +11.37 V, max = +12.62 V)
> > Vccp2:     +1.49 V  (min =  +1.53 V, max =  +1.70 V)   ALARM
> > fan1:     4017 RPM  (min = 3000 RPM, div = 2)
> > fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> > temp1:    +45.0?C   (min = +10?C, max = +60?C)
> > CPU_Temp: +55.0?C   (min = +10?C, max = +60?C)
> > vid:       +1.70 V
> > 
> > But I get data from BIOS is :
> > cpu1       56C
> > cpu2       N/A
> > Overheat   85C
> > cpu1 vcore 1.69
> > cpu2 vcore 1.29
> > +3.3v      3.35
> > +5v        5.07
> > +12v       12.25v
> > cpu fan1   4066
> > cpu fan2   N/A
> > chasis fan1N/A
> > chasis fan2N/A
> > 
> > Would you give me any advice?
> > I need this output to be correct very much.
> > Thank you !
> -- 
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
