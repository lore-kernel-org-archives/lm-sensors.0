From: Phillip Pi <philpi@earthlink.net>
Date: Mon, 15 Mar 2010 14:54:42 +0000
Subject: [lm-sensors] "FATAL: Module i2c_nforce2 not found." and "FATAL:
Message-Id: <4B9E4A32.8090405@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again.

I think I broke my lm_sensors or something while trying to make other 
things work. How come my sensors-detect command no longer finds two 
i2c_... modules in my old Debian installation? It used to work a few 
days ago.

# sensors-detect
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: MICRO-STAR INTERNATIONAL CO., LTD MS-7125

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   Success!
     (driver `k8temp')
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Winbond W83627EHF/EF/EHG/EG Super IO Sensors'        Success!
     (address 0x290, driver `w83627ehf')

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-nforce2' for device 0000:00:01.1: nVidia Corporation 
nForce4 SMBus (MCP)
FATAL: Module i2c_nforce2 not found.
Failed to load module i2c-nforce2.
FATAL: Module i2c_dev not found.
Failed to load module i2c-dev.

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83627ehf':
   * ISA bus, address 0x290
     Chip `Winbond W83627EHF/EF/EHG/EG Super IO Sensors' (confidence: 9)

Driver `k8temp':
   * Chip `AMD K8 thermal sensors' (confidence: 9)

Warning: the required module w83627ehf is not currently installed
on your system. If it is built into the kernel then it's OK.
Otherwise, check http://www.lm-sensors.org/wiki/Devices for
driver availability.

Warning: the required module k8temp is not currently installed
on your system. If it is built into the kernel then it's OK.
Otherwise, check http://www.lm-sensors.org/wiki/Devices for
driver availability.

No modules to load, skipping modules configuration.

# locate i2c-nforce2
/lib/modules/2.6.30-2-686/kernel/drivers/i2c/busses/i2c-nforce2-s4985.ko
/lib/modules/2.6.30-2-686/kernel/drivers/i2c/busses/i2c-nforce2.ko
/lib/modules/2.6.32-trunk-686/kernel/drivers/i2c/busses/i2c-nforce2-s4985.ko
/lib/modules/2.6.32-trunk-686/kernel/drivers/i2c/busses/i2c-nforce2.ko
# locate i2c-dev
/lib/modules/2.6.30-2-686/kernel/drivers/i2c/i2c-dev.ko
/lib/modules/2.6.32-trunk-686/kernel/drivers/i2c/i2c-dev.ko
/usr/include/linux/i2c-dev.h
/usr/include/linux/i2c-dev.h.kernel
/usr/share/doc/libi2c-dev
/usr/share/doc/libi2c-dev/changelog.Debian.gz
/usr/share/doc/libi2c-dev/changelog.gz
/usr/share/doc/libi2c-dev/copyright
/usr/share/doc/libi2c-dev/dev-interface.gz
/usr/src/linux-headers-2.6.30-2-common/include/linux/i2c-dev.h
/usr/src/linux-headers-2.6.32-trunk-common/include/linux/i2c-dev.h
/var/cache/apt/archives/libi2c-dev_3.0.2-4_all.deb
/var/lib/dpkg/info/libi2c-dev.list
/var/lib/dpkg/info/libi2c-dev.md5sums
/var/lib/dpkg/info/libi2c-dev.postrm
/var/lib/dpkg/info/libi2c-dev.preinst

# uname -a
Linux foobar 2.6.32-trunk-686 #1 SMP Sun Jan 10 06:32:16 UTC 2010 i686 
GNU/Linux

I tried uninstalling and reinstalling lm_sensors, but that didn't help. 
Thank you in advance. :)
-- 
"Since the world began, we have never exterminated. We probably shall 
never exterminate as much as one single insect species. If there was 
ever an example of an insect we cannot destroy, the fire ant is it." 
--an entomologist quote mentioned by Leonard Nimoy on In The Search Of: 
Deadly Ants (1978)
    /\___/\
   / /\ /\ \        Phil./Ant @ http://antfarm.ma.cx (Personal Web Site)
  | |o   o| |               Ant's Quality Foraged Links: http://aqfl.net
     \ _ /         Nuke ANT from e-mail address: philpi@earthlink.netANT
      ( )                                           or ANTant@zimage.com
Ant is currently not listening to any songs on his home computer.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
