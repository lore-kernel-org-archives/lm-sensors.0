From: g1ul10@libero.it (G1ul10)
Date: Sun, 27 Aug 2006 14:06:12 +0000
Subject: [lm-sensors] it8712 on shuttle ST20G5
Message-Id: <20060827160612.9a23709d.g1ul10@libero.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
I've recently installed lm_sensors on my ST20G5. sensors-detect seems
to work properly

#sensors-detect
...
Probing for `ITE IT8712F'
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')
...
Probing for `ITE 8712F Super IO Sensors'
  Success... found at address 0x0290
...

but later I get wrong results from the sensors command. Using
an empty config file I get

#sensors -c /dev/null
it8712-isa-0290
Adapter: ISA adapter
...
fan1:     3515 RPM  (min =    0 RPM, div = 8)          
fan2:        0 RPM  (min = 3013 RPM, div = 8)          
fan3:        0 RPM  (min = 3013 RPM, div = 8)          
M/B Temp:    +44 C  (low  =   +15 C, high =   +40 C)   sensor = thermistor   
CPU Temp:    -55 C  (low  =   -83 C, high =    +7 C)   sensor = thermistor   
Temp3:       -55 C  (low  =   +15 C, high =   +45 C)   sensor = thermistor   

notice that using the default sensors.conf I get the same results.
In the BIOS I typically have

MB temp         45 C
CPU temp        56 C
System temp     43 C
CPU fan speed   1432 RPM
FAN 2 speed        0 RPM
FAN 3 speed     3443 RPM

Any suggestion?

Thanks,
	Giulio.

