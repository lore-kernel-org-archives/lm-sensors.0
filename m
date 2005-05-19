From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: [fraga@myrealbox.com: w83781d kernel module bug report]
Message-Id: <20040205201634.GB13885@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Daniel Fraga <fraga@myrealbox.com> -----

From: Daniel Fraga <fraga@myrealbox.com>
To: frodol@dds.nl, phil@netroedge.com, mdsxyz123@yahoo.com
Subject: w83781d kernel module bug report
X-Spam-Status: No, hits=0.5 required=5.0 tests=RCVD_IN_RFCI version=2.20
X-Spam-Level: 

        Hi! I upgraded my Linux kernel from 2.6.1 to 2.6.2, but the
temperature now shows incorrectly:

k6-2/500
Motherboard Asus P5A-B 
Linux 2.6.2
gcc 3.3.1

w83781d                29696  0 
i2c_sensor              2624  1 w83781d
i2c_isa                 1760  0 
i2c_core               20996  3 w83781d,i2c_sensor,i2c_isa

fraga@tux ~/src$ sensors
w83781d-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +2.26 V  (min =  +0.00 V, max =  +4.08 V)              
VCore 2:   +2.27 V  (min =  +0.00 V, max =  +4.08 V)              
+3.3V:     +3.60 V  (min =  +2.82 V, max =  +3.79 V)              
+5V:       +5.05 V  (min =  +1.08 V, max =  +0.00 V)       ALARM  
+12V:     +12.34 V  (min =  +0.00 V, max =  +1.03 V)       ALARM  
-12V:     -12.85 V  (min =  -0.89 V, max =  -0.00 V)       ALARM  
-5V:       -5.10 V  (min =  -0.00 V, max =  -0.00 V)       ALARM  
fan1:        0 RPM  (min =   -1 RPM, div = 2)              ALARM  
fan2:        0 RPM  (min = 168750 RPM, div = 2)              ALARM  
fan3:        0 RPM  (min = 10546 RPM, div = 2)              ALARM  
temp1:      +360?C  (high =    +0?C, hyst =    +0?C)          
temp2:    +405.0?C  (high = +1220?C, hyst = +1210?C)          
temp3:    -480.0?C  (high =  +800?C, hyst =  +750?C)          
vid:      +3.500 V
alarms:   
beep_enable:
          Sound alarm disabled

        ***

        It worked fine with 2.6.1, but it seems that some changes
lead to this wrong extremely high temperature. Thanks!

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
