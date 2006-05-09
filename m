From: AArtini@comune.pontassieve.fi.it (Artini Alessio)
Date: Tue, 09 May 2006 08:27:43 +0000
Subject: [lm-sensors] Unknown EEPROM type (8)?????? AND CPU temperatur	e
Message-Id: <AFD391091A1B1F4C810F27127FD3BA05A0DC56@ntsvr06.pontassieve.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <AFD391091A1B1F4C810F27127FD3BA05A0DC53@ntsvr06.pontassieve.local>
In-Reply-To: <AFD391091A1B1F4C810F27127FD3BA05A0DC53@ntsvr06.pontassieve.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've installed version 2.10.0 with libsensors version 2.10.0 and now if I
execute
sensors-detect
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
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801FB ICH6
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: ISA main adapter
Do you want to scan it? (YES/no/selectively): YES

Next adapter: SMBus I801 adapter at 0400
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x08
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client at address 0x50 can not be probed - unload all client drivers first!
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
  Trying address 0x0290... Success!
    (confidence 8, driver `w83627ehf')
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
  Failed! (0x88)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83687THF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x88)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x88)
Probing for `Fintek F71805F/FG Super IO Sensors'
  Failed! (0x8853)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Success... found at address 0x0290

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

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627EHF/EHG Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the I2C modules.

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
# Warning: the required module w83627ehf is not currently installed on your
system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
modprobe w83627ehf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): YES
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
#


Lsmod:
Module                  Size  Used by
eeprom                 12385  0
i2c_sensor              7489  1 eeprom
i2c_isa                 6081  0
i2c_i801               11725  0
vfat                   16961  0
fat                    44001  1 vfat
nls_utf8                6081  0
md5                     8001  1
ipv6                  240225  30
autofs4                22597  0
i2c_dev                14273  0
i2c_core               25921  5 eeprom,i2c_sensor,i2c_isa,i2c_i801,i2c_dev
sunrpc                142757  1
ipt_LOG                10049  3
ipt_limit               6337  3
ipt_state               5825  1
ip_conntrack           45573  1 ipt_state
iptable_filter          6721  1
ip_tables              21441  4 ipt_LOG,ipt_limit,ipt_state,iptable_filter
button                 10449  0
battery                12869  0
ac                      8773  0
uhci_hcd               32729  0
shpchp                 84677  0
snd_azx                21072  0
snd_hda_codec          85957  1 snd_azx
snd_pcm_oss            52345  0
snd_mixer_oss          21825  1 snd_pcm_oss
snd_pcm                91973  3 snd_azx,snd_hda_codec,snd_pcm_oss
snd_timer              27973  1 snd_pcm
snd                    56997  6
snd_azx,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              12961  1 snd
snd_page_alloc         13641  2 snd_azx,snd_pcm
sky2                   39489  0
floppy                 58065  0
dm_snapshot            20837  0
dm_zero                 6337  0
dm_mirror              28449  0
ext3                  118729  2
jbd                    59481  1 ext3
dm_mod                 59973  6 dm_snapshot,dm_zero,dm_mirror
ata_piix               13381  0
libata                 57885  1 ata_piix
sd_mod                 20545  0
scsi_mod              116941  2 libata,sd_mod

Kernel is: 2.6.9-34.ELsmp 

So I tried "modprobe w83627ehf":
FATAL: Module w83627ehf not found.

And "sensors -s":
No sensors found!

Note that I have not installed any part of i2c because the web site reports:
"Linux 2.6 users do not need to get this i2c package, it's already part of
the kernel tree."


Any idea??


Thanks
-----Messaggio originale-----
Da: Rudolf Marek [mailto:r.marek at sh.cvut.cz] 
Inviato: venerd? 5 maggio 2006 22.15
A: Artini Alessio
Cc: 'lm-sensors at lm-sensors.org'
Oggetto: Re: [lm-sensors] Unknown EEPROM type (8)?????? AND CPU temperature
above threshold


Hello Alessio
> Redhat ES 4 kernel 2.6.9-34.Elsmp,
> Mother board ASUS p5gd2 (bios 1006) with P4 at 3.4Ghz.
> Sensors: sensors version 2.8.7 with libsensors version 2.8.7

Too old version, you have 83627EHF imho. Please try new version 2.9.1/2
should be OK
> i2c /dev entries driver
> CPU0: Temperature above threshold
> CPU1: Temperature above threshold
> CPU1: Running in modulated clock mode
> CPU0: Running in modulated clock mode
> CPU1: Temperature above threshold
> CPU0: Temperature above threshold
> CPU0: Running in modulated clock mode
> CPU1: Running in modulated clock mode

This is done idependetely from hardware and it means
that both CPUs overheat, please check the heatsinks
and/or check the thermal conducting grease between
heatsink and processor. Check fans too.

> 1) Sensor/chipset not recognised.

Old version

> 2) Messages about cpu temperature

See above ;)

Regards
Rudolf

