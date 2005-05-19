From: martin@martin-fernau.de (Martin Fernau)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: no FAN3 available
Message-Id: <200309091051.35943.martin@martin-fernau.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309011224.08300.martin@martin-fernau.de>
In-Reply-To: <200309011224.08300.martin@martin-fernau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

thanks for your answer. I've checked the manual of my mainboard about the=20
winbond chip. On the graphic I can only see one W83697HF Chip. No second ch=
ip=20
which can monitor the third FAN. But if I go into my BIOS, I can see the=20
system fan-speed too.
I've just downloaded the newest sensors-detect script and unloaded all i2c =

devices. After this, I started the sensors-detect script and go through the=
=20
installation process. I've append the output of the script to this mail.
I'll be very glad if you have the time and could help me to get the third F=
AN=20
working. But if not, its ok. Maybe I try to connect the system-fan to the=20
FAN2 input on my mainboard.

Thanks for your effort.

Regards,
Martin Fernau

Am Sonntag, 7. September 2003 18:54 schrieben Sie:
> > I just have a problem with one fan in my system. The processor fan
> > works correctly. But I recently added a system-fan which I connected
> > to FAN3 connector on my board. But when I type 'sensors' I get only
> > fan-output for FAN1 (CPU) and FAN2 (no fan connected so its every time
> > 0) but no data for FAN3 where my system-fan is conneced to. I hope,
> > you can help me to get it working :)
> > Winbond chip: W83697HF
> > Mainboard: Epox EP-8KHA+
> > Sensors ver: 2.7.0-r1
> > Kernel: 2.4.20
>
> The W83697HF has only two fans inputs. Three possibilities:
>
> 1* You don't really have a W83697HF, but some similar chip (w83627hf,
> w83627thf...) with three fan inputs.
>
> 2* You really have a W83697HF, and the third fan cannot be monitored.
>
> 3* You really have a W83697HF, and there's a secondary chip for
> monitoring the third fan. The sensors-detect script should tell you.
>
> The manual of your motherboad could help choosing between these
> possibilities. Or you could provide the output of sensors-detect (after
> unloading *all* i2c chip drivers; when asked for undetectable adapters,
> say no). Using the CVS version of the script would be better:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
> since we've improved it much since 2.7.0 was released.
>
> > Random witze fortune:
> > (...)
>
> Please avoid that next time.

- --=20

Name		: Martin Fernau
EMail		: martin@martin-fernau.de
url		: http://www.martin-fernau.de
icq		: 14509914

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/XZSUnYbNbD9S1MURAoCFAJsEff2MRsaVwscTmqspGXAPkGaS/wCff1T4
DdMTgw66Ly/HkODDMgClrZg=A4gJ
-----END PGP SIGNATURE-----
-------------- next part --------------
murpy mfe # lsmod
Module                  Size  Used by    Tainted: P
snd-pcm-oss            39940   1  (autoclean)
snd-mixer-oss          13848   1  (autoclean) [snd-pcm-oss]
agpgart                14288   3  (autoclean)
smbfs                  40048   6  (autoclean)
rtc                     7644   0  (autoclean)
nls_iso8859-1           2844   4  (autoclean)
nls_cp437               4348   4  (autoclean)
vfat                   10700   4  (autoclean)
fat                    33336   0  (autoclean) [vfat]
nvidia               1542336  10
snd-emu10k1            73460   2
snd-pcm                65024   0  [snd-pcm-oss snd-emu10k1]
snd-timer              15880   0  [snd-pcm]
snd-page-alloc          5292   0  [snd-emu10k1 snd-pcm]
snd-util-mem            1408   0  [snd-emu10k1]
snd-rawmidi            15072   0  [snd-emu10k1]
snd-seq-device          4448   0  [snd-emu10k1 snd-rawmidi]
snd-hwdep               5280   0  [snd-emu10k1]
snd-ac97-codec         37888   0  [snd-emu10k1]
snd                    32644   0  [snd-pcm-oss snd-mixer-oss snd-emu10k1 sn=
d-pcm snd-timer snd-util-mem snd-rawmidi snd-seq-device snd-hwdep snd-ac97-=
codec]
soundcore               4164   6  [snd]
mousedev                4372   1
hid                    13992   0  (unused)
input                   3648   0  [mousedev hid]
3c59x                  27568   1
murpy mfe # sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): VIA694
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8233 VLink S=
outh Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no): yes
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): no
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): yes
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detect=
ed;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at 5000 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x18
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Failed!
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): yes
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
Probing for `Winbond W83697HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
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
 this.  Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `SMSC 47M1xx Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x60)
Probing for `Winbond W83697HF Super IO Sensors'
  Success... found at address 0x0290

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

Driver `w83781d' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF' (confidence: 8)

Driver `w83627hf' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF Super IO Sensors' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? ISA

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe w83781d
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): yes
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
murpy mfe #
