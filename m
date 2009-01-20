From: Malcolm Lalkaka <mlalkaka@gmail.com>
Date: Tue, 20 Jan 2009 19:50:45 +0000
Subject: [lm-sensors] Problems with f71882fg and NVIDIA graphics card
Message-Id: <1232481045.6371.77.camel@malcolm>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I ran sensors-detect, and it told me to load the modules coretemp and
f71882fg. I added those to /etc/modules, and restarted my computer.
Although coretemp loaded fine, f71882fg did not. Furthermore, I don't
think it detected the thermal monitor on my NVIDA GeForce 9800 GTX+,
which I know exists because nvidia-settings displays the temperature of
the device.

When I run "sudo modprobe f71882fg", I get the following output:
        FATAL: Error inserting f71882fg
        (/lib/modules/2.6.27-9-generic/kernel/drivers/hwmon/f71882fg.ko): Device or resource busy
The following allows is outputted to dmesg:
        [66032.953156] f71882fg: Not a Fintek device
        [66032.953206] f71882fg: Found F71882FG chip at 0x290, revision
        32
        [66032.953684] f71882fg.656: failed to claim resource 0
        [66032.953687] f71882fg: Device addition failed

The output of sensors-detect is as follows:
        # sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)
        
        This program will help you determine which kernel modules you
        need
        to load to use lm_sensors most effectively. It is generally safe
        and recommended to accept the default answers to all questions,
        unless you know what you're doing.
        
        We can start with probing for (PCI) I2C or SMBus adapters.
        Do you want to probe now? (YES/no): 
        Probing for PCI bus adapters...
        Found unknown SMBus adapter 10de:0aa2 at 0000:00:03.2.
        Sorry, no supported PCI bus adapters found.
        
        If you have undetectable or unsupported I2C/SMBus adapters, you
        can have
        them scanned by manually loading the modules before running this
        script.
        
        To continue, we need module `i2c-dev' to be loaded.
        Do you want to load `i2c-dev' now? (YES/no): 
        Module loaded successfully.
        
        We are now going to do the I2C/SMBus adapter probings. Some
        chips may
        be double detected; we choose the one with the highest
        confidence
        value in that case.
        If you found that the adapter hung after probing a certain
        address,
        you can specify that address to remain unprobed.
        
        Next adapter: NVIDIA i2c adapter  (i2c-0)
        Do you want to scan it? (YES/no/selectively): 
        Client found at address 0x50
        Probing for `Analog Devices ADM1033'...                     No
        Probing for `Analog Devices ADM1034'...                     No
        Probing for `SPD EEPROM'...                                 No
        Probing for `EDID EEPROM'...                                Yes
            (confidence 8, not a hardware monitoring chip)
        
        Next adapter: NVIDIA i2c adapter  (i2c-1)
        Do you want to scan it? (YES/no/selectively): 
        
        Next adapter: NVIDIA i2c adapter  (i2c-2)
        Do you want to scan it? (YES/no/selectively): 
        
        Some chips are also accessible through the ISA I/O ports. We
        have to
        write to arbitrary I/O ports to probe them. This is usually safe
        though.
        Yes, you do have ISA I/O ports even if you do not have any ISA
        slots!
        Do you want to scan the ISA I/O ports? (YES/no): 
        Probing for `National Semiconductor LM78' at 0x290...       No
        Probing for `National Semiconductor LM78-J' at 0x290...     No
        Probing for `National Semiconductor LM79' at 0x290...       No
        Probing for `Winbond W83781D' at 0x290...                   No
        Probing for `Winbond W83782D' at 0x290...                   No
        Probing for `IPMI BMC KCS' at 0xca0...                      No
        Probing for `IPMI BMC SMIC' at 0xca8...                     No
        
        Some Super I/O chips may also contain sensors. We have to write
        to
        standard I/O ports to probe them. This is usually safe.
        Do you want to scan for Super I/O sensors? (YES/no): 
        Probing for Super-I/O at 0x2e/0x2f
        Trying family `National Semiconductor'...                   No
        Trying family `SMSC'...                                     No
        Trying family `VIA/Winbond/Fintek'...                       No
        Trying family `ITE'...                                      No
        Probing for Super-I/O at 0x4e/0x4f
        Trying family `National Semiconductor'...                   No
        Trying family `SMSC'...                                     No
        Trying family `VIA/Winbond/Fintek'...                       Yes
        Found `Fintek F71882FG/F71883FG Super IO Sensors'
        Success!
            (address 0x295, driver `f71882fg')
        
        Some south bridges, CPUs or memory controllers may also contain
        embedded sensors. Do you want to scan for them? (YES/no): 
        Silicon Integrated Systems SIS5595...                       No
        VIA VT82C686 Integrated Sensors...                          No
        VIA VT8231 Integrated Sensors...                            No
        AMD K8 thermal sensors...                                   No
        AMD K10 thermal sensors...                                  No
        Intel Core family thermal sensor...
        Success!
            (driver `coretemp')
        Intel AMB FB-DIMM thermal sensor...                         No
        
        Now follows a summary of the probes I have just done.
        Just press ENTER to continue: 
        
        Driver `f71882fg' (should be inserted):
          Detects correctly:
          * ISA bus, address 0x295
            Chip `Fintek F71882FG/F71883FG Super IO
        Sensors' (confidence: 9)
        
        Driver `coretemp' (should be inserted):
          Detects correctly:
          * Chip `Intel Core family thermal sensor' (confidence: 9)
        
        I will now generate the commands needed to load the required
        modules.
        Just press ENTER to continue: 
        
        To load everything that is needed, add this to /etc/modules:
        
        #----cut here----
        # Chip drivers
        f71882fg
        coretemp
        #----cut here----
        
        Do you want to add these lines automatically? (yes/NO)

The output of "sudo isadump 0x295 0x296":
        WARNING! Running this program can cause system crashes, data
        loss and worse!
        I will probe address register 0x295 and data register 0x296.
        Continue? [Y/n] 
             0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
        00: ff 03 00 00 ff ff ff ff ff ff 00 51 55 4c 00 00 
        10: 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff 
        20: d3 79 5e 79 8d 70 5b d3 c6 ff ff ff ff ff ff ff 
        30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
        40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
        50: ff ff ff ff ff ff ff ff ff ff 03 04 10 19 34 ff 
        60: 00 88 88 00 ff ff 02 00 00 00 ff 06 40 24 ff 00 
        70: ff ff 23 ff 1f ff 7f ff ff ff ff ff ff ff ff ff 
        80: ff ff 64 55 64 55 55 46 ff ff ff ff ff ff a8 ff 
        90: 00 0d 0d 00 00 ff 56 ff 44 22 ff 55 55 55 ff 1a 
        a0: 03 55 00 c8 01 23 3c 32 28 1e ff d9 b2 99 80 0d 
        b0: 04 8f 00 99 02 45 3c 32 28 1e ff d9 b2 99 80 0e 
        c0: 0f ff 00 ff 03 ff 3c 32 28 1e ff d9 b2 99 80 0f 
        d0: 0f ff 00 ff 03 ff 3c 32 28 1e ff d9 b2 99 80 0f 
        e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
        f0: 00 00 00 00 00 00 3b ff 01 6e ff 00 ff ff ff ff

The output of "sudo i2cdetect 0":
        WARNING! This program can confuse your I2C bus, cause data loss
        and worse!
        I will probe file /dev/i2c-0.
        I will probe address range 0x03-0x77.
        Continue? [Y/n] 
             0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
        00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
        10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        30: -- -- -- -- -- -- -- 37 -- -- 3a -- -- -- -- -- 
        40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        70: -- -- -- -- -- -- -- --                         

The output of "sudo i2cdetect 1" and "sudo i2cdetect 2" had no "XX", but
all entries were "--", so I haven't included it here.

The output of "sudo i2cdump 0 0x50":
-----
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 ff ff ff ff ff ff 00 4c 2d e5 03 32 32 57 54    ........L-??22WT
10: 29 12 01 03 80 2f 1e 78 2a ee 91 a3 54 4c 99 26    )????/?x*???TL?&
20: 0f 50 54 bf ef 80 b3 00 81 80 81 40 71 4f 01 01    ?PT????.???@qO??
30: 01 01 01 01 01 01 7c 2e 90 a0 60 1a 1e 40 30 20    ??????|.??`??@0 
40: 36 00 da 28 11 00 00 1a 00 00 00 fd 00 38 4b 1e    6.?(?..?...?.8K?
50: 51 0e 00 0a 20 20 20 20 20 20 00 00 00 fc 00 53    Q?.?      ...?.S
60: 79 6e 63 4d 61 73 74 65 72 0a 20 20 00 00 00 ff    yncMaster?  ....
70: 00 48 56 5a 51 41 30 30 31 31 38 0a 20 20 00 01    .HVZQA00118?  .?
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
-----

The output of "sudo i2cdump 0 0x37" was all "ff", so I haven't included
it here.

The output of "sudo i2cdump 0 0x3a":
-----
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x3a, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: da 81 3a 3d 8e 00 00 00 00 00 e7 00 00 00 00 00    ??:=?.....?.....
10: 00 00 00 00 00 00 00 00 00 00 00 00 2f 00 00 00    ............/...
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
-----

My motherboard is an EVGA nForce 730i. 
I'm using sensors version 3.0.2 with libsensors 3.0.2. 
My Linux kernel version is 2.6.27, compiled for x86_64.

Does anyone know how to solve these problems? I can provide more
information, and can test some things if needed.

Thank you,
Malcolm
mlalkaka@gmail.com



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
