From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: bmcsensors and strange sensor values.
Message-Id: <413E4662.2040800@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A0FF82385BEB4C8670E255530B338527B4CE@mssydeb.asi.com.au>
In-Reply-To: <45A0FF82385BEB4C8670E255530B338527B4CE@mssydeb.asi.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

your modules are fine.

Non-linear function 7 is 1/x, according to the IPMI spec, which can be handled without floating point, so
support could be added. Feel free to send a patch. You'll need the IPMI spec for reference.
You're the first to report this.

The voltages look fine. the voltage limits are too far away from the nominal to be useful but that
may just be the way the BMC is programmed. Perhaps the 'non-critical thresholds' would be better for you.
That would take a bmcsensors.c mod.

The temp. hysteresis value isn't present, I don't think (the module looks for this first), so the module is using the lower temperature limit,
but the 'sensors' program is reporting it as a hysteresis (it assumes the vaule will be a hysteresis value). 
You'll have to change 'sensors' to report it correctly.

mds


Peter Wilsmore wrote:
> Hi,
>  
> I have been struggling with patching RHEL kernel 2.4.21 with lm-sensors so I can read the temperature/fan/voltage readings from a MSI-9549 M/B which according to a spec sheet from MSI uses IPMI1.5 with a bmc chip with all the standard values. I have finnally managed to get lm-sensors to compile against 2.4.21-EL. I have loaded all the drivers that are recommended from sensors-detect and a few others that I have read are required for the bmcsensors module to work:-
>  
> The relivent bits from sensors-detect are: 
>  
> Driver `bmcsensors' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0ca0 (Busdriver `i2c-isa')
>     Chip `IPMI BMC KCS' (confidence: 4)
>  
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-amd756
> modprobe i2c-isa
> # I2C chip drivers
> modprobe eeprom
> modprobe bmcsensors
> # sleep 2 # optional
> /usr/local/bin/sensors -s # recommended
>  
> So I have loaded the following modules:
>  
> bmcsensors
> i2c-proc
> ipmi_kcs_drv
> i2c-isa
> i2c-ipmi
> ipmi_msghandler
> i2c-dev
> i2c-amd756
> i2c-core
>  
> but /var/log/messages reports:
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 14: nonlinear function 0x07 unsupported, expect bad results
>  
> for all the fan sensors, and comes back with strange results for most of the rest of the values:
>  
> bmc-ipmi-0000
> Adapter: Dummy adapter
> in1:       +8.00 V  (min =  +2.02 V, max = +14.11 V)
> in2:       +1.52 V  (min =  +0.38 V, max =  +2.69 V)
> in3:       +1.65 V  (min =  +0.42 V, max =  +2.91 V)
> in4:       +3.30 V  (min =  +0.83 V, max =  +5.82 V)
> in5:       +1.52 V  (min =  +0.38 V, max =  +2.69 V)
> in6:       +2.57 V  (min =  +0.42 V, max =  +2.91 V)
> in7:       +5.07 V  (min =  +0.83 V, max =  +5.82 V)
> fan1:        0 RPM  (min =    0 RPM)
> fan2:        0 RPM  (min =    0 RPM)
> fan3:        0 RPM  (min =    0 RPM)
> fan4:        0 RPM  (min =    0 RPM)
> fan5:        0 RPM  (min =    0 RPM)
> temp1:      +0.0?C  (high =   +48?C, hyst =    +5?C)
> temp2:     +20.0?C  (high =   +48?C, hyst =    +5?C)
> temp3:     +46.0?C  (high =   +97?C, hyst =    +5?C)
> temp4:     +49.0?C  (high =   +97?C, hyst =    +5?C)
> 
> I have tried both lm-sensors 2.8.7 and the cvs version from the web site.
> 
> I am wondering if anyone can suggest how I can get lm-sensors to properly detect the values. Is there a module I am missing or some way of reading the values using the i2c-ipmb module? The sensors.conf file says that I don't need compute lines for bmcsensors, but do I need to add them? Can I include support for nonlinear functions on the bmcsensors modules easily? I have a pdf called MSI9549_IPMI_Spec from MSI if that might help, but it doesn't seem to have any details about the sensor values and it's 78 pages and a few meg so I haven't attached it..
>  
> Any suggestions would be greatly appreciated.
>  
> thanks,
>  
> Peter
> 
> 
> ------------------------------------------------------------------------
> 
> Sep  6 03:51:43 compute-0-0 kernel: i2c-amd756.o version 2.8.7 (20040611)
> Sep  6 03:51:43 compute-0-0 kernel: bmcsensors.o: attach_adapter...
> Sep  6 03:51:43 compute-0-0 kernel: bmcsensors.o: attach_adapter, expected 0xb0000, got 0x40000
> Sep  6 03:51:43 compute-0-0 kernel: i2c-dev.o: i2c /dev entries driver module version 2.8.7 (20040611)
> Sep  6 03:51:43 compute-0-0 kernel: i2c-dev.o: Registered 'ISA main adapter' as minor 0
> Sep  6 03:51:43 compute-0-0 kernel: i2c-dev.o: Registered 'IPMI adapter' as minor 1
> Sep  6 03:51:43 compute-0-0 kernel: i2c-dev.o: Registered 'SMBus AMD756 adapter at 80e0' as minor 2
> Sep  6 03:54:50 compute-0-0 kernel: bmcsensors.o sleeping a while
> Sep  6 03:54:52 compute-0-0 kernel: bmcsensors.o sleeping again
> Sep  6 03:54:54 compute-0-0 kernel: bmcsensors.o i2c cleanup
> Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o version 2.8.7 (20040611)
> Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: attach_adapter...
> Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: attach_adapter, expected 0xb0000, got 0x50000
> Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: attach_adapter...
> Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: Registered client, scanning for sensors...
> Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: reserve_sdr...
> Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: attach_adapter...
> Sep  6 03:55:12 compute-0-0 kernel: bmcsensors.o: attach_adapter, expected 0xb0000, got 0x40000
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: all sensors detected
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: building proc table
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 0: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label temp1 "TMP_S1"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 1: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label temp2 "TMP_S2"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 2: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label temp3 "TMP_P1"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 3: (type 0x01) (fmt=0; m=1; b=0; k1=0; k2=0; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label temp4 "TMP_P0"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 4: (type 0x02) (fmt=0; mc; b=0; k1=0; k2; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in1 "VLT12"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 5: (type 0x02) (fmt=0; m; b=0; k1=0; k2; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in2 "P1Vcpp"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 6: (type 0x02) (fmt=0; m; b=0; k1=0; k2; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in3 "P1V2.5"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 7: (type 0x02) (fmt=0; m&; b=0; k1=0; k2; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in4 "VSB5.0"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 8: (type 0x02) (fmt=0; m; b=0; k1=0; k2; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in5 "P0Vcpp"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 9: (type 0x02) (fmt=0; m; b=0; k1=0; k2; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in6 "P0V2.5"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 10: (type 0x02) (fmt=0; m&; b=0; k1=0; k2; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label in7 "VLT5.0"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 11: (type 0x04) (fmt=0; m); b=0; k1=0; k2=9; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label fan1 "FAN_S2"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 11: nonlinear function 0x07 unsupported, expect bad results
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 12: (type 0x04) (fmt=0; m); b=0; k1=0; k2=9; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label fan2 "FAN_S4"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 12: nonlinear function 0x07 unsupported, expect bad results
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 13: (type 0x04) (fmt=0; m); b=0; k1=0; k2=9; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label fan3 "FAN_S1"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 13: nonlinear function 0x07 unsupported, expect bad results
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 14: (type 0x04) (fmt=0; m); b=0; k1=0; k2=9; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label fan4 "FAN_S3"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 14: nonlinear function 0x07 unsupported, expect bad results
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registering sensor 15: (type 0x04) (fmt=0; m); b=0; k1=0; k2=9; cap=0x76; mask=0xffff)
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensors.conf: label fan5 "FAN_S5"
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using upper critical threshold for upper limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: using lower critical threshold for lower limit
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: sensor 15: nonlinear function 0x07 unsupported, expect bad results
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: 0 reservations cancelled
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: registered 4 temp, 7 volt, 0 current, 5 fan sensors
> Sep  6 03:55:37 compute-0-0 kernel: bmcsensors.o: bmcsensor thread done
> 
