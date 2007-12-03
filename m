From: Keith Romberg <romberg@ucar.edu>
Date: Mon, 03 Dec 2007 13:54:49 +0000
Subject: [lm-sensors] Intel SE7501WV2 Support
Message-Id: <47540AA9.6050406@ucar.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Guys,

Got another one for you.  I have a server based on the Intel SE7501WV2 
motherboard.  It is a dual Xeon system that uses IPMI sensors.  The 
system is running FC7 with the most 'current' unpatched kernel. 
sensors-detect does find some things, but modprobe on ipmisensors fails. 
  I am hoping it is somethign simple like needing to other modules first.
If you need any other info, please let me know.

Thanks,
Keith

Here is the info:

-----------------------------------------------------------------------------

[root@ancalagon ~]# uname -a
Linux ancalagon 2.6.23.1-21.fc7 #1 SMP Thu Nov 1 21:09:24 EDT 2007 i686 
i686 i386 GNU/Linux

[root@ancalagon ~]# sensors-detect
# sensors-detect revision 4966 (2007-10-20 01:41:53 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801CA/CAM ICH3

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 0580 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

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
Probing for `IPMI BMC KCS' at 0xca0...                      Success!
     (confidence 4, driver `ipmisensors')
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC8741x Super IO'
     (no hardware monitoring capabilities)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `ipmisensors' (should be inserted):
   Detects correctly:
   * ISA bus, address 0xca0
     Chip `IPMI BMC KCS' (confidence: 4)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# You must also install and load the IPMI modules
modprobe ipmi-si
# Chip drivers
# Warning: the required module ipmisensors is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe ipmisensors
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):


[root@ancalagon ~]# modprobe ipmi-si
[root@ancalagon ~]# modprobe ipmisensors
FATAL: Module ipmisensors not found.

[root@ancalagon ~]# lspci
00:00.0 Host bridge: Intel Corporation E7501 Memory Controller Hub (rev 01)
00:00.1 Class ff00: Intel Corporation E7500/E7501 Host RASUM Controller 
(rev 01)
00:03.0 PCI bridge: Intel Corporation E7500/E7501 Hub Interface C 
PCI-to-PCI Bri
dge (rev 01)
00:03.1 Class ff00: Intel Corporation E7500/E7501 Hub Interface C RASUM 
Controll
er (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB Controller #1 
(rev 02)
00:1d.1 USB Controller: Intel Corporation 82801CA/CAM USB Controller #2 
(rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corporation 82801CA LPC Interface Controller 
(rev 02)
00:1f.1 IDE interface: Intel Corporation 82801CA Ultra ATA Storage 
Controller (r
ev 02)
00:1f.3 SMBus: Intel Corporation 82801CA/CAM SMBus Controller (rev 02)
01:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
02:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 04)
02:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
02:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 04)
03:07.0 Ethernet controller: Intel Corporation 82546EB Gigabit Ethernet 
Controll
er (Copper) (rev 01)
03:07.1 Ethernet controller: Intel Corporation 82546EB Gigabit Ethernet 
Controll
er (Copper) (rev 01)
04:07.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
04:07.1 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
