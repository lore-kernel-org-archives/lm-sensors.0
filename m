From: "lists@givemefish.com" <lists@givemefish.com>
Date: Tue, 18 Mar 2008 11:17:38 +0000
Subject: [lm-sensors] Strange temperature values
Message-Id: <47DFA4D2.1060009@givemefish.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

lm-sensors folks,

we installed the lm-sensors package and now have the kernel modules
loaded and can type "sensors" to get a listing of sensor values.

However, the sensor values that we see are very strange.  They are all
positive values, but they range from 0 to 2500 C.

We have 2 Xeon quad-core on Intel Server Board S5000PSL.

The sensors output is copied below:

bmc-isa-0020
Adapter: ISA adapter
in1:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
in2:       +1.14 V  (min =  +0.00 V, max =  +0.00 V)
in3:       +1.14 V  (min =  +0.81 V, max =  +0.98 V)
in4:       +0.17 V  (min = +10.42 V, max = +13.58 V)
in5:      +11.59 V  (min =  +4.45 V, max =  +5.56 V)
in6:       +4.99 V  (min =  +1.36 V, max =  +1.64 V)
in7:       +1.52 V  (min =  +3.03 V, max =  +3.61 V)
in8:       +3.29 V  (min =  +2.94 V, max =  +3.68 V)
in9:       +3.30 V  (min =  +1.64 V, max =  +1.99 V)
in10:      +2.00 V  (min =  +1.33 V, max =  +1.68 V)
fan1:     12740 RPM  (min =  630 RPM)
fan2:      594 RPM  (min =  330 RPM)
fan3:     1980 RPM  (min =  330 RPM)
temp1:     +71.0°C  (high =   +50°C, hyst =    +0°C)
temp2:      +0.0°C  (high =   +50°C, hyst =    +0°C)
temp3:      +0.0°C  (high =    +0°C, hyst =    +2°C)
temp4:    +1780.0°C  (high =    +0°C, hyst =    +2°C)
temp5:    +1860.0°C  (high =    +0°C, hyst =    +2°C)
temp6:    +1940.0°C  (high =    +0°C, hyst =    +2°C)
temp7:    +720.0°C  (high =    +8°C, hyst =    +0°C)
temp8:    +2520.0°C  (high =   +66°C, hyst =    +2°C)

The dmesg log is as follows:

ipmisensors: starting update
ipmisensors: Send 0x2d 0xd1 0x0
ipmisensors: Send 0x2d 0xd0 0x0
ipmisensors: received message
ipmisensors: sensor 208 (type 2) reading 182
ipmisensors: Send 0x2d 0xc1 0x0
ipmisensors: received message
ipmisensors: sensor 193 (type 1) reading 181
ipmisensors: Send 0x2d 0xc0 0x0
ipmisensors: received message
ipmisensors: sensor 192 (type 1) reading 0
ipmisensors: Send 0x2d 0x9d 0x0
ipmisensors: received message
ipmisensors: sensor 157 (type 1) reading 0
ipmisensors: Send 0x2d 0x9c 0x0
ipmisensors: received message
ipmisensors: sensor 156 (type 1) reading 178
ipmisensors: Send 0x2d 0x9b 0x0
ipmisensors: received message
ipmisensors: sensor 155 (type 1) reading 187
ipmisensors: Send 0x2d 0x99 0x0
ipmisensors: received message
ipmisensors: sensor 153 (type 1) reading 194
ipmisensors: Send 0x2d 0x56 0x0
ipmisensors: received message
ipmisensors: sensor 86 (type 4) reading 183
ipmisensors: Send 0x2d 0x51 0x0
ipmisensors: received message
ipmisensors: sensor 81 (type 4) reading 18
ipmisensors: Send 0x2d 0x50 0x0
ipmisensors: received message
ipmisensors: sensor 80 (type 4) reading 59
ipmisensors: Send 0x2d 0x48 0x0
ipmisensors: received message
ipmisensors: sensor 72 (type 1) reading 71
ipmisensors: Send 0x2d 0x30 0x0
ipmisensors: received message
ipmisensors: sensor 48 (type 1) reading 250
ipmisensors: Send 0x2d 0x1b 0x0
ipmisensors: received message
ipmisensors: sensor 27 (type 2) reading 35
ipmisensors: Send 0x2d 0x1a 0x0
ipmisensors: received message
ipmisensors: sensor 26 (type 2) reading 187
ipmisensors: Send 0x2d 0x18 0x0
ipmisensors: received message
ipmisensors: sensor 24 (type 2) reading 192
ipmisensors: Send 0x2d 0x17 0x0
ipmisensors: received message
ipmisensors: sensor 23 (type 2) reading 195
ipmisensors: Send 0x2d 0x16 0x0
ipmisensors: received message
ipmisensors: sensor 22 (type 2) reading 191
ipmisensors: Send 0x2d 0x15 0x0
ipmisensors: received message
ipmisensors: sensor 21 (type 2) reading 192
ipmisensors: Send 0x2d 0x14 0x0
ipmisensors: received message
ipmisensors: sensor 20 (type 2) reading 194
ipmisensors: Send 0x2d 0x13 0x0
ipmisensors: received message
ipmisensors: sensor 19 (type 2) reading 174
ipmisensors: Send 0x2d 0x12 0x0
ipmisensors: received message
ipmisensors: sensor 18 (type 2) reading 113
ipmisensors: Send 0x2d 0x10 0x0
ipmisensors: received message
ipmisensors: sensor 16 (type 2) reading 191
ipmisensors: received message
ipmisensors: sensor 16 (type 2) reading 174
ipmisensors: update complete
ipmisensors: starting update

---------------------
And the sensors detect output:

# sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel Enterprise
Southbridge -
ESB2

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded successfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 3000
Do you want to scan it? (YES/no/selectively):

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     No
Probing for `IPMI BMC KCS' at 0xca0...                      Success!
    (confidence 4, driver `bmcsensors')
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0xf211
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC87427 Super IO Fan Sensors'
    (but not activated)
Found `Nat. Semi. PC87427 Super IO Health Sensors'
    (but not activated)
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0xf211
Trying family `VIA/Winbond/Fintek'...                       Yes
Found unknown chip with ID 0xf211
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `bmcsensors' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0ca0 (Busdriver `i2c-isa')
    Chip `IPMI BMC KCS' (confidence: 4)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# You must also install and load the IPMI modules
modprobe i2c-ipmi
# Chip drivers
# Warning: the required module bmcsensors is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe bmcsensors
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.



========

Do we need to scale these values?  And if so, how?

Or any other ideas would be great.

Thanks for your help,
Matt & Max.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
