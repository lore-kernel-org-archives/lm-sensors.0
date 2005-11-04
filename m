From: jacques.facquet@free.fr (Jacques Facquet)
Date: Fri, 04 Nov 2005 02:16:22 +0000
Subject: [lm-sensors] problem with w83627hf and kernel-2.6.14
Message-Id: <200511040215.30355.jacques.facquet@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
this driver was working fine with kernel-2.6.9.
I had problem with 2.6.10...2.6.13, so I had a look at the code and 
found this :
in routine :
int w83627hf_detect(struct i2c_adapter *adapter, int address,int kind)

I changed the lines :
	if (!request_region(address, WINB_EXTENT, w83627hf_driver.name)) {
		err = -EBUSY;
		goto ERROR0;
	}
by :
	(void)request_region(address,WINB_EXTENT,w83627hf_driver.name);

Sure, I have a log when I "rmmod" this module, but, I can control the 
fans speed.

So, I did the same thing with kernel-2.6.14 ... failed.
I can't control the fans.
Without modification, the module is loaded (if I remember well) but 
nothing in the /sys/bus/i2c/devices/ directory.

I think of a major modification after kernel-2.6.9.
When request_region() return an error ?
I have nothing else at the address of the chip (I suppose ...)
#sensors
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.48 V  (min =  +0.94 V, max =  +0.96 V)
+12V:     +12.34 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.10 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.01 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)
V5SB:      +4.84 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.33 V  (min =  +2.40 V, max =  +3.60 V)
M/B Fan:  1171 RPM  (min =  750 RPM, div = 8)
CPU Fan:  1622 RPM  (min =  750 RPM, div = 8)
M/B Temp:    +29?C  (high =   +40?C, hyst =   +30?C)   sensor = 
thermistor
CPU Temp:  +40.5?C  (high =   +60?C, hyst =   +45?C)   sensor = diode
temp3:     +28.5?C  (high =   +40?C, hyst =   +30?C)   sensor = 
thermistor

Loading the module at boot time or later give the same effect.
Any idea ?

Thank you.

Regards.

-- 
Jacques Facquet.
