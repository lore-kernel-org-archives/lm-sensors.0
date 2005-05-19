From: tobias.edler@stud.uni-goettingen.de (Tobias Edler)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: asb100 Bach
Message-Id: <3D09D5C4.7070200@stud.uni-goettingen.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi !
I have a Asus A7v333 mainboard, and cant get all the information, the
sensor should deliver. The chip is labeld ASB100 Bach, the manual calls
it "ASUS Asic with thermal controller".  Here's the result from
sensors-detect :

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `bt848 #0' (Bit-shift algorithm)
    Busdriver `UNKNOWN', I2C address 0x50
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)

Driver `pcf8591' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x48
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  Misdetects:
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x49
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `lm75' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 3)

Driver `ds1621' (may not be inserted):
  Misdetects:
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x49
    Chip `Dallas Semiconductor DS1621' (confidence: 3)
#----cut here----
# I2C adapter drivers
# modprobe unknown adapter bt848 #0 using Bit-shift algorithm
# modprobe unknown adapter bt848 #0 using Bit-shift algorithm
modprobe i2c-viapro
# I2C chip drivers
modprobe eeprom
modprobe pcf8591
modprobe lm75
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
options pcf8591 ignore=1,0x49
#----cut here----

What exactly does "may not be inserted" mean ? Won't work ? might cause
problems ? will blow up my computer ?

with lm75, the temperature is disoplayed correctly, but not voltages,
fan speeds, MB temp.

Can any of you give me a hint ?

Regards
- --
________
\  |      GPG (PGP) Key: www.stud.uni-goettingen.de/~s242275/pgpkey.pub
 \ |--    Jabber-ID at a-message.de: te_linuxguru
  \|____  ICQ: 124557012

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9CdXCKpMiVYRJv9YRAt+IAJ9/bINclYVvLiGcUoTwIZZj36b3VgCfRl7Q
hh06l1CK+xZ+9OS+qig8ds4=Wdo2
-----END PGP SIGNATURE-----
