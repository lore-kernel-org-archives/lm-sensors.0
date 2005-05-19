From: martin.bene@icomedias.com (Martin Bene)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Ticket # 15731: bmcsensors panics  with Dell Poweredge 1750
Message-Id: <FA095C015271B64E99B197937712FD020B0159@freedom.grz.icomedias.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(kernel panic during i2c_register_entry)

Update: the kernel panic seems to be timing dependant; after adding lots of debug statements + removing most sensors (leaving just the temperature and fan sensors) it mostly finishes proc registration without crashing.

This however leads to a 2nd problem: reading of sensors returns an error (0xce). ignoring that error (same as the 0xca already present) finaly results in display of sensor data.

Sensor names: OK
Fan Sensors: OK
Temp Sensors: some sensors OK (CPU Planar, Ambient), most show bad values. see below.

bmc-ipmi-0000
Adapter: Dummy adapter
Algorithm: Dummy algorithm
Fan 1:    6360 RPM  (min = 1080 RPM)
Fan 2:    6240 RPM  (min = 1080 RPM)
Fan 3:    6240 RPM  (min = 1080 RPM)
Fan 4:    6720 RPM  (min = 1080 RPM)
Fan 5:    6240 RPM  (min = 1080 RPM)
Fan 6:    6360 RPM  (min = 1080 RPM)
Fan 7:    6360 RPM  (min = 1080 RPM)
CPU 1:    -128.0?C  (high =   +80?C, hyst =  +207?C)
CPU 2:     -72.0?C  (high =   +80?C, hyst =  +207?C)
CPU 3:     -96.0?C  (high =   +80?C, hyst =  +207?C)
CPU 4:     -26.0?C  (high =   +80?C, hyst =  +207?C)
CPU Planar:
           +41.0?C  (high =   +55?C, hyst =  +182?C)
Ambient:   +29.0?C  (high =   +40?C, hyst =  +167?C)
Memy Card A:
           -76.0?C  (high =   +55?C, hyst =  +182?C)
Memory Card B:
           -72.0?C  (high =   +55?C, hyst =  +182?C)
I/O Planar:
           -76.0?C  (high =   +55?C, hyst =  +182?C)
PSDB:      -75.0?C  (high =   +55?C, hyst =  +182?C)

Any indeas, both wrt. crash and wrt. bad values?

Thanks. Martin
