From: lruslan@altron.ua (lruslan)
Date: Fri, 08 Sep 2006 13:47:27 +0000
Subject: [lm-sensors] lm93 sensor troubles
Message-Id: <402475187.20060908164727@altron.ua>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone!
I have such problem.
I can't monitor sensors on Supermicro SM-X6DH8-G2 motherboard.
In motherboard specification listed Super I/O - National 87427 chip.
OS FC3 and 2.6.10 kernel.
The version of lm_sensors is 2.8.7 with libsensors version 2.8.7.
Sensors-detect script from this version does not find sensors,

when i'm running sensors-detect from 2.10.0 version of lm_sensors i
recive such information:

========================We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

Next adapter: SMBus I801 adapter at 1100
Do you want to scan it? (YES/no/selectively): Client found at address 0x08
Client found at address 0x2e
Probing for `National Semiconductor LM93'... Success!
    (confidence 5, driver `lm93')
Probing for `ITE IT8712F'... Failed!
Client found at address 0x30
Client found at address 0x33
Client found at address 0x37
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client at address 0x53 can not be probed - unload all client drivers first!
Client at address 0x57 can not be probed - unload all client drivers first!
Client found at address 0x60
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 
Driver `lm93' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1100'
    Busdriver `i2c-i801', I2C address 0x2e
    Chip `National Semiconductor LM93' (confidence: 5)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1100'
    Busdriver `i2c-i801', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)


I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:
#----cut here----
modprobe i2c-i801
modprobe lm93
modprobe smbus-arp
#----cut here----
========================
As i resume - lm93 sensors are present on my motherboard.
But in 2.6.10 kernel configuration menu this drivers (lm93) not present.
After i have loaded i2c-i801 and eeprom modules. I recive:
eeprom-i2c-0-57
Adapter: SMBus I801 adapter at 1100
Unknown EEPROM type (8)

eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 1100
Unknown EEPROM type (8)

What should i do to make everything work?
As i assume in 2.6.* versions all chips drivers shold be presented in
kernels.
 Does latest version of kernels (more than 2.6.10) support lm93 drivers?


