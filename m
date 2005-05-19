From: olegg@ukrpack.net (Oleg Gritsinevich)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: Problems with Intel SDS2 server board
Message-Id: <20040318142540.GA1450@kunashir.ukrpack.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

	Hi All!

	I'm trying to receive some usefull data (temperature, fan
rotation speed, etc.) using lm_sensors on Intel SDS2 server board.
But have no success.

	Hardware: 2xP3-1.26GHz on Intel SDS2 server motherboard.
'lspci' output:
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 92)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks: Unknown device 0230
02:04.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
02:04.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

	Software: RH7.3 with following i2c & lm_sensors related packages
installed (all from
<http://download.atrpms.net/production/packages/redhat-7.3-i386/atrpms/> as
<http://secure.netroedge.com/~lm78/> advices in 'News' from 'March 12th,
2004'):
lm_sensors-2.8.5-0_23.rh7.3.at.i386.rpm
lm_sensors-kmdl-smp-2.4.20-30_37.rh7.3.at-2.8.5-0_23.rh7.3.at.i686.rpm
kernel-smp-2.4.20-30_37.rh7.3.at.i686.rpm

	My conversation with sensors-detect follows (my comments included
into curly braces):
----------------------------------------------------------------------------
/usr/sbin/sensors-detect
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB5 South Bridge
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.

 Do you now want to be prompted for non-detectable adapters? (yes/NO): 
{I've tried both 'yes' and 'no' - nothing helped} With 'yes':
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no):
2c-elektor failed
Load `i2c-elv' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no):
i2c-velleman failed
{As I understand i2c-elv and i2c-philips-par don't help me}

 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

If you found that the adapter hung after probing a certain address, you can
specify that address to remain unprobed. That often
includes address 0x69 (clock chip).

Next adapter: SMBus PIIX4 adapter at 0580 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x30
Client found at address 0x33
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x53
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x60
Client found at address 0x62
Client found at address 0x69

{As I see it found at least 8 clients}

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
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
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Success!
    (confidence 4, driver `bmcsensors')
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no):

{All of them failed}

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 8)

Driver `bmcsensors' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0ca0 (Busdriver `i2c-isa')
    Chip `IPMI BMC KCS' (confidence: 4)

 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? 

{I've tried both ISA and smbus - nothing changed}

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:
#----cut here----
# I2C adapter drivers
modprobe i2c-piix4
# modprobe unknown adapter ELV Parallel port adaptor using Bit-shift algorithm
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe bmcsensors
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----
----------------------------------------------------------------------------

	After all I have this output from 'sensors':
eeprom-i2c-0-50
Adapter: SMBus PIIX4 adapter at 0580
Memory type:            SDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-53
Adapter: SMBus PIIX4 adapter at 0580
Memory type:            SDR SDRAM DIMM
Memory size (MB):       512

	No temperature, no fan rotation speed, nothing useful. I've tried
to run '/usr/sbin/i2cdetect 1': for the first time it hanged, though it
wrote one line of output (several digits in a row as I remember). Now it says:
'Error: Can't use SMBus Quick Write command on this bus (ISA bus?)'

	I've read "Intel Server Board SDS2 Technical Product Specification"
<ftp://download.intel.com/support/motherboards/server/sds2/tps.pdf> and it
says that this motherboard have several temperature and fan speed sensors,
particularly it mentions ADM1026. I've tried to do 'modprobe adm1026', all
of 'lm*', 'xeontemp'. They loaded without complains, but nothing changed in
'sensors' output.

	I really need to monitor the machine because it hanged two times
last day (no pings, no logs, blank screen - the machine just 'freezed') and
I suspect it's hardware-related problem, maybe overheating of CPUs or
motherboard.
	Help me please with lm_sensors. How can I receive data from those 6
clients founded on 'SMBus PIIX4 adapter' and 'turn on' others (if they
exist)?

-- 
With best regards, Oleg Gritsinevich

P.S. How can I subscribe to the mailing list?
