From: Gary Funck <gary@intrepid.com>
Date: Sun, 16 Dec 2007 23:18:48 +0000
Subject: [lm-sensors] w83627hf: invalid limits?
Message-Id: <20071216231848.GA11241@intrepid.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

(Just upgraded to FC8 and noticed unusual output from
the "sensors' command.)

After running sensors-detect, and performing the
indicated insmod and sensors -s command, I see
the following:

# sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.57 V  (min =  +1.34 V, max =  +1.76 V)              
VCore 2:   +1.62 V  (min =  +1.34 V, max =  +1.76 V)              
+3.3V:     +3.25 V  (min =  +2.82 V, max =  +3.79 V)              
+5V:       +4.97 V  (min =  +6.85 V, max =  +4.27 V)       ALARM  
+12V:     +11.98 V  (min = +15.02 V, max = +15.44 V)       ALARM  
-12V:     -11.95 V  (min =  +3.43 V, max =  +4.75 V)       ALARM  
-5V:       -5.10 V  (min =  +4.80 V, max =  +5.10 V)       ALARM  
V5SB:      +5.38 V  (min =  +1.26 V, max =  +6.69 V)              
VBat:      +0.46 V  (min =  +4.05 V, max =  +4.08 V)       ALARM  
fan1:        0 RPM  (min = 1630 RPM, div = 4)              ALARM  
fan2:     3879 RPM  (min =    0 RPM, div = 4)                     
fan3:        0 RPM  (min =    0 RPM, div = 4)                     
temp1:       +32°C  (high =   -17°C, hyst =    -6°C)   sensor = thermistor   ALARM   
temp2:     +33.5°C  (high =  +120°C, hyst =  +115°C)   sensor = thermistor           
temp3:     +27.0°C  (high =  +120°C, hyst =  +115°C)   sensor = thermistor           
vid:      +1.600 V  (VRM Version 9.0)
alarms:   beep_enable: Sound alarm enabled

As you can see in some cases min is less than max, and in
other cases the indicated limit values are just plain wrong.
Any idea what is going on here, or how diagnose and fix the
problem?

Thanks,
  - Gary

----

Configuration 
    kernel: 2.6.23.8-63.fc8
    lm-sensors: lm_sensors-2.10.5-1.fc8
    processor       : 0 vendor_id       : AuthenticAMD
    cpu family      : 6 model           : 10
    model name      : AMD Athlon(tm) XP 2700+
    i2c /dev entries driver
    w83627hf: Found W83627HF chip at 0x290
    w83627hf: Found W83627HF chip at 0x290

sensors-detect output
    Driver `w83627hf' (should be inserted):
      Detects correctly:
      * ISA bus, address 0x290
	Chip `Winbond W83627HF/F/HG/G Super IO Sensors' (confidence: 9)

    I will now generate the commands needed to load the required modules.
    Just press ENTER to continue: 

    To load everything that is needed, add this to some /etc/rc* file:

    #----cut here----
    # Chip drivers
    modprobe w83627hf
    # sleep 2 # optional
    /usr/bin/sensors -s # recommended
    #----cut here----



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
