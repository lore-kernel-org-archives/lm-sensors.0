From: brianwc@berkeley.edu (Brian C)
Date: Fri, 28 Jul 2006 18:57:26 +0000
Subject: [lm-sensors] Macs with Intel 82801G (ICH7 Family)
Message-Id: <44CA5E16.9070208@berkeley.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060728203712.da818e24.khali@linux-fr.org>
In-Reply-To: <20060728203712.da818e24.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for the reply. Two things. First, there is a GPL program called
SpeedIt that is apparently able to provide CPU temperature under OS X on
the Intel Macs. http://speedit.increw.org/trac.cgi/wiki/SpeedIt So,
while I don't know how it works I would think there have to be some sort
of hardware sensors on this board. Second, I'll include the full output
of sensors-detect below, per your request.

Jean Delvare wrote:
> Hi Brian,
> 
> Moving to the sensors list, as I see no i2c bug/problem here.
> 
>> It seems that all the Macs (MacBook, MacBook Pro, iMac, Mac Mini) with
>> Intel chips use this 82801G chip.
>>
>> See: http://www.mactel-linux.org/wiki/Lspci
>>
>> I cannot get sensors-detect to detect anything. I'd particularly like to
>> monitor CPU temperature, if that's possible. Fan speed would be good too.
>>
>> Here's some relevant output. Thanks for any help.
>>
>> Some output from sensors-detect is currently at:
>> http://wiki.debian.org/MacBook
> 
> It shows no hardware monitoring chips on the SMBus. There are chips at
> addresses 0x38 and 0x3a, it's uncommon, I wonder what chips this can
> be. The ISA and Super-I/O probes are skipped so I can't comment on
> that. Please provide the complete output of sensors-detect on your
> system.

The first time I ran sensors-detect I got:

...
Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at efa0'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at efa0'
    Busdriver `i2c-i801', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)

I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
# I2C chip drivers
eeprom
#----cut here----

Now that I've added those lines to /etc/modules sensors-detect doesn't
seem to detect them at all. (Though I've changed kernels a couple times
since then and could have messed something up. If there's a list of all
needed modules for making i2c-i801 work that'd be helpful. Although I
list below all the i2c modules + eeprom that are loaded and I think
that's all I should need.)

Now sensors-detect gives me this (full output:)

debian-macbook:/# sensors-detect
# sensors-detect revision 1.413 (2006/01/19 20:28:00)

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel ICH7
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): y
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at efa0
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x08
Client found at address 0x38
Probing for `Philips Semiconductors SAA1064'... Failed!
Client found at address 0x3a
Probing for `Philips Semiconductors SAA1064'... Failed!
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): y
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): y
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): y
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x0b)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x0b)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x0b)
Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
  Failed! (0x0b)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x0b)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x0b)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x0b)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x0b)
Probing for `SMSC SCH5307-NS Super IO'
  Failed! (0x0b)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.

Thanks for any help.

Brian

P.S. "successfully" is twice misspelled by sensors-detect above by
missing an 's'. (in probe ... concluded and module ... loaded).

>> In my MacBook I also get:
>>
>> lspci -v|egrep -e 'ISA|SMBus' -A3
>> 00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
>> Bridge (rev 02)
>>         Subsystem: Intel Corporation Unknown device 7270
>>         Flags: bus master, medium devsel, latency 0
>>         Capabilities: [e0] Vendor Specific Information
>> --
>> 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
>> (rev 02)
>>         Subsystem: Intel Corporation Unknown device 7270
>>         Flags: medium devsel, IRQ 11
>>         I/O ports at efa0 [size2]
>>
>> lspci -n | grep 00:1f\.0
>> 00:1f.0 0601: 8086:27b9 (rev 02)
>>
>> lspci -n | grep 00:1f\.3
>> 00:1f.3 0c05: 8086:27da (rev 02)
> 
> This device most probably works just fine. This is the SMBus master,
> which controls your I2C bus. But there don't seem to be known hardware
> monitoring chips on it.
> 
>> lsmod |grep i2c
>> i2c_dev                10144  0
>> i2c_i801               11148  0
>> i2c_core               22400  3 i2c_dev,eeprom,i2c_i801
>>
>> sensors -v
>> sensors version 2.10.0 with libsensors version 2.10.0
>>
>> sensors
>> Can't access procfs/sysfs file
>> Unable to find i2c bus information;
>> For 2.6 kernels, make sure you have mounted sysfs and libsensors
>> was compiled with sysfs support!
>> For older kernels, make sure you have done 'modprobe i2c-proc'!
> 
> Don't be fooled by this irrelevant message. All it really means is: no
> sensors found. I think we fixed that in SVN already.
> 
>> dmesg |grep -i error
>> i801_smbus 0000:00:1f.3: Error: no response!
>> [repeated about 46 times]
> 
> You must have debugging enabled. Then this is expected when probing the
> bus (as sensors-detect and i2cdetect do, and also all i2c chip drivers
> at load time.) Nothing to worry about.
> 

