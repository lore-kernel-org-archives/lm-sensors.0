From: horol@developers.sk (Martin Kyrc)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c-proc and kernel 2.6.0-test11 HOWTO
Message-Id: <1071569283.1551.34.camel@ta3>
List-Id: <lm-sensors.vger.kernel.org>
References: <1071508087.2621.13.camel@ta3>
In-Reply-To: <1071508087.2621.13.camel@ta3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean!

Thank you for help. I have download lm-sensors 2.8.2; make user; make
user_install, and sensors running!

But, I have little problem ;). (bottom, or mark <#####)

When I run sensors-detect, output is:

$ sensors-detect 
<cut>
..
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:07.4: VIA Technologies VT82C686
Apollo ACPI
Use driver `rivatv' for device 01:00.0: GeForce2 MX
Probe succesfully concluded.
..
Next adapter: SMBus Via Pro adapter at 5000 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')                           <#####
Probing for `National Semiconductor LM85'... Failed!
..
 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): 
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Success!
    (confidence 9, driver `via686a')
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
..

---|summary|----------------------------------------------------
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 

Driver `lm80' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x2d
    Chip `National Semiconductor LM80' (confidence: 3)

Driver `via686a' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Chip `VIA Technologies VT82C686 Integrated Sensors' (confidence: 9)
---|end of summary|-------------------------------------------

..
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
modprobe lm80                                       <#####
modprobe via686a
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----
</cut>

OK. I have all modules, but modul lm80 I have not :(.

In lm-sensors/README writes:
<cut>
FOR 2.6/2.5 KERNELS, Use only the userspace tools in this package!
Build and install them with 'make user' and 'make user_install'.
The kernel modules in this package will not compile for 2.6/2.5;
use the drivers already in the 2.5 kernel development tree.
</cut>
(I can't run 'make' and 'make install'.)

But, I have in my kernel-source-2.6.0-test11 only this:

$ ls /usr/src/linux/drivers/i2c/chips

/usr/src/linux/drivers/i2c/chips:
Kconfig  Makefile  adm1021.c  eeprom.c  it87.c  lm75.c  lm78.c  lm85.c 
via686a.c  w83781d.c

I have not lm80.c! 

???????

Is this problem? 
How can I continues?
Is possible use sensors for my mainboard and chipset with linux
2.6.0-test11?
Any ideas? 

thx
-- 
                                                         \ /
                                                       /\ o -
                                                    /\/  \ \ 
+-[ horol ]----------------------------------------/ /    \---+
| e-mail ........................... horol (at) developers.sk |
| ICQ number ....................................... 95090557 |
| IRC nick/channel ..................... horol/ #ta3, #kosice |
+-------------------------------------------------------------+
| Please do not send me any attachments in proprietary        |
| formats (*.doc,*.xls, *.pps,...). Read more at              |       
| http://www.gnu.org/philosophy/no-word-attachments.html      |
+-------------------------------------------------------------+
  Message Of The Day:
Early to bed and early to rise and you'll be groggy when everyone else
is
wide awake.
