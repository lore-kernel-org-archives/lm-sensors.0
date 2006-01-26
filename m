From: samag70-2@yahoo.ca (samag70-2@yahoo.ca)
Date: Thu, 26 Jan 2006 17:53:13 +0000
Subject: [lm-sensors] No sensors found!
Message-Id: <20060126175313.69866.qmail@web88204.mail.re2.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <62A29338972397468405C79C4FE13C3B916AFA@ex1.messagegate.local>
In-Reply-To: <62A29338972397468405C79C4FE13C3B916AFA@ex1.messagegate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have followed the  directions, but I am having a tough time making this work.  After  going through all the steps, I still get the messageNo sensors found! 
  
  Here are the steps I went through, sorry if this is long.
  
  [root at dieppe ~]# rpm -qa | grep lm_sensors
  lm_sensors-devel-2.9.2-42.rhfc4.at
  lm_sensors-2.9.2-42.rhfc4.at
  
  [root at dieppe ~]# lsmod
  Module                  Size  Used by
  eeprom                  7377  0
  i2c_piix4               9041  0
  i2c_core               22081  2 eeprom,i2c_piix4
  ipv6                  249761  18
  autofs4                19653  2
  sunrpc                141437  1
  ipt_REJECT              5953  1
  ipt_state               1985  8
  ip_conntrack           51953  1 ipt_state
  nfnetlink               6617  1 ip_conntrack
  iptable_filter          3137  1
  ip_tables               20033  3 ipt_REJECT,ipt_state,iptable_filter
  video                  16197  0
  button                  6737  0
  battery                 9541  0
  ac                       4933  0
  uhci_hcd               32465  0
  eepro100               30673  0
  e100                   36545  0
  mii                      5313  2 eepro100,e100
  floppy                 61957  0
  dm_snapshot            17773  0
  dm_zero                 2113  0
  dm_mirror              22421  0
  ext3                  129993  8
  jbd                     57813  1 ext3
  dm_mod                  56797  12 dm_snapshot,dm_zero,dm_mirror
  sym53c8xx              79193  2
  scsi_transport_spi     21185  1 sym53c8xx
  sd_mod                 18625  3
  scsi_mod               135529  3 sym53c8xx,scsi_transport_spi,sd_mod
  
  [root at dieppe ~]# rmmod eeprom i2c_piix4 i2c_core
  
  [root at dieppe ~]# sensors-detect
  # sensors-detect revision 1.393 (2005/08/30 18:51:18)
  
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
   Do you want to probe now? (YES/no): YES
  Probing for PCI bus adapters...
  Use driver `i2c-piix4' for device 00:14.3: Intel 82371AB PIIX4 ACPI
  Probe succesfully concluded.
  
  We will now try to load each adapter module in turn.
  Load `i2c-piix4' (say NO if built into your kernel)? (YES/no): YES
  Module loaded succesfully.
  If you have undetectable or unsupported adapters, you can have them
  scanned by manually loading the modules before running this script.
  
   To continue, we need module `i2c-dev' to be loaded.
   If it is built-in into your kernel, you can safely skip this.
   i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
   Module loaded succesfully.
  
   We are now going to do the adapter probings. Some adapters may hang halfway
   through; we can't really help that. Also, some chips will be double detected;
   we choose the one with the highest confidence value in that case.
   If you found that the adapter hung after probing a certain address, you can
   specify that address to remain unprobed. That often
   includes address 0x69 (clock chip).
  
  Next adapter: SMBus PIIX4 adapter at fc00
  Do you want to scan it? (YES/no/selectively): YES
  Client found at address 0x32
  Client found at address 0x50
  Probing for `SPD EEPROM'... Success!
      (confidence 8, driver `eeprom')
  Probing for `DDC monitor'... Failed!
  Probing for `Maxim MAX6900'... Failed!
  Client found at address 0x51
  Probing for `SPD EEPROM'... Success!
      (confidence 8, driver `eeprom')
  Client found at address 0x52
  Probing for `SPD EEPROM'... Success!
      (confidence 8, driver `eeprom')
  Client found at address 0x69
  
  Some chips are also accessible through the ISA bus. ISA probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this. This is usually safe though.
  
  Do you want to scan the ISA bus? (YES/no): YES
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
  Probing for `Winbond W83697HF'
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
  
  Do you want to scan for Super I/O sensors? (YES/no): YES
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
  
  Do you want to scan for secondary Super I/O sensors? (YES/no): YES
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
  
   Now follows a summary of the probes I have just done.
   Just press ENTER to continue:
  
  Driver `eeprom' (should be inserted):
    Detects correctly:
    * Bus `SMBus PIIX4 adapter at fc00'
      Busdriver `i2c-piix4', I2C address 0x50
      Chip `SPD EEPROM' (confidence: 8)
    * Bus `SMBus PIIX4 adapter at fc00'
      Busdriver `i2c-piix4', I2C address 0x51
      Chip `SPD EEPROM' (confidence: 8)
    * Bus `SMBus PIIX4 adapter at fc00'
      Busdriver `i2c-piix4', I2C address 0x52
      Chip `SPD EEPROM' (confidence: 8)
  
  
   I will now generate the commands needed to load the I2C modules.
   Sometimes, a chip is available both through the ISA bus and an I2C bus.
   ISA bus access is faster, but you need to load an additional driver module
   for it. If you have the choice, do you want to use the ISA bus or the
   I2C/SMBus (ISA/smbus)? smbus
  
  To make the sensors modules behave correctly, add these lines to
  /etc/modules.conf:
  
  #----cut here----
  # I2C module options
  alias char-major-89 i2c-dev
  #----cut here----
  
  To load everything that is needed, add this to some /etc/rc* file:
  
  #----cut here----
  # I2C adapter drivers
  modprobe i2c-piix4
  # I2C chip drivers
  modprobe eeprom
  # sleep 2 # optional
  /usr/bin/sensors -s # recommended
  #----cut here----
  
  WARNING! If you have some things built into your kernel, the list above
  will contain too many modules. Skip the appropriate ones! You really should
  try these commands right now to make sure everything is working properly.
  Monitoring programs won't work until it's done.
  
  Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): YES
  Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
  for initialization at boot time.
  
  [root at dieppe ~]# modprobe i2c-piix4
  [root at dieppe ~]# modprobe eeprom
  [root at dieppe ~]# /usr/bin/sensors -s
  No sensors found!
  
  
  ---------
  
  Any suggestions?
  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060126/59286516/attachment.html
