From: Per Jessen <per@computer.org>
Date: Tue, 12 Feb 2008 19:58:43 +0000
Subject: [lm-sensors] Funky temperature readings
Message-Id: <fostpj$q3h$2@saturn.local.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

I've got a new Gigabyte board with the AMD 790FX chipset and an AMD Phenom quad-core CPU.  

After having loaded it87, I get three temperature readings - but the  BIOS itself 
is only showing two.  Is this "normal" ?  The third temp reading is quite 
high - usually 84-86C. 

sensors
it8718-isa-0228
Adapter: ISA adapter
in0:         +1.07 V  (min =  +0.00 V, max =  +4.08 V)
in1:         +1.90 V  (min =  +0.00 V, max =  +4.08 V)
in2:         +3.33 V  (min =  +0.00 V, max =  +4.08 V)
in3:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
in4:         +3.07 V  (min =  +0.00 V, max =  +4.08 V)
in5:         +3.22 V  (min =  +0.00 V, max =  +4.08 V)
in6:         +4.08 V  (min =  +0.00 V, max =  +4.08 V)
in7:         +0.00 V  (min =  +0.00 V, max =  +4.08 V)
in8:         +3.10 V
fan1:       2566 RPM  (min =    0 RPM)
fan2:          0 RPM  (min =    0 RPM)
fan3:       1896 RPM  (min =    0 RPM)
fan5:          0 RPM  (min =    0 RPM)
temp1:       +44.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = transistor
temp2:       +39.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermal diode
temp3:       +84.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = transistor
cpu0_vid:   +0.000 V

sensors-detect reports:

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x228
    Chip `ITE IT8718F Super IO Sensors' (confidence: 9)

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Chip `AMD K10 thermal sensors' (confidence: 9)


/Per Jessen, Zürich


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
