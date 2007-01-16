From: peter_s_d@fastmail.com.au (Peter D.)
Date: Tue, 16 Jan 2007 13:35:29 +0000
Subject: [lm-sensors] IT8716F
Message-Id: <200701170035.29308.peter_s_d@fastmail.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

I have a mother board with an IT8716F on it.  

Your data sheets page <http://www.lm-sensors.org/wiki/DataSheets> does not 
mention the IT8716F.  Here is a link, 
<http://www.ite.com.tw/product_info/PC/Brief-IT8716_2.asp> which point to a 
zip of a pdf of the data sheet itself.  

I've just tried lm-sensors 2.10.2 against kernel 2.6.19.2.  It is 
working.  :-)  But it might need some configuration.  

->sensors
it8716-isa-0290
Adapter: ISA adapter
in0:       +1.10 V  (min =  +0.00 V, max =  +4.08 V)
in1:       +3.23 V  (min =  +0.00 V, max =  +4.08 V)
in2:       +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
in3:       +2.85 V  (min =  +0.00 V, max =  +4.08 V)
in4:       +2.82 V  (min =  +0.00 V, max =  +4.08 V)
in5:       +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
in6:       +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
in7:       +2.80 V  (min =  +0.00 V, max =  +4.08 V)
in8:       +2.94 V
fan1:     2242 RPM  (min =    0 RPM)
fan2:        0 RPM  (min =    0 RPM)
fan3:        0 RPM  (min =    0 RPM)
temp1:       +38?C  (low  =    -1?C, high =  +127?C)   sensor = diode
temp2:       +41?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
temp3:        -2?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
vid:      +1.250 V

There are a few zeros in there.  That could be ASUS's fault.  

The motherboard is an ASUS M2N-E which has an nForce 570 Ultra.  


-- 
sig goes here...
Peter D.

