From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 02 Sep 2006 16:57:48 +0000
Subject: [lm-sensors] [RFC] Generic device detection in sensors-detect
Message-Id: <4dfa50520609020957n620ab6ddxbc5347f5e858d83f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060902172512.960d5eca.khali@linux-fr.org>
In-Reply-To: <20060902172512.960d5eca.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Here are the results for my system (nForce4 SMBus and W83627EHF)

>   We can start with probing for (PCI) I2C or SMBus adapters.
>   Do you want to probe now? (YES/no):
>   Probing for PCI bus adapters...
>   Found unknown SMBus adapter 8086:2483 at 00:1f:3.

# sensors-detect revision $Revision$

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Found unknown SMBus adapter 10de:0264 at 00:0a:1.

We will now try to load each adapter module in turn.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no): y
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

>   Some Super I/O chips may also contain sensors. We have to write to
>   standard I/O ports to probe them. This is usually safe.
>   Do you want to scan for Super I/O sensors? (YES/no):
>   Probing for Super-I/O at 0x2e/0x2f
>   Trying family `ITE'...                                      No
>   Trying family `National Semiconductor'...                   No
>   Trying family `SMSC'...                                     No
>   Trying family `VIA/Winbond/Fintek'...                       No
>   Probing for Super-I/O at 0x4e/0x4f
>   Trying family `ITE'...                                      No
>   Trying family `National Semiconductor'...                   No
>   Trying family `SMSC'...                                     No
>   Trying family `VIA/Winbond/Fintek'...                       Yes
>   Found unknown chip with ID 0x0406
>       (logical device 4 has address 0x295, could be sensors)
>
# sensors-detect revision $Revision$

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:0a.1: nVidia Corporation
nForce4 SMBus (MCP51)
Probe successfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no): n
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
Do you want to scan the ISA I/O ports? (YES/no): y
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Winbond W83627EHF' at 0x290...                 Success!
   (confidence 8, driver `w83627ehf')
Probing for `Winbond W83627DHG' at 0x290...                 No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     Success!
   (confidence 9, driver `k8temp')
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found unknown chip with ID 0x8863
   (logical device B has address 0x290, could be sensors)
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83627ehf' (should be inserted):
 Detects correctly:
 * ISA bus address 0x0290 (Busdriver `i2c-isa')
   Chip `Winbond W83627EHF' (confidence: 8)

Driver `k8temp' (should be inserted):
 Detects correctly:
 * ISA bus, undetermined address (Busdriver `i2c-isa')
   Chip `AMD K8 thermal sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# Chip drivers
modprobe w83627ehf
# Warning: the required module k8temp is not currently installed
# on your system. For status of 2.6 kernel ports see
# http://www.lm-sensors.org/wiki/SupportedDevices and
# http://www.lm-sensors.org/wiki/NewDrivers. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe k8temp
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): n





David

