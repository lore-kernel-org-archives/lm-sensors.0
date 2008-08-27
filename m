From: Kyle <kl@attitia.com>
Date: Wed, 27 Aug 2008 00:20:37 +0000
Subject: [lm-sensors] install functioning lm-sensors on CentOS 5 -
Message-Id: <48B49DD5.3020309@attitia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi folks,

I'm hoping someone can hep me out pls. I've installed lm-sensors in the 
past in 2.4 kernels and it all just worked.

But I cannot for the life of me understand what is happening with or 
figure out what I need for my CentOS 5 / 2.6 kernel install.

I have read snippets which "SEEM" to indicate all of the modules I need 
are already compiled into or modularised with the base 2.6 Kernel 
(CentOS is of course a downline from RedHat EL), but don't really make 
it clear. When looking in 'make menuconfig', the modules listed as 
required for lm-sensors don't seem to match up with what I read.

I've read on the lm-sensors site that I "MAY" need a different driver 
with the XEON CPU, but I can't figure out how to tell and don't want to 
mess up a new install.

When running sensors-detect, it appears to fail to find just about 
everything. Basically, the abridged output of sensors-detect is as follows;

====================Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.

i2c-dev is not loaded. Do you want to load it now? (YES/no):
Module loaded succesfully.

Next adapter: SMBus I801 adapter at 2000
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x10
Client found at address 0x30
Client found at address 0x32
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
   (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
   (confidence 8, driver `eeprom')
Client found at address 0x69

Do you want to scan the ISA bus? (YES/no):
Probing for `IPMI BMC KCS'
 Trying address 0x0ca0... Success!
   (confidence 4, driver `bmcsensors')        [KL] ALL OTHERS FAILED.

Do you want to scan for Super I/O sensors? (YES/no):
[KL] ALL FAILED.

Do you want to scan for secondary Super I/O sensors? (YES/no):
[KL] ALL FAILED


Driver `eeprom' (should be inserted):
 Detects correctly:
 * Bus `SMBus I801 adapter at 2000'
   Busdriver `i2c-i801', I2C address 0x50
   Chip `SPD EEPROM' (confidence: 8)
 * Bus `SMBus I801 adapter at 2000'
   Busdriver `i2c-i801', I2C address 0x52
   Chip `SPD EEPROM' (confidence: 8)

Driver `bmcsensors' (should be inserted):
 Detects correctly:
 * ISA bus address 0x0ca0 (Busdriver `i2c-isa')
   Chip `IPMI BMC KCS' (confidence: 4)

[KL] It then offers up the changes to rc.local and modprobe.conf. But 
within that, there's

# Warning: the required module bmcsensors is not currently installed on 
your system.
# For status of 2.6 kernel ports see 
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the 
following line.
modprobe bmcsensors

[KL] How can it detect a driver if it's apparently NOT installed on the 
system. Where do I get hold of the correct bmcsensors module?
=====================
Can I ask any one of you to help out pls and ask me the right questions 
so I know/can figure out just what the hell I should be looking for?
-- 
------------------------------------------------------------------------
Kind Regards

Kyle


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
