From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 01 Mar 2012 11:53:21 +0000
Subject: Re: [lm-sensors] help with ads1015
Message-Id: <20120301115321.GA15972@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20120301T115547-727@post.gmane.org>
In-Reply-To: <loom.20120301T115547-727@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 01, 2012 at 06:35:29AM -0500, Pierantonio Tabaro wrote:
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
ads1015 does not have a detect function, so you have to enter:

echo ads1015 0x48 > /sys/class/i2c-adapter/i2c-0/new_device

modprobe etc. is not necessary.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
