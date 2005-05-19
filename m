From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: lm_sensors problem
Message-Id: <20050227212318.2878f53a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

(Moving to the LM Sensors mailing list so that it ends up in the archives.)

> I have a problem with lm_sensors, and I saw you discussing exactly
> same problem on some forum - but the discussion was not finished. If
> you have some time could you please try to help me? The problem is:
> 
> - I have computer based on intel d865 perl motherboard, with fedora
> core 3  installed (almost minimal instalation) and with
> lm_sensors-2.9.0-38.1.rhfc3.at.i386.rpm
> 
> - sensors_detect passes ok, and instructs me to do following:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> 
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> modprobe i2c-isa
> # I2C chip drivers
> modprobe lm85
> modprobe smbus-arp
> # no driver for Nat. Semi. PC87372 Super IO Fan Sensors yet
> # sleep 2 # optional
> /usr/bin/sensors -s # recommended
> #----cut here---
> 
>  
> I did what it asked for, all modules loads, except:
> 
> modprobe smbus-arp  prints:
> FATAL: module smbus_arp not found.

That one was not ported to Linux 2.6 and is not interesting for end
users anyway. Forget about it.

> And sensors subsequently displays only following information:
> eeprom-i2c-0-50
> Adapter: SMBus I801 adapter at c800
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512
>  
> Absolutely no information about temperature or fan speed. I spent a
> day searching on interned, I tried to install older version of
> lm_sensors, tried to install latest i2c package, I even tried to
> install fedora core 2, but nothing helped. Do you have any idea? 

The lm85 driver should provide hardware monitoring data. If it doesn't,
it means that the chip detection failed. If sensors-detect found an SMSC
chip it's a known bug, fixed by now but maybe you don't want to upgrade
kernels.

Solution:
modprobe i2c-dev
i2cdetect 0

A chip will show at address 0x2c, 0x2d or 0x2e. Note the address. Then,
when loading the lm85 driver, add a force parameter:

modprobe lm85 force=0,0x2c # replace with the real address if different

That should do it. If it works you can add the following line in
/etc/modprobe.conf:
option lm85 force=0,0x2c
So that the trick will still be active after reboot.

Hope that helps,
-- 
Jean Delvare
