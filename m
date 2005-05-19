From: magnus.f@telia.com (=?iso-8859-1?Q?Magnus=20Forsstr=F6m?=)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: LM83 test results
Message-Id: <200308061832.h76IWJ216232@d1o829.telia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806122107.6d678b30.khali@linux-fr.org>
In-Reply-To: <20030806122107.6d678b30.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Could you download sensors-detect CVS and give it a try? (unload the
> lm83 driver first)
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-
detect
Ok output at the end of this mail.

>=20
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
> > 10: XX XX XX XX XX XX XX XX XX 19 XX XX XX XX XX XX=20
> > 20: 20 21 22 23 XX XX XX XX XX XX XX XX XX XX XX XX=20
> > 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
> > 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
> > 50: 50 51 52 53 54 55 56 57 XX XX XX XX XX XX XX XX=20
> > 60: XX XX XX XX 64 XX XX XX XX XX XX XX XX XX XX XX=20
> > 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX=20
>=20
> There are many devices. 0x50 to 0x57 are eeproms (real or fake, that I
> can't tell). There is a LM device at 0x19. The devices from 0x20 to=20
0x23
How can you tell that they are EEPROM:s.?

> are really mysterious. If you are curious, you could run "i2cdump 0
> 0x20" and see if it returns anything interesting.=20
# dump/i2cdump 0 0x20 =20
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and=20
worse!
  I will probe file /dev/i2c-0, address 0x20, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f    .???????????????
10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f    ????????????????
20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f     !"#$%&'()*+,-./
30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f    0123456789:;<=3D>?
40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f    @ABCDEFGHIJKLMNO
50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f    PQRSTUVWXYZ[\]^_
60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f    `abcdefghijklmno
70: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f    pqrstuvwxyz{|}~?
80: 80 81 82 83 84 85 86 87 88 89 8a 8b 8c 8d 8e 8f    ????????????????
90: 90 91 92 93 94 95 96 97 98 99 9a 9b 9c 9d 9e 9f    ????????????????
a0: a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 aa ab ac ad ae af    ????????????????
b0: b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf    ????????????????
c0: c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf    ????????????????
d0: d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 da db dc dd de df    ????????????????
e0: e0 e1 e2 e3 e4 e5 e6 e7 e8 e9 ea eb ec ed ee ef    ????????????????
f0: f0 f1 f2 f3 f4 f5 f6 f7 f8 f9 fa fb fc fd fe ff    ???????????????.

>=20
> > I have been told that "Sensor D1 reads the CPU die temperature, the=20
> > local sensor reads the LM83's own temperature. Sensors D2 and D3=20
> > measure nothing."=20
>=20
> Who told you that?=20
I got that from an e-mail originating from the manufacturer.


> Am I right guessing you have always seen temp2=3Dtemp3=3Dtemp4?
No that was just a lucky shot in my original e-mail!

>=20
> > # i2cdump 0 0x19
>=20
> I suspect it is a LM82, not a LM83. The LM82 is basically a cut down
> LM83 with a singe remote temperature instead of 3. Do you have any
> reason to believe you must have a real LM83, apart from the fact that
> sensors-detect told you so?
Yes from the manufacturer e-mail and now from the fact that I get=20
different readings.

>=20
> > > Are these four entries correct? Do you have 4 SDRAM memory modules
> > > of 256MB each?
> > Well most likely. I have 1GB of memory. If there are any empty=20
slots I
> > do not know.=20
>=20
> Don't you have the possibility to open the box and check? (You could
> check what your sensor chip really is BTW.)
No I can't (at least not easily). The machine is in a lab at work to=20
which I dont have (physical) access to.=20

>=20
> Could you try setting limits? Do:
>=20
> echo 80 > /proc/sys/dev/sensors/lm83-i2c-0-19/temp1
> echo 90 > /proc/sys/dev/sensors/lm83-i2c-0-19/temp2
> echo 100 > /proc/sys/dev/sensors/lm83-i2c-0-19/temp3
> echo 110 > /proc/sys/dev/sensors/lm83-i2c-0-19/temp4
>=20
> Wait a few seconds, and run "i2cdump 0 0x19 b" again. I should be able
> to conclude.
>=20
sensors/sensors -A lm83-i2c-0-19
lm83-i2c-0-19
temp1: +36=B0C (limit =3D +80=B0C)=20
temp2: +35=B0C (limit =3D +90=B0C)=20
temp3: +34=B0C (limit =3D +100=B0C)=20
temp4: +34=B0C (limit =3D +110=B0C)=20

# sensors/sensors -A lm83-i2c-0-19
lm83-i2c-0-19
temp1: +36=B0C (limit =3D +80=B0C)=20
temp2: +35=B0C (limit =3D +90=B0C)=20
temp3: +41=B0C (limit =3D +100=B0C)=20
temp4: +50=B0C (limit =3D +110=B0C)=20

# dump/i2cdump 0 0x19 b
  WARNING! This program can confuse your I2C bus, cause data loss and=20
worse!
  I will probe file /dev/i2c-0, address 0x19, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 24 26 00 00 00 50 50 64 64 64 64 64 64 64 64 64    $&...PPddddddddd
10: 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64    dddddddddddddddd
20: 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64    dddddddddddddddd
30: 21 22 22 22 22 00 00 00 5a 5a 6e 6e 6e 6e 6e 6e    !""""...ZZnnnnnn
40: 6e 6e 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    nn??????????????
50: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
60: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
70: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
80: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
90: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
a0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
b0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
c0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
d0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
e0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f    ????????????????
f0: 00 85 18 35 26 26 26 00 38 25 24 24 24 24 01 03    .??5&&&.8%$$$$??



> > Are the output from the commands I tried correct? seems strange!
>=20
> Unless hexadecimal is your natural alphabet and you speak the sensor
> chip language every day, yes, seems strange. Normally, users don't=20
have
> to deal with this ;)
Ahh! I was looking for 35 not 0x23

>=20
> Thanks a lot for reporting!
>=20
> --=20
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>=20

# sensors-detect=20
 This program will help you to determine which I2C/SMBus modules you=20
need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made=20
sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-
/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev=20
files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things=20
may
 seem a bit confusing, but they will still work.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation, just=20
scanning
 the bus will break your Thinkpad forever!
 If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We=20
have
 had users reporting system breakage on other IBM systems as well.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):=20
[root@to106io1 detect]# ls -l sens*         =20
-rw-r--r--    1 root     root       126191 Jul 31 20:42 sensors-detect
-rwxrwxr-x    1 root     root       120672 Jul 31 13:48 sensors-
detect.bak
[root@to106io1 detect]# chmod +x sensors-detect
[root@to106io1 detect]# ./sensors-detect
 This program will help you to determine which I2C/SMBus modules you=20
need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made=20
sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-
/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev=20
files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things=20
may
 seem a bit confusing, but they will still work.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation, just=20
scanning
 the bus will break your Thinkpad forever!
 If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We=20
have
 had users reporting system breakage on other IBM systems as well.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):=20
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB5 South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):=20
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):=20
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):=20
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang=20
halfway
 through; we can't really help that. Also, some chips will be double=20
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address,=20
you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus PIIX4 adapter at 0580 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):=20
Client found at address 0x19
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Success!
    (confidence 7, driver `lm83')
Client found at address 0x20
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Probing for `Philips Semiconductors PCF8574'... Success!
    (confidence 1, driver `pcf8574')
Client found at address 0x21
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Probing for `Philips Semiconductors PCF8574'... Success!
    (confidence 1, driver `pcf8574')
Client found at address 0x22
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Probing for `Philips Semiconductors PCF8574'... Success!
    (confidence 1, driver `pcf8574')
Client found at address 0x23
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Probing for `Philips Semiconductors PCF8574'... Success!
    (confidence 1, driver `pcf8574')
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `Serial EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x52
Probing for `Serial EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x53
Probing for `Serial EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x54
Probing for `Serial EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x55
Probing for `Serial EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x56
Probing for `Serial EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x57
Probing for `Serial EEPROM'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x64

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): no

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no): no

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:=20

Driver `adm1021' (may not be inserted):
  Misdetects:
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x19
    Chip `Maxim MAX1617' (confidence: 3)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x19
    Chip `National Semiconductor LM84' (confidence: 6)

Driver `lm83' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x19
    Chip `National Semiconductor LM83' (confidence: 7)

Driver `pcf8574' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x20
    Chip `Philips Semiconductors PCF8574' (confidence: 1)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x21
    Chip `Philips Semiconductors PCF8574' (confidence: 1)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x22
    Chip `Philips Semiconductors PCF8574' (confidence: 1)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x23
    Chip `Philips Semiconductors PCF8574' (confidence: 1)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x50
    Chip `Serial EEPROM' (confidence: 1)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x51
    Chip `Serial EEPROM' (confidence: 1)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x52
    Chip `Serial EEPROM' (confidence: 1)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x53
    Chip `Serial EEPROM' (confidence: 1)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x54
    Chip `Serial EEPROM' (confidence: 1)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x55
    Chip `Serial EEPROM' (confidence: 1)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x56
    Chip `Serial EEPROM' (confidence: 1)
  * Bus `SMBus PIIX4 adapter at 0580' (Non-I2C SMBus adapter)
    Busdriver `i2c-piix4', I2C address 0x57
    Chip `Serial EEPROM' (confidence: 1)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver=20
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? smbus

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-piix4
# I2C chip drivers
modprobe lm83
modprobe pcf8574
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really=20
should
try these commands right now to make sure everything is working=20
properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no




