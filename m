From: Simon Wilson <simon@simonandkate.net>
Date: Mon, 19 Oct 2009 06:45:16 +0000
Subject: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

I am soooo close to getting this working properly.

I have a GA-P35-DS3P motherboard, with an E6850 Core 2 Duo processor.  
The machine is running CentOS 5.3. It has an it8718 sensors chip.

I have installed lm_sensors 2.10.8 and the kmod-it87 driver from  
elrepo.org (needed because of the 'old' CentOS 2.6.18 kernel), and all  
is basically working. A clear sensors output reads:

it8718-isa-0290
Adapter: ISA adapter
in0:       +1.12 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
in1:       +1.87 V  (min =  +1.71 V, max =  +1.89 V)
in2:       +3.22 V  (min =  +3.14 V, max =  +3.47 V)
in3:       +2.91 V  (min =  +2.83 V, max =  +3.12 V)
in4:       +0.85 V  (min =  +2.85 V, max =  +3.15 V)   ALARM
in5:       +0.05 V  (min =  +0.85 V, max =  +1.09 V)   ALARM
in6:       +0.03 V  (min =  +1.12 V, max =  +1.28 V)   ALARM
in7:       +3.12 V  (min =  +2.85 V, max =  +3.15 V)
in8:       +3.30 V
fan1:     1424 RPM  (min =  600 RPM)
fan2:        0 RPM  (min = 3994 RPM)
fan3:        0 RPM  (min =    0 RPM)
fan4:        0 RPM  (min =    0 RPM)
temp1:       +30°C  (low  =   +10°C, high =   +60°C)   sensor = thermistor
temp2:       +26°C  (low  =   +10°C, high =   +70°C)   sensor = diode
temp3:        -2°C  (low  =  +127°C, high =  +127°C)   sensor = disabled
vid:      +0.000 V

Using the configuration from  
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/G33-DS3R which  
also uses the 8718 I am now at this:

it8718-isa-0290
Adapter: ISA adapter
Vcore:     +1.04 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
Vram:      +1.87 V  (min =  +1.71 V, max =  +1.89 V)
+3.3V:     +3.22 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.89 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +12.48 V  (min = +11.39 V, max = +12.61 V)
Vbat:      +3.30 V
CPU Fan:  1421 RPM  (min =  600 RPM)
NBr Temp:    +30°C  (low  =   +10°C, high =   +60°C)   sensor = thermistor
CPU Temp:    +26°C  (low  =   +10°C, high =   +70°C)   sensor = diode
vid:      +0.000 V

Which is perfect apart from one thing - the 0.000 V value for VID,  
which is then also throwing off Vcore (in0) as that is calculated from  
VID (>95 <105%).

Can anyone help me work out why VID is reading 0.000?

Thanks



-- 
Simon Wilson
www.simonandkate.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
