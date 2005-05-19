From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: Problem with eeprom module in 2.9.0
Message-Id: <41DDAE4F.9030606@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As you can see, I've been doing a lot of testing of sensors lately...

I have a number of servers that have been running the CVS version of i2c 
and lm_sensors downloaded on October 25, 2004, plus the patch to add 
DDR2 support.   This release of sensors has performed well.

I'm now trying to upgrade the version of sensors on these servers to 
2.9.1 for i2c and 2.9.0 plus the bmcsensors.c patch.   The servers are 
running Red Hat 9 (2.4.20-31.9.0bigmem with a few patches to add 
additional hardware support).  This same version of kernel is used for 
both versions of lm_sensors and for both versions of server that I will 
be discussing.

The lm87 and lm93 drivers are working OK, but the eeprom driver in 2.9.0 
really does not like our newest servers. On the failing servers (Dual 
XEON 3.2 Ghz, E7520 chipset, DDR2 memory), sensors stops providing 
useful information as soon as the eeprom driver is loaded.

I loaded the appropriate drivers:
i2c-core i2c-dev i2c-proc i2c-i801 eeprom

Running sensors gives bogus output:
# sensors
eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 0540
Unknown EEPROM type (255).

eeprom-i2c-0-57
Adapter: SMBus I801 adapter at 0540
Unknown EEPROM type (255).

Running this command logs the following message to dmesg:
PCI device 8086:25a4 (Intel Corp.): Reset failed! (21)
eeprom.o: block read fail at 0x00!

Removing modules using rmmod runs without error, but
when the eeprom module is reloaded, it does not find any i2c devices.

I then rebooted the server to get the i2c bus working again (which worked).

I have 2.9.0 on a different server family (Dual XEON 2.4 Ghz, E7501 
chipset, DDR memory) and the eeprom driver works fine.

I then decided to see what would happen if I loaded the lm87, the lm93 
and the eeprom driver on the failing server.

The first time I ran sensors after loading the drivers (fan errors are 
expected):
# sensors

Adapter: SMBus I801 adapter at 0540
mon0,+V1_8:
            +1.80 V  (min =  +1.72 V, max =  +1.88 V)
mon0,+V3_3:
            +3.27 V  (min =  +3.16 V, max =  +3.44 V)
mon0,+V5_pci:
            +5.00 V  (min =  +4.74 V, max =  +5.26 V)
mon0,+V12:+12.06 V  (min = +11.38 V, max = +12.63 V)
mon0,Fan_C1:
              0 RPM  (min = 1394 RPM, div = 8)          ALARM
mon0,Fan_C2:
              0 RPM  (min = 1394 RPM, div = 8)          ALARM
mon0,AmbT:   +26C  (low  =    +0C, high =   +60C)
mon0,amb_cpu0_temp:
              +30C  (low  =    +0C, high =   +60C)
mon0,amb_ddr_temp:
              +36C  (low  =    +0C, high =   +65C)

lm93-i2c-0-2e
Adapter: SMBus I801 adapter at 0540
mon1,+V1.5:
            +1.49 V  (min =  +1.42 V, max =  +1.57 V)
mon1,VCC_CPU0:
            +1.36 V  (min =  +0.00 V, max =  +1.60 V)
mon1,VCC_CPU1:
            +1.36 V  (min =  +0.00 V, max =  +1.60 V)
mon1,battv_mon:
            +3.12 V  (min =  +2.00 V, max =  +3.30 V)
mon1,+V5_0:
            +5.09 V  (min =  +4.75 V, max =  +5.25 V)
mon1,VTT:  +1.20 V  (min =  +1.13 V, max =  +1.26 V)
mon1,+V3_3:
            +3.29 V  (min =  +3.14 V, max =  +3.46 V)
mon1,Fan_A1:
              0 RPM  (min = 1398 RPM)                       ALARM
mon1,Fan_A2:
              0 RPM  (min = 1398 RPM)                       ALARM
mon1,Fan_B1:
              0 RPM  (min = 1398 RPM)                       ALARM
mon1,Fan_B2:
              0 RPM  (min = 1398 RPM)                       ALARM
mon1,cpu0:   +29C  (low  =    +0C, high =   +80C)
mon1,cpu1:   +34C  (low  =    +0C, high =   +80C)
mon1,AmbT:   +32C  (low  =    +0C, high =   +65C)
mon1,CPU0_VID:
           +1.387 V
mon1,CPU1_VID:
           +1.387 V

eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 0540
Unknown EEPROM type (255).

eeprom-i2c-0-57
Adapter: SMBus I801 adapter at 0540
Unknown EEPROM type (255).

I then reran sensors:
# sensors
lm87-i2c-0-2d
Adapter: SMBus I801 adapter at 0540
mon0,+V1_8:
            +0.00 V  (min =  +0.00 V, max =  +0.00 V)
mon0,+V3_3:
            +0.00 V  (min =  +0.00 V, max =  +0.00 V)
mon0,+V5_pci:
            +0.00 V  (min =  +0.00 V, max =  +0.00 V)
mon0,+V12: +0.00 V  (min =  +0.00 V, max =  +0.00 V)
mon0,Fan_C1:
             -1 RPM  (min =   -1 RPM, div = 1)
mon0,Fan_C2:
             -1 RPM  (min =   -1 RPM, div = 1)
mon0,AmbT:    +0C  (low  =    +0C, high =    +0C)
mon0,amb_cpu0_temp:
               +0C  (low  =    +0C, high =    +0C)
mon0,amb_ddr_temp:
               +0C  (low  =    +0C, high =    +0C)

lm93-i2c-0-2e
Adapter: SMBus I801 adapter at 0540
mon1,+V1.5:
            +1.49 V  (min =  +1.42 V, max =  +1.57 V)
mon1,VCC_CPU0:
            +1.36 V  (min =  +0.00 V, max =  +1.60 V)
mon1,VCC_CPU1:
            +1.36 V  (min =  +0.00 V, max =  +1.60 V)
mon1,battv_mon:
            +3.12 V  (min =  +2.00 V, max =  +3.30 V)
mon1,+V5_0:
            +5.09 V  (min =  +4.75 V, max =  +5.25 V)
mon1,VTT:  +1.20 V  (min =  +1.13 V, max =  +1.26 V)
mon1,+V3_3:
            +3.29 V  (min =  +3.14 V, max =  +3.46 V)
mon1,Fan_A1:
              0 RPM  (min = 1398 RPM)                       ALARM
mon1,Fan_A2:
              0 RPM  (min = 1398 RPM)                       ALARM
mon1,Fan_B1:
              0 RPM  (min = 1398 RPM)                       ALARM
mon1,Fan_B2:
              0 RPM  (min = 1398 RPM)                       ALARM
mon1,cpu0:   +29C  (low  =    +0C, high =    +0C)
mon1,cpu1:   +34C  (low  =    +0C, high =    +0C)
mon1,AmbT:   +32C  (low  =    +0C, high =    +0C)
mon1,CPU0_VID:
           +1.087 V
mon1,CPU1_VID:
           +1.087 V

eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 0540
Unknown EEPROM type (255).

eeprom-i2c-0-57
Adapter: SMBus I801 adapter at 0540
Unknown EEPROM type (255).

At this point /var/log/messages is filled with errors such as this:
Jan  6 11:49:04 gateway653 kernel: lm87.o: All read byte retries failed!!
Jan  6 11:49:04 gateway653 kernel: lm87.o: Read byte data failed, 
address 0x42
Jan  6 11:49:04 gateway653 last message repeated 4 times
Jan  6 11:49:04 gateway653 kernel: lm87.o: All read byte retries failed!!
Jan  6 11:49:04 gateway653 kernel: lm87.o: Read byte data failed, 
address 0x19
Jan  6 11:49:04 gateway653 last message repeated 4 times
Jan  6 11:49:04 gateway653 kernel: lm87.o: All read byte retries failed!!
Jan  6 11:49:04 gateway653 kernel: PCI device 8086:25a4 (Intel Corp.): 
Reset failed! (21)
Jan  6 11:49:04 gateway653 kernel: lm93.o: block read data failed, 
command 0xf5.
Jan  6 11:49:04 gateway653 kernel: PCI device 8086:25a4 (Intel Corp.): 
Reset failed! (21)
Jan  6 11:49:04 gateway653 kernel: lm93.o: block read data failed, 
command 0xf5.
Jan  6 11:49:04 gateway653 kernel: PCI device 8086:25a4 (Intel Corp.): 
Reset failed! (21)
Jan  6 11:49:04 gateway653 kernel: lm93.o: block read data failed, 
command 0xf5

Thanks for any help or guidance you can provide.

David
