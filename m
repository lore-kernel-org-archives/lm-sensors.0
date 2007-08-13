From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Aug 2007 12:51:57 +0000
Subject: Re: [lm-sensors] lm_sensors - What am I doinng wrong ?
Message-Id: <20070813145157.07b6b844@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 09 Aug 2007 10:00:07 +0200, czezz wrote:
> Hi everyone.
> Hope thi is good place to post that.

Yes it is.

> What I am trying to do is run lm_sensors on Slackware 12 - no success so far :(.
> With Slackware 12 I'm using binary packages lm_sensors-2.10.3-i486-1 (instead of compiling sources)
> Hardware that Im trying to run on lm_sensors is - Laptop HP Omnibook 510.
> 
> I have 2 kernels:
> - default Slackware 12 kernel - vmlinuz-huge-smp-2.6.21.5-smp

Not related to your problem, but "huge-smp" doesn't seem to be a very
appropriate kernel flavor for a laptop.

> - compilled by my self with taht requirements http://www.lm-sensors.org/wiki/Kernel2.6
> 
> 
> This is what happaned when I start "sensors-detect"
> It looks good for me:
> 
> ====================================
> root@hp:/# sensors-detect
> # sensors-detect revision 4348 (2007-03-18 02:45:21 -0700)
> 
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
> 
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801CA/CAM ICH3
> 
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
> 
> Next adapter: SMBus I801 adapter at 1880 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x4c
> Probing for `National Semiconductor LM75'...                No
> Probing for `Dallas Semiconductor DS75'...                  Success!
>     (confidence 3, driver `lm75')
> Probing for `Analog Devices ADT7466'...                     No
> Probing for `Andigilog aSC7511'...                          No
> Probing for `Dallas Semiconductor DS1621'...                No
> Probing for `Analog Devices ADM1021'...                     No
> Probing for `Analog Devices ADM1021A/ADM1023'...            No
> Probing for `Maxim MAX1617'...                              No
> Probing for `Maxim MAX1617A'...                             No
> Probing for `Maxim MAX1668'...                              No
> Probing for `Maxim MAX1805'...                              No
> Probing for `Maxim MAX1989'...                              No
> Probing for `Maxim MAX6655/MAX6656'...                      No
> Probing for `TI THMC10'...                                  No
> Probing for `National Semiconductor LM84'...                No
> Probing for `Genesys Logic GL523SM'...                      No
> Probing for `Onsemi MC1066'...                              No
> Probing for `Maxim MAX1619'...                              No
> Probing for `National Semiconductor LM82/LM83'...           No
> Probing for `National Semiconductor LM90'...                No
> Probing for `National Semiconductor LM89/LM99'...           No
> Probing for `National Semiconductor LM86'...                No
> Probing for `Analog Devices ADM1032'...                     No
> Probing for `Maxim MAX6657/MAX6658/MAX6659'...              No
> Probing for `Maxim MAX6648/MAX6692'...                      No
> Probing for `National Semiconductor LM63'...                No
> Probing for `Fintek F75363SG'...                            No
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> Probing for `Analog Devices ADT7461'...                     No
> Probing for `Fintek F75383S/M'...                           No
> Client found at address 0x50
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> 
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
> 
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0xea11
> Trying family `National Semiconductor'...                   Yes
> Found `Nat. Semi. PC8739x Super IO'
>     (no hardware monitoring capabilities)
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0xea11
> Trying family `VIA/Winbond/Fintek'...                       Yes
> Found unknown chip with ID 0xea11
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> 
> Some CPUs or memory controllers may also contain embedded sensors.
> Do you want to scan for them? (YES/no):
> AMD K8 thermal sensors...                                   No
> Intel Core family thermal sensor...                         No
> Intel AMB FB-DIMM thermal sensor...                         No
> 
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `lm75' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at 1880'
>     Busdriver `i2c-i801', I2C address 0x4c
>     Chip `Dallas Semiconductor DS75' (confidence: 3)
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at 1880'
>     Busdriver `i2c-i801', I2C address 0x50
>     Chip `eeprom' (confidence: 6)
> 
>   EEPROMs are *NOT* sensors! They are data storage chips commonly
>   found on memory modules (SPD), in monitors (EDID), or in some
>   laptops, for example.
> 
> I will now generate the commands needed to load the required modules.
> Just press ENTER to continue:
> 
> To make the sensors modules behave correctly, add these lines to
> /etc/modules.conf:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> 
> To load everything that is needed, add this to some /etc/rc* file:
> 
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> # Chip drivers
> modprobe lm75
> modprobe eeprom
> # sleep 2 # optional
> /usr/bin/sensors -s # recommended
> #----cut here----
> 
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones! You really
> should try these commands right now to make sure everything is
> working properly. Monitoring programs won't work until the needed
> modules are loaded.
> 
> Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
> Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors
> for initialization at boot time.
> ====================================
> 
> I have put proper lines shown above to /etc/modules.conf and /etc/rc.d/rc.local
> 
> Here is what "lsmod" shows: 
> 
> ====================================
> root@hp:~# lsmod
> Module                  Size  Used by
> eeprom                  9616  0
> lm75                   10384  0
> hwmon                   6404  1 lm75
> snd_seq_dummy           6788  0
> snd_seq_oss            32896  0
> snd_seq_midi_event     10112  1 snd_seq_oss
> snd_seq                50640  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
> snd_seq_device         10508  3 snd_seq_dummy,snd_seq_oss,snd_seq
> snd_pcm_oss            42784  0
> snd_mixer_oss          18048  1 snd_pcm_oss
> ipv6                  254496  12
> nls_utf8                5760  1
> ntfs                  222016  1
> capability              7304  0
> commoncap               9344  1 capability
> lp                     13736  0
> parport_pc             27812  1
> parport                34632  2 lp,parport_pc
> pcspkr                  6528  0
> psmouse                39048  0
> pcmcia                 34452  0
> yenta_socket           27148  1
> rsrc_nonstatic         13312  1 yenta_socket
> snd_maestro3           24484  0
> snd_ac97_codec         98980  1 snd_maestro3
> ac97_bus                6016  1 snd_ac97_codec
> serio_raw               9220  0
> pcmcia_core            36500  3 pcmcia,yenta_socket,rsrc_nonstatic
> snd_pcm                72068  3 snd_pcm_oss,snd_maestro3,snd_ac97_codec
> snd_timer              22532  2 snd_seq,snd_pcm
> snd_page_alloc         11528  1 snd_pcm
> eepro100               30608  0
> snd                    47204  9 snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_maestro3,snd_ac97_codec,snd_pcm,snd_timer
> mii                     8576  1 eepro100
> soundcore               9824  1 snd
> i2c_i801               11408  0
> i2c_core               21120  3 eeprom,lm75,i2c_i801
> piix                   12932  0 [permanent]
> intel_agp              25116  1
> agpgart                31432  1 intel_agp
> shpchp                 33172  0
> uhci_hcd               25612  0
> iTCO_wdt               12964  0
> iTCO_vendor_support     7172  1 iTCO_wdt
> evdev                  11904  0
> ext3                  122888  1
> jbd                    55720  1 ext3
> mbcache                10628  1 ext3
> ====================================
> 
> And finally... this is what makes me upset:
> 
> ====================================
> root@hp:/# sensors -s
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> ====================================
> 
> ...and this way also doesnt work:
> 
> ====================================
> root@hp:/# sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> ====================================

The lm75 driver doesn't really support the Dallas DS75, or more
exactly, it supports it but fails to identify it. There was a patch
adding support floating around but it got lost somehow. So you need to
force the lm75 to attach to your chip:

modprobe lm75 force_lm75=0,0x4c

(or add "options lm75 force_lm75=0,0x4c" to /etc/modprobe.conf or
equivalent.)

However... The confidence level is rather low (3) and I have to say I'd
be surprised to find a DS75 in a recent laptop. So it might as well be
a misdetection. Please download the latest version of sensors-detect:

http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

And give it a try (no need to install it.) Maybe it'll identify your
chip differently. If not, please provide the output of:

i2cdump 0 0x4c b

And I'll tell you whether this is a DS75 or something else.

> I have done this same on other hardware and the result is also unsuccessful.

Every system is different so this is hardly relevant.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
