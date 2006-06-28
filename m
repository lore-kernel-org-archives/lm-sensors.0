From: anything@daanwillems.nl (Daan Willems)
Date: Wed, 28 Jun 2006 08:39:43 +0000
Subject: [lm-sensors] nvidia nforce410 chipset / ASUS K8N-VM motherboard
Message-Id: <44A2404F.9030106@daanwillems.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

I subscribed to the list because I am trying to configure lm-sensors for 
my ASUS K8N-VM motherboard, which features a nvidia nforce410 chipset 
(the one with geforce6100 integrated). So far I have good results with 
the w83627ehf kernel module, yielding the following output:

-------
d3vlin at arrakis ~ $ sensors
w83627ehf-isa-0290
Adapter: ISA adapter
Chassis Fan:  1795 RPM  (min = 1205 RPM, div = 8)
CPU Fan:      3245 RPM  (min = 1704 RPM, div = 8)
System Temp:  +28?C  (high =   +60?C, hyst =   +40?C)
CPU Temp:     +30.0?C  (high = +60.0?C, hyst = +40.0?C)
Chipset Temp: +33.0?C  (high = +60.0?C, hyst = +40.0?C)
d3vlin at arrakis ~ $
-------

As one might notice, there is no information about VCore / 3.3V etc. 
displayed. I have tried some modules, i2c_nforce2 in particular, but no 
results. I wonder if there is support for this chipset or if anyone has 
better results. I have included the relevant part of my 
/etc/sensors.conf below.

Best regards,
Daan Willems


-------
chip "w83627ehf-*"

# Fans
   label fan1      "Chassis Fan"
   set fan1_min    1200
   label fan2      "CPU Fan"
   set fan2_min    1700
   ignore fan3
   ignore fan4

# Temperatures
    label temp1     "System Temp"
    label temp2     "CPU Temp"
    label temp3     "Chipset Temp"
    set temp1_over  60
    set temp1_hyst  40
    set temp2_over  60
    set temp2_hyst  40
    set temp3_over  60
    set temp3_hyst  40

# Voltages
    label in0 "+3.3V"
    label in1 "Vtt1.2V"
    label in2 "Vram"
    label in3 "Vchip"
    label in4 "+5V"
    label in5 "+12V"
    label in6 "Vcc1.5V"
    label in7 "Vcore"
    label in8 "5VSB"
-------




