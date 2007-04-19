From: Jake Briggs <jake@coretech.co.nz>
Date: Thu, 19 Apr 2007 00:11:44 +0000
Subject: Re: [lm-sensors] can't get tempurature readings!
Message-Id: <4626B3C0.7080607@coretech.co.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <461F073C.3020400@coretech.co.nz>
In-Reply-To: <461F073C.3020400@coretech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



Hans de Goede wrote:
> Jake Briggs wrote:
>  =20
>> Hi All
>>
>> I have lm_sensors-2.8.7-2.40.3 installed, with kernel 2.6.9-11.ELsmp,=20
>> installed on a CentOS 4.1 machine. sensors-detect seems to work fine,=20
>> the modules it suggests are loading, but when I run sensors, the=20
>> temperature readings are wrong!
>>
>> The temperatures seem to be stuck at +127=B0C - and never waiver, very=20
>> odd. My machine cannot be running that high! Also, 127 is kinda half of =

>> 256, but that may be a coincidence. Still raises my suspicions that the =

>> reading is faulty somehow....
>>
>>    =20
>
> It would greatly help if you could provide us with some more details, lik=
e the=20
> full output of sensors-detect and what the brand and model of your mother=
board are.
>
> Regards,
>
> Hans
>  =20


I have been on site for a few days, sorry for the delay :) More details=20
are :

Motherboard details :

Intel SE7210TP1 Server Motherboard

This page :

http://www.intel.com/design/servers/boards/SE7210TP1-E/index.htm

Mentions that the "Super I/O Controller" is a "Winbond W83627HF Super=20
I/O controller". sensors-detect (full output below) seems to correctly=20
identify this chip during the ISA bus scan :)

I am loading the w83627hf module, along with i2c_sensor, i2c_core and=20
i2c_isa. This looks like is should be fine to me. The full output of=20
lsmod is included at the end of this email. Also, full output from=20
sensors is also included! I notice that the voltages change, so=20
something must be working correctly :)

Full output from sensors-detect :

[root@seker ~]# sensors-detect

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
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 6300ESB
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double=20
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0400 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x08
Client found at address 0x42
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x51 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
Client at address 0x53 can not be probed - unload all client drivers first!
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): yes
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
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
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
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83627HF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x52)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x52)

Do you want to scan for secondary Super I/O sensors? (YES/no): yes
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): yes
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
[root@seker ~]#

lsmod output :

[root@seker ~]# lsmod
Module                  Size  Used by
w83627hf               29161  0
eeprom                 12385  0
i2c_sensor              7489  2 w83627hf,eeprom
i2c_isa                 6081  0
i2c_i801               11725  0
vmnet                  39580  14
vmmon                 113188  6
nfsd                  205281  9
exportfs               10049  1 nfsd
lockd                  65257  2 nfsd
md5                     8001  1
ipv6                  238817  14
parport_pc             27904  0
lp                     15405  0
parport                37641  2 parport_pc,lp
autofs4                22085  0
i2c_dev                14273  0
i2c_core               25921  6=20
w83627hf,eeprom,i2c_sensor,i2c_isa,i2c_i801,i2c_dev
sunrpc                138789  19 nfsd,lockd
dm_mirror              24861  0
dm_mod                 58949  1 dm_mirror
button                 10449  0
battery                12869  0
ac                      8773  0
uhci_hcd               32729  0
hw_random               9557  0
e1000                  84389  0
e100                   36673  0
mii                     8641  1 e100
ext3                  118729  2
jbd                    59481  1 ext3
raid1                  19521  1
ata_piix               13125  5
libata                 47133  1 ata_piix
sd_mod                 20545  7
scsi_mod              116429  2 libata,sd_mod
[root@seker ~]#

sensors output :

[root@seker ~]# sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
VCore 2:   +1.20 V  (min =3D  +0.00 V, max =3D  +0.00 V)
+3.3V:     +3.36 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:       +5.00 V  (min =3D  +4.76 V, max =3D  +5.24 V)
+12V:     +12.22 V  (min =3D +10.82 V, max =3D +13.19 V)
-12V:      +1.54 V  (min =3D -13.18 V, max =3D -10.80 V)
-5V:       +0.48 V  (min =3D  -5.25 V, max =3D  -4.75 V)
V5SB:      +5.59 V  (min =3D  +4.76 V, max =3D  +5.24 V)
VBat:      +1.02 V  (min =3D  +2.40 V, max =3D  +3.60 V)
fan1:        0 RPM  (min =3D 3443 RPM, div =3D 2)
fan2:        0 RPM  (min =3D 225000 RPM, div =3D 2)
fan3:        0 RPM  (min =3D 14062 RPM, div =3D 8)
temp1:      +127=B0C  (high =3D  -124=B0C, hyst =3D   +49=B0C)   sensor =3D=
 thermistor
temp2:    +127.5=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
=20
PII/Celeron diode   ALARM
temp3:    +127.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
=20
thermistor   ALARM
ERROR: Can't get VID data!
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 0400
        Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

[root@seker ~]#




--=20
Jacob Briggs
Systems Engineer

Core Technology Limited
Level 1, NZX Centre
11 Cable Street
Wellington
Phone +64 4 801 2252

--

object doAnythingConceivable(string whatToDo, object whatToDoItWith) { .....



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
