From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Mar 2012 11:48:16 +0000
Subject: Re: [lm-sensors] help with ads1015
Message-Id: <20120301124816.5b7a3034@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20120301T115547-727@post.gmane.org>
In-Reply-To: <loom.20120301T115547-727@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 1 Mar 2012 11:35:29 +0000 (UTC), Pierantonio Tabaro wrote:
> Hi,
> i have a arm mx28 board with a couple of ads1015,
> i have ported the driver from:  
> "[PATCH v4] hwmon: Add support for Texas Instruments ADS1015"
> to my kernel 2.6.35.3
> 
> when i boot the board and probe the two modules hwmon.ko and ads1015.ko nothing 
> happens.
> 
> with i2cdump i see the chips,i am sure of this because the default values for 
> some registers are 0x8583, 0x8000 and 0x7fff. 
> 
> sample output for one chip:
> 
> root@picomaster ~$ i2cdump 0 0x48 w
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x48, mode word
> Continue? [Y/n] 
>      0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
> 00: 0000 8385 0080 ff7f 0000 8385 0080 XXXX 
> 08: 0000 8385 0080 ff7f 0000 8385 0080 XXXX 
> 
> On sysfs i see this:
> 
> root@picomaster ~$ find /sys/ | grep ads1015
> /sys/bus/i2c/drivers/ads1015
> /sys/bus/i2c/drivers/ads1015/module
> /sys/bus/i2c/drivers/ads1015/uevent
> /sys/bus/i2c/drivers/ads1015/unbind
> /sys/bus/i2c/drivers/ads1015/bind
> /sys/module/hwmon/holders/ads1015
> /sys/module/ads1015
> /sys/module/ads1015/holders
> /sys/module/ads1015/initstate
> /sys/module/ads1015/refcnt
> /sys/module/ads1015/sections
> /sys/module/ads1015/sections/.text
> /sys/module/ads1015/sections/.exit.text
> /sys/module/ads1015/sections/.init.text
> /sys/module/ads1015/sections/.rodata
> /sys/module/ads1015/sections/.rodata.str1.1
> /sys/module/ads1015/sections/.data
> /sys/module/ads1015/sections/.gnu.linkonce.this_module
> /sys/module/ads1015/sections/.note.gnu.build-id
> /sys/module/ads1015/sections/.symtab
> /sys/module/ads1015/sections/.strtab
> /sys/module/ads1015/notes
> /sys/module/ads1015/notes/.note.gnu.build-id
> /sys/module/ads1015/drivers
> /sys/module/ads1015/drivers/i2c:ads1015
> 
> root@picomaster ~$ find /sys/module/hwmon/
> /sys/module/hwmon/
> /sys/module/hwmon/holders
> /sys/module/hwmon/holders/ads1015
> /sys/module/hwmon/initstate
> /sys/module/hwmon/refcnt
> /sys/module/hwmon/sections
> /sys/module/hwmon/sections/.text
> /sys/module/hwmon/sections/.exit.text
> /sys/module/hwmon/sections/.init.text
> /sys/module/hwmon/sections/__ksymtab_strings
> /sys/module/hwmon/sections/__kcrctab_gpl
> /sys/module/hwmon/sections/.rodata.str1.1
> /sys/module/hwmon/sections/__ksymtab_gpl
> /sys/module/hwmon/sections/.gnu.linkonce.this_module
> /sys/module/hwmon/sections/.note.gnu.build-id
> /sys/module/hwmon/sections/.bss
> /sys/module/hwmon/sections/.symtab
> /sys/module/hwmon/sections/.strtab
> /sys/module/hwmon/notes
> /sys/module/hwmon/notes/.note.gnu.build-id
> 
> I expect to have the inputs value to sysfs, according to source something like 
> that: /sys/.../ads1015/in_0_input

Yes, you are missing something. Please read:
Documentation/i2c/instantiating-devices
Method 3 is not implemented by the ads1015 driver because the devices
it supports have no identification registers, so you'll have to use one
of the three other methods.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
