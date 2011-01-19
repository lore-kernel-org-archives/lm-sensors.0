From: Jerry Lin <jerry@lincircle.com>
Date: Wed, 19 Jan 2011 18:52:04 +0000
Subject: Re: [lm-sensors] user question about how to load xeontemp
Message-Id: <AANLkTinW=8MUoJMSMbpXGp7pbo2kpDkQ7JnQz7aGjWyG@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
In-Reply-To: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Jan 18, 2011 at 11:33 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Wed, Jan 19, 2011 at 01:29:28AM -0500, Jerry Lin wrote:
>> > S5500HCV board spec shows a TMP75 sensor. Can you try to load the lm75=
 module instead?
>>
>> "sudo modprobe lm75" yields no error message, but "sudo
>> sensors-detect" yields the same result. ("modprobe -l | grep lm75"
>> yields "kernel/drivers/hwmon/lm75.ko"). I'm not totally sure that I'm
>> doing this correctly:
>>
> You would have to run "modprobe -r adm1021" first.
>
> Anyway, the board supports DDR3, and DDR3 has JC42 compliant temperature =
sensors
> which are usually at i2c address 0x18..0x1f. So, especially if you have f=
our DDR3
> DIMMs installed, that is probably what you have there.
>
> Anyway, please load
> =A0 =A0 =A0 =A0http://khali.linux-fr.org/devel/misc/sensors-detect
> and run it. This is the latest version of sensors-detect. It should detect
> if the CPU supports sensors or not, and if the sensors at 0x18.. are jc42=
 sensors.
> Make sure you remove the adm1021 driver before you run sensors-detect.

"sudo modprobe -r adm1021" yields no error message, and then

"sudo perl sensors-detect" yields a more promising result (I think the
detection worked correctly), but I think I'm missing drivers. First,
the output for sensors-detect:

"# sensors-detect revision 5904 (2011-01-18 18:20:42 +0100)
# System: Intel Corporation S5520HC

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Found `IPMI BMC KCS' at 0xca2...                            Success!
    (confidence 8, driver `ipmisensors')

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel ICH10
Module i2c-dev loaded successfully.

Next adapter: SMBus I801 adapter at 2000 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x18
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'...                             No
Probing for `Maxim MAX1668'...                              No
Probing for `Maxim MAX1805'...                              No
Probing for `Maxim MAX1989'...                              No
Probing for `Maxim MAX6655/MAX6656'...                      No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1618'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `Maxim MAX6654'...                              No
Probing for `Maxim MAX6690'...                              No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Maxim MAX6695/MAX6696'...                      No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `National Semiconductor LM64'...                No
Probing for `SMSC EMC1403'...                               No
Probing for `SMSC EMC1404'...                               No
Probing for `SMSC EMC1423'...                               No
Probing for `ST STTS424'...                                 No
Probing for `ST STTS424E'...                                Success!
    (confidence 5, driver `jc42')
Probing for `NXP SE97/SE97B'...                             No
Probing for `NXP SE98'...                                   No
Probing for `Analog Devices ADT7408'...                     No
Probing for `IDT TS3000/TSE2002'...                         No
Probing for `Maxim MAX6604'...                              No
Probing for `Microchip MCP98242'...                         No
Probing for `Microchip MCP98243'...                         No
Probing for `Microchip MCP9843'...                          No
Probing for `ON CAT6095/CAT34TS02'...                       No
Client found at address 0x19
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'...                             No
Probing for `Maxim MAX1668'...                              No
Probing for `Maxim MAX1805'...                              No
Probing for `Maxim MAX1989'...                              No
Probing for `Maxim MAX6655/MAX6656'...                      No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1618'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `Maxim MAX6654'...                              No
Probing for `Maxim MAX6690'...                              No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Maxim MAX6695/MAX6696'...                      No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `National Semiconductor LM95231'...             No
Probing for `National Semiconductor LM95241'...             No
Probing for `ST STTS424'...                                 No
Probing for `ST STTS424E'...                                Success!
    (confidence 5, driver `jc42')
Probing for `NXP SE97/SE97B'...                             No
Probing for `NXP SE98'...                                   No
Probing for `Analog Devices ADT7408'...                     No
Probing for `IDT TS3000/TSE2002'...                         No
Probing for `Maxim MAX6604'...                              No
Probing for `Microchip MCP98242'...                         No
Probing for `Microchip MCP98243'...                         No
Probing for `Microchip MCP9843'...                          No
Probing for `ON CAT6095/CAT34TS02'...                       No
Client found at address 0x1a
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'...                             No
Probing for `Maxim MAX1668'...                              No
Probing for `Maxim MAX1805'...                              No
Probing for `Maxim MAX1989'...                              No
Probing for `Maxim MAX6655/MAX6656'...                      No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1618'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `Maxim MAX6654'...                              No
Probing for `Maxim MAX6690'...                              No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Maxim MAX6695/MAX6696'...                      No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `ST STTS424'...                                 No
Probing for `ST STTS424E'...                                Success!
    (confidence 5, driver `jc42')
Probing for `NXP SE97/SE97B'...                             No
Probing for `NXP SE98'...                                   No
Probing for `Analog Devices ADT7408'...                     No
Probing for `IDT TS3000/TSE2002'...                         No
Probing for `Maxim MAX6604'...                              No
Probing for `Microchip MCP98242'...                         No
Probing for `Microchip MCP98243'...                         No
Probing for `Microchip MCP9843'...                          No
Probing for `ON CAT6095/CAT34TS02'...                       No
Client found at address 0x1b
Probing for `Maxim MAX6650/MAX6651'...                      No
Probing for `ST STTS424'...                                 No
Probing for `ST STTS424E'...                                Success!
    (confidence 5, driver `jc42')
Probing for `NXP SE97/SE97B'...                             No
Probing for `NXP SE98'...                                   No
Probing for `Analog Devices ADT7408'...                     No
Probing for `IDT TS3000/TSE2002'...                         No
Probing for `Maxim MAX6604'...                              No
Probing for `Microchip MCP98242'...                         No
Probing for `Microchip MCP98243'...                         No
Probing for `Microchip MCP9843'...                          No
Probing for `ON CAT6095/CAT34TS02'...                       No
Client found at address 0x1c
Probing for `ST STTS424'...                                 No
Probing for `ST STTS424E'...                                Success!
    (confidence 5, driver `jc42')
Probing for `NXP SE97/SE97B'...                             No
Probing for `NXP SE98'...                                   No
Probing for `Analog Devices ADT7408'...                     No
Probing for `IDT TS3000/TSE2002'...                         No
Probing for `Maxim MAX6604'...                              No
Probing for `Microchip MCP98242'...                         No
Probing for `Microchip MCP98243'...                         No
Probing for `Microchip MCP9843'...                          No
Probing for `ON CAT6095/CAT34TS02'...                       No
Client found at address 0x1d
Probing for `ST STTS424'...                                 No
Probing for `ST STTS424E'...                                Success!
    (confidence 5, driver `jc42')
Probing for `NXP SE97/SE97B'...                             No
Probing for `NXP SE98'...                                   No
Probing for `Analog Devices ADT7408'...                     No
Probing for `IDT TS3000/TSE2002'...                         No
Probing for `Maxim MAX6604'...                              No
Probing for `Microchip MCP98242'...                         No
Probing for `Microchip MCP98243'...                         No
Probing for `Microchip MCP9843'...                          No
Probing for `ON CAT6095/CAT34TS02'...                       No
Client found at address 0x2e
Probing for `Myson MTP008'...                               No
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM85'...                No
Probing for `National Semiconductor LM96000 or PC8374L'...  No
Probing for `Analog Devices ADM1027'...                     No
Probing for `Analog Devices ADT7460 or ADT7463'...          No
Probing for `SMSC EMC6D100 or EMC6D101'...                  No
Probing for `SMSC EMC6D102'...                              No
Probing for `SMSC EMC6D103'...                              No
Probing for `Winbond WPCD377I'...                           No
Probing for `Analog Devices ADT7467 or ADT7468'...          No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Analog Devices ADT7473'...                     No
Probing for `Analog Devices ADT7475'...                     No
Probing for `Analog Devices ADT7476'...                     No
Probing for `Analog Devices ADT7490'...                     No
Probing for `Andigilog aSC7611'...                          No
Probing for `Andigilog aSC7621'...                          No
Probing for `National Semiconductor LM87'...                No
Probing for `Analog Devices ADM1024'...                     No
Probing for `National Semiconductor LM93'...                No
Probing for `National Semiconductor LM94'...                No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83791D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Nuvoton W83795G/ADG'...                        No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG/W83667HG/W83677HG'...        No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Winbond W83L785TS-S'...                        No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1026'...                     No
Probing for `Analog Devices ADM1025'...                     No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `Analog Devices ADM1029'...                     No
Probing for `Analog Devices ADM1030'...                     No
Probing for `Analog Devices ADM1031'...                     No
Probing for `Analog Devices ADM1022'...                     No
Probing for `Texas Instruments THMC50'...                   No
Probing for `Analog Devices ADM1028'...                     No
Probing for `Texas Instruments THMC51'...                   No
Probing for `ITE IT8712F'...                                No
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           No
Probing for `SMSC EMC2103'...                               No
Probing for `Fintek F75373S/SG'...                          No
Probing for `Fintek F75375S/SP'...                          No
Probing for `Fintek F75387SG/RG'...                         No
Probing for `Winbond W83791SD'...                           No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `jc42':
  * Bus `SMBus I801 adapter at 2000'
    Busdriver `i2c_i801', I2C address 0x18
    Chip `ST STTS424E' (confidence: 5)
  * Bus `SMBus I801 adapter at 2000'
    Busdriver `i2c_i801', I2C address 0x19
    Chip `ST STTS424E' (confidence: 5)
  * Bus `SMBus I801 adapter at 2000'
    Busdriver `i2c_i801', I2C address 0x1a
    Chip `ST STTS424E' (confidence: 5)
  * Bus `SMBus I801 adapter at 2000'
    Busdriver `i2c_i801', I2C address 0x1b
    Chip `ST STTS424E' (confidence: 5)
  * Bus `SMBus I801 adapter at 2000'
    Busdriver `i2c_i801', I2C address 0x1c
    Chip `ST STTS424E' (confidence: 5)
  * Bus `SMBus I801 adapter at 2000'
    Busdriver `i2c_i801', I2C address 0x1d
    Chip `ST STTS424E' (confidence: 5)

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)

Driver `ipmisensors':
  * ISA bus, address 0xca2
    Chip `IPMI BMC KCS' (confidence: 8)

Warning: the required module jc42 is not currently installed
on your system. If it is built into the kernel then it's OK.
Otherwise, check http://www.lm-sensors.org/wiki/Devices for
driver availability.

Warning: the required module ipmisensors is not currently installed
on your system. If it is built into the kernel then it's OK.
Otherwise, check http://www.lm-sensors.org/wiki/Devices for
driver availability.

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors
for initialization at boot time.
You should now start the lm_sensors service to load the required
kernel modules.

Unloading i2c-dev... OK
Unloading cpuid... OK"


To test the result, "sensors" yields:

"No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are."

"sudo modprobe ipmi-si" yields no errors.

"sudo modprobe coretemp" yields
"FATAL: Error inserting coretemp
(/lib/modules/2.6.32-27-generic/kernel/drivers/hwmon/coretemp.ko): No
such device"

"sudo modprobe jc42" yields
"FATAL: Module jc42 not found."

Questions:
1) What's the name of the jc42 module that I would need to load via modprob=
e?
2a) sensors-detect mentions copying from "prog/init/lm_sensors.init"
-- where is that prog directory?
2b) Does doing that copy of lm_sensors.init take the place of
copying-and-pasting the module lines into the /etc/modules file in the
older version of the script?
3) Is "ipmisensors" the same as "ipmi-si" (as in "modprobe ipmi-si")?
4) Why is sensors-detect able to detect the sensor via the coretemp
driver, but modprobe not able to load it?
5) Is there something else that I should be doing?

In regards to Jean's response:

> Jerry, please try the stand-alone coretemp driver at:
> =A0http://khali.linux-fr.org/devel/misc/coretemp/
> This is basically the version from the latest kernel, with some
> compatibility bits added so that it builds and runs on older kernels
> too.
>
> Installation instructions can be downloaded from:
> =A0http://khali.linux-fr.org/devel/misc/INSTALL
> This is a document I just wrote, let me know if it contains errors or
> can be improved in any way.

Thanks for your instructions. I was able to follow your instructions
until the make step, at which point I got:

"Makefile:37: warning: overriding commands for target `modules_install'
Makefile:29: warning: ignoring old commands for target `modules_install'
/home/jerry/coretemp/Makefile:37: warning: overriding commands for
target `modules_install'
/home/jerry/coretemp/Makefile:29: warning: ignoring old commands for
target `modules_install'
  CC [M]  /home/jerry/coretemp/coretemp.o
/home/jerry/coretemp/coretemp.c:572: warning: data definition has no
type or storage class
/home/jerry/coretemp/coretemp.c:572: warning: type defaults to =E2 in
declaration of =E2
/home/jerry/coretemp/coretemp.c:573: error: expected identifier or =E2
before =E2 token
/home/jerry/coretemp/coretemp.c:574:2: error: #endif without #if
/home/jerry/coretemp/coretemp.c:576: error: expected declaration
specifiers or =E2 before =E2 token
/home/jerry/coretemp/coretemp.c:576: warning: data definition has no
type or storage class
/home/jerry/coretemp/coretemp.c:576: warning: type defaults to =E2 in
declaration of =E2

/home/jerry/coretemp/coretemp.c:576: warning: function declaration
isn=E2t a prototype
/home/jerry/coretemp/coretemp.c:577: error: expected identifier or =E2 befo=
re =E2
/home/jerry/coretemp/coretemp.c:583: error: expected =E2, =E2, =E2, =E2 or =
=E2
before =E2 token
/home/jerry/coretemp/coretemp.c:585: error: expected identifier or =E2
before =E2 token
/home/jerry/coretemp/coretemp.c:587: error: redefinition of =E2
/home/jerry/coretemp/coretemp.c:550: note: previous definition of =E2 was h=
ere
/home/jerry/coretemp/coretemp.c:606: error: redefinition of =E2
/home/jerry/coretemp/coretemp.c:570: note: previous definition of =E2 was h=
ere
/home/jerry/coretemp/coretemp.c:606: error: redefinition of =E2
/home/jerry/coretemp/coretemp.c:570: note: previous definition of =E2 was h=
ere
/home/jerry/coretemp/coretemp.c:607: error: redefinition of =E2
/home/jerry/coretemp/coretemp.c:571: note: previous definition of =E2 was h=
ere
/home/jerry/coretemp/coretemp.c:607: error: redefinition of =E2
/home/jerry/coretemp/coretemp.c:571: note: previous definition of =E2 was h=
ere
make[2]: *** [/home/jerry/coretemp/coretemp.o] Error 1
make[1]: *** [_module_/home/jerry/coretemp] Error 2
make: *** [modules] Error 2"

When I view the source via less, I don't see the "=E2" characters (I
retrieved the source via wget).

"gcc -v" yields
"Using built-in specs.
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion=3D'Ubuntu
4.4.3-4ubuntu5'
--with-bugurl=3Dfile:///usr/share/doc/gcc-4.4/README.Bugs
--enable-languages=3Dc,c++,fortran,objc,obj-c++ --prefix=3D/usr
--enable-shared --enable-multiarch --enable-linker-build-id
--with-system-zlib --libexecdir=3D/usr/lib --without-included-gettext
--enable-threads=3Dposix --with-gxx-include-dir=3D/usr/include/c++/4.4
--program-suffix=3D-4.4 --enable-nls --enable-clocale=3Dgnu
--enable-libstdcxx-debug --enable-plugin --enable-objc-gc
--disable-werror --with-arch-32=3Di486 --with-tune=3Dgeneric
--enable-checking=3Drelease --build=3Dx86_64-linux-gnu
--host=3Dx86_64-linux-gnu --target=3Dx86_64-linux-gnu
Thread model: posix
gcc version 4.4.3 (Ubuntu 4.4.3-4ubuntu5) "

"make -v" yields
"GNU Make 3.81
Copyright (C) 2006  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

This program built for x86_64-pc-linux-gnu"

Questions:
1) Is there something I should do differently to get the module compiled?
2) If I upgraded the kernel to 2.6.35, would most of my problems go
away? (I can't easily do that right now because the machines are in
use, but I can try to do that at the next maintenance window.)

Thanks for your help!
Jerry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
