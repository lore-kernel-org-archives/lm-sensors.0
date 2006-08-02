From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Wed, 02 Aug 2006 14:48:21 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04704F7F7BA@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
 
    We recently upgraded from Linux v2.4.9 to 2.6.9 and are trying to go
from lm_sensors 2.8.7 to 2.10.0.
 
    the old version of sensors works on the new system, but the VBatt
readings are incorrect.  Most of the other values seem to be fine
though.
 
    using sensors-detect, we find (ignoring all the "Failed!" lines) :
 
    Probing for PCI bus adapters
    Use driver 'i2c-i801' for device 00:1f.3 : Intel 82801DB ICH4
    ......
    Module 'i2c-i801' already loaded
    ......
    i2c-dev is already loaded
    .......
    Next adapter: SMBus I801 adapter at 1100
    ......
    Client found at address 0x18
    Probing for 'Maxim MAC1617'... Success!
        (confidence 3, driver 'adm1021')
    ......
    Client found at address 0x1a
    Probing for 'Maxim MAC1617'... Success!
        (confidence 3, driver 'adm1021')
    ....
    Client found at address 0x2d
    Probing for 'Winbond W83627HF'... Success!
        (confidence 8, driver 'w83781d'), other addresses: 0x48 0x49
    .....
    Client found at address 0x2e
    Probing for 'LM87'... Success!
        (confidence 7, driver 'LM87')
    .... 
    Client found at address 0x30
    Client found at address 0x48
    Client found at address 0x49
    Client found at address 0x61
    Probing for 'SMBus 2.0 ARP-Capable Device'... Success!
        confidence 1, driver 'smbus-arp'
    Client found at address 0x69
    .....
    ISA scan:
    Probing for Winbond W83627HF'... Success!
        (confidence 8, driver 'w83781d')
        Alias of the chip on I2C bus 'SMBus I801 adapter at 1100'
    .....
 
    #---cut here----
    # I2C module options
    alias char-major-89 i2c-dev
    options w83781d ignore=0,0x2d
    #----cut here-----
 
    #---cut here----
    # I2C adapter drivers
    modprobe i2c-i801
    modprobe i2c-isa
    # I2C chip drivers
    modprobe adm1021
    modprobe w83781d
    # Warning:  required module lm87 is not currently installed on your
system.
    modprobe lm87
    # Warning:  required module smbus-arp is not currently installed on
your system.
    modprobe smbus-arp
    modprobe w83627hf
    #----cut here-----
             
 
so i load all available libraries and run sensors -s it returns flex
scanner jammed.
 
modules loaded:
w83781d
w83627hf
i2c-isa
i2c-sensor
i2c-i801
i2c-dev
i2c-core
 
i tried getting the new sensors.conf file, and copying over old ones,
and even trying an empty file, none of which work...
 
i also tried removing modules down to just sensors, i801 and w83781d,
and removing ones until i got the proc/sysfs error message, then adding
modules back up until the flex scanner message returned.
 
any help or suggestions would be very useful, thanks...
 
 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060802/dbfaf3cf/attachment.html 
