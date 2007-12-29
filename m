From: kaj72 <kaj72@freenet.de>
Date: Sat, 29 Dec 2007 17:14:53 +0000
Subject: [lm-sensors] Intel D201GLY2, Winbond W83627DHG-B
Message-Id: <4776808D.80202@freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I recently bought the Intel D201GLY2 board with soldered down Intel 
Celeron processor 220 (passively cooled).
Details: http://www.intel.com/products/motherboard/D201GLY2/index.htm
Referring to Intel it uses the "Winbond W83627DHG-B based Legacy I/O 
controller for hardware management, serial, parallel, and PS/2 ports".

Unfortunately I can't get any sensors information.

Here is the output of 'sensors-detect' rev. 5085:

   # ./sensors-detect
   # sensors-detect revision $Revision$

   This program will help you determine which kernel modules you need
   to load to use lm_sensors most effectively. It is generally safe
   and recommended to accept the default answers to all questions,
   unless you know what you're doing.

   We can start with probing for (PCI) I2C or SMBus adapters.
   Do you want to probe now? (YES/no):
   Probing for PCI bus adapters...
   Sorry, no known PCI bus adapters found.

   We will now try to load each adapter module in turn.
   If you have undetectable or unsupported adapters, you can have them
   scanned by manually loading the modules before running this script.

   We are now going to do the I2C/SMBus adapter probings. Some chips may
   be double detected; we choose the one with the highest confidence
   value in that case.
   If you found that the adapter hung after probing a certain address,
   you can specify that address to remain unprobed.

   Some chips are also accessible through the ISA I/O ports. We have to
   write to arbitrary I/O ports to probe them. This is usually safe though.
   Yes, you do have ISA I/O ports even if you do not have any ISA slots!
   Do you want to scan the ISA I/O ports? (YES/no):
   Probing for `National Semiconductor LM78' at 0x290...       No
   Probing for `National Semiconductor LM78-J' at 0x290...     No
   Probing for `National Semiconductor LM79' at 0x290...       No
   Probing for `Winbond W83781D' at 0x290...                   No
   Probing for `Winbond W83782D' at 0x290...                   No
   Probing for `Silicon Integrated Systems SIS5595'...         No
   Probing for `VIA VT82C686 Integrated Sensors'...            No
   Probing for `VIA VT8231 Integrated Sensors'...              No
   Probing for `IPMI BMC KCS' at 0xca0...                      No
   Probing for `IPMI BMC SMIC' at 0xca8...                     No

   Some Super I/O chips may also contain sensors. We have to write to
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
   Found `Winbond W83627DHG Super IO Sensors'                  Success!
       (address 0x290, driver `w83627ehf')

   Some CPUs or memory controllers may also contain embedded sensors.
   Do you want to scan for them? (YES/no):
   AMD K8 thermal sensors...                                   No
   AMD K10 thermal sensors...                                  No
   Intel Core family thermal sensor...                         Success!
       (driver `coretemp')
   Intel AMB FB-DIMM thermal sensor...                         No

   Now follows a summary of the probes I have just done.
   Just press ENTER to continue:

   Driver `w83627ehf' (should be inserted):
     Detects correctly:
     * ISA bus, address 0x290
       Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)

   Driver `coretemp' (should be inserted):
     Detects correctly:
     * Chip `Intel Core family thermal sensor' (confidence: 9)

   Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
   To load everything that is needed, add this to one of the system
   initialization scripts (e.g. /etc/rc.d/rc.local):

   #----cut here----
   # Chip drivers
   modprobe w83627ehf
   modprobe coretemp
   /usr/bin/sensors -s
   #----cut here----

   If you have some drivers built into your kernel, the list above will
   contain too many modules. Skip the appropriate ones! You really
   should try these commands right now to make sure everything is
   working properly. Monitoring programs won't work until the needed
   modules are loaded.

Loading the module 'w83627ehf' writes "kernel: w83627ehf: unsupported 
chip ID: 0xffff" to /var/log/syslog.
'sensors' 2.10.1 returns an error.
   # sensors
   w83627dhg-i2c-9191-290
    ERROR: Can't get adapter or algorithm?!?

Loading the module 'coretemp' fails:
   # modprobe coretemp
   FATAL: Error inserting coretemp 
(/lib/modules/2.6.22-3-686/kernel/drivers/hwmon/coretemp.ko): No such device

I'm running Debian 4.0/stable with backported kernel 2.6.22-3-686.

Any way to retrieve sensor data?
Any more information I can provide?


Best regards,
Juergen

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
