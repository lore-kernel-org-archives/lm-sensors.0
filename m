From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Apr 2011 06:59:27 +0000
Subject: Re: [lm-sensors] wrong voltages on D525MWV
Message-Id: <20110416085927.46195007@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1QApIq-0002zf-00.serafim_home-mail-ru@f134.mail.ru>
In-Reply-To: <E1QApIq-0002zf-00.serafim_home-mail-ru@f134.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Серафим,

On Sat, 16 Apr 2011 00:07:40 +0400, Ð¡ÐµÑÐ°ÑÐ¸Ð¼ Ð¡ÑÑÐµÐ½ÑÐºÐ¸Ð¹ wrote:
> Hi!
> 
> I have Intel D525MW V  motherboard ( http://www.intel.com/Products/Desktop/Motherboards/db-d525mw/D525MW-overview.htm (http://www.intel.com/Products/Desktop/Motherboards/db-d525mw/D525MW-overview.htm) ), with last BIOS version installed.
> 
> If I look through voltages in bios, then I see something like:
> 12V : 12.249
> 5V: 5.094
> 3.3V: 3.36
> 5Vstbg: 5.145
> Vccp: 1.184
> 
> And sensors show wrong voltages:
> 
> root@carpc:~# sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +16.0Â°C  (crit = +100.0Â°C)                  
> 
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 1:       +8.0Â°C  (crit = +100.0Â°C)                  
> 
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:       +1.19 V  (min =  +0.00 V, max =  +1.74 V)   
> in1:         +1.59 V  (min =  +1.72 V, max =  +1.02 V)   ALARM
> AVCC:        +3.39 V  (min =  +2.98 V, max =  +3.63 V)   
> VCC:         +3.39 V  (min =  +2.98 V, max =  +3.63 V)   
> in4:         +1.86 V  (min =  +0.82 V, max =  +1.54 V)   ALARM
> in5:         +1.20 V  (min =  +0.98 V, max =  +1.98 V)   
> in6:         +1.59 V  (min =  +2.03 V, max =  +1.54 V)   ALARM
> 3VSB:        +3.39 V  (min =  +2.98 V, max =  +3.63 V)   
> Vbat:        +3.26 V  (min =  +2.70 V, max =  +3.30 V)   
> fan1:          0 RPM  (min =  585 RPM, div = 128)  ALARM
> fan2:          0 RPM  (min =  439 RPM, div = 128)  ALARM
> fan3:          0 RPM  (min = 3668 RPM, div = 8)  ALARM
> fan4:          0 RPM  (min = 8653 RPM, div = 4)  ALARM
> fan5:          0 RPM  (min = 6617 RPM, div = 4)  ALARM
> temp1:       +45.0Â°C  (high = -33.0Â°C, hyst = -46.0Â°C)  ALARM  sensor = transistor
> temp2:       +41.0Â°C  (high = +80.0Â°C, hyst = +75.0Â°C)  sensor = diode
> temp3:       +39.5Â°C  (high = +80.0Â°C, hyst = +75.0Â°C)  sensor = diode
> cpu0_vid:   +2.050 V

Voltages aren't "wrong". Vccp and +3.3V are correct (labelled Vcore and
AVCC/VCC, respectively). The other inputs simply need scaling factors
and labels. These are specific to each board. 

> 
> Fans look ok (but I didn't test them).

Fan speeds are all 0. How could this be OK?

> Can you help me with voltages?

You should ask Intel for the voltage input pin mapping and scaling
factors.

Failing that, if you are able to gather several samples of each of 12V,
5V and 5Vstby in the BIOS, we can guess the scaling factors from the
sample differences, and from that, find the pin mapping.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
