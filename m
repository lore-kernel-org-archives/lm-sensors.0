From: Stephan.Zerhau@t-online.de (Stephan Zerhau)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: problem with lm_sensors
Message-Id: <3E9496EA.3020302@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi,
I have a problem with lm_sensors. Maybe it is easy for you to solve it, 
but be assured that I?ve tried anything I know before contacting you guys.
After successfully compiling and installing i2c and lm_sensors with no 
error messages at all (even all modules seem to be loaded correctly), I 
get this message whenever I make "sensors -s":    No sensors found!
Following the output according your guideline for reporting problems:
linux#dmesg
i2c-proc.o version 2.6.5 (20020915)
w83781d.o version 2.6.5 (20020915)
i2c-core.o: i2c core module version 2.6.5 (20020915)
i2c-viapro.o version 2.6.5 (20020915)
i2c-viapro.o: Found Via VT8233 device
i2c-viapro.o: Via Pro SMBus detected and initialized
i2c-dev.o: i2c /dev entries driver module version 2.6.5 (20020915)
i2c-dev.o: Registered 'SMBus Via Pro adapter at e800' as minor 0
i2c-proc.o version 2.6.5 (20020915)
i2c-proc.o version 2.6.5 (20020915)
w83781d.o version 2.6.5 (20020915)
i2c-viapro.o version 2.6.5 (20020915)
i2c-viapro.o: Found Via VT8233 device
i2c-viapro.o: Via Pro SMBus detected and initialized
i2c-dev.o: i2c /dev entries driver module version 2.6.5 (20020915)
i2c-dev.o: Registered 'SMBus Via Pro adapter at e800' as minor 0
i2c-proc.o version 2.6.5 (20020915)
w83781d.o version 2.6.5 (20020915)

linux#./sensors-detect
BIOS vendor (ACPI): ASUS 
 System vendor (DMI): System Manufacturer
 BIOS version (DMI): ASUS A7V266 ACPI BIOS Rev 1006
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8233 
VLink South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double 
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at e800 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x0c
Client found at address 0x0d
Client found at address 0x0e
Client found at address 0x0f
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Success!
    (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x48
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x49
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
no
Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `w83781d' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x2d (and 0x48 0x49)
    Chip `Asus AS99127F' (confidence: 8)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x48
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x49
    Chip `Philips Semiconductors PCF8591' (confidence: 1)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?
smbus
WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
# I2C chip drivers
modprobe w83781d
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

linux#lsmod
w83781d                20336   0  (unused)
i2c-proc                7280   0  [w83781d]
i2c-dev                 4612   0
i2c-viapro              3952   0
i2c-core               15332   0  [w83781d i2c-proc i2c-dev i2c-viapro]
ipt_state                568   2  (autoclean)
ipt_MASQUERADE          1368   1  (autoclean)
usbserial              19644   0  (autoclean) (unused)
usbcore                61728   0  (autoclean) [usbserial]
iptable_mangle          2136   0  (autoclean) (unused)
iptable_nat            14360   1  (autoclean) [ipt_MASQUERADE]
ip_conntrack           14780   2  (autoclean) [ipt_state ipt_MASQUERADE 
iptable_nat]
iptable_filter          1740   1  (autoclean)
ip_tables              11704   7  [ipt_state ipt_MASQUERADE 
iptable_mangle iptable_nat iptable_filter]
af_packet              13800   1  (autoclean)
nfsd                   78992   4  (autoclean)
st                     28428   0  (autoclean) (unused)
sr_mod                 14616   0  (autoclean) (unused)
ipv6                  150356  -1  (autoclean)
3c59x                  27568   1
hisax                 519172   6
isdn                  131488   8  [hisax]
slhc                    5520   2  [isdn]
isa-pnp                31520   0  [hisax]
osst                   45352   0
ide-scsi                8816   0
ide-cd                 30340   0
cdrom                  28736   0  [sr_mod ide-cd]
ext3                   84744   3
jbd                    50236   3  [ext3]

as far as I can determine I have no bus problem, for any modprobes would 
go through, the only "error" I have at all is the one mentioned above. I 
didn?t configure /etc/sensors.conf so perhaps it?s only some configuring 
(but seriously I didn?t find any docs on your web page). My Motherboard 
data:
Asus A7V266
VIA VT8233 Southbridge
Asus 99127F is the Chip (module i2c-viapro and w83781d)
Kernel 2.4.19-4GB
lmsensors version 2.7.0 (downloaded and installed today)

thank you very much for your help in advance
regards
Stephan
