From: matt@lqx.net (Matt Kulka)
Date: Sun, 12 Feb 2006 08:20:51 +0000
Subject: [lm-sensors] lm93 driver for 2.6
Message-Id: <364C9071-720E-4D6C-8018-16FD75CCE818@lqx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
In-Reply-To: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks a bunch, Jean. Those changes worked great. The only remaining  
issue after editing the renames was that an "i2c_detect" call was  
unresolved. After some poking around, I saw that "i2c_probe" was  
virtually the same so I renamed that as well. After that, it compiles  
fine and works great.

Thanks again for your help!

---
Matt Kulka
matt at lqx.net

On Feb 10, 2006, at 3:17 AM, Jean Delvare wrote:

>
> Hi Matt,
>
> On 2006-02-09, Matt Kulka wrote:
>> I'm attempting to build the lm93 driver on kernel 2.6.14. The patches
>> (specifically the 2.6.13-rc3-mm3 version) provided by Eric Bowersox
>> patch the appropriate source files successfully. However, building
>> fails due to some missing files and undeclared variables, below is
>> the output. Is there an appropriate patch for 2.6.14?
>
> Not that I know of, but others may have worked on it. There have been
> some changes in the i2c/hwmon realm since 2.6.13 so I'm not surprised
> that the old patch doesn't work anymore.
>
>> drivers/hwmon/lm93.c:42:30: linux/i2c-sensor.h: No such file or
>> directory
>
> Has been renamed to linux/hwmon.h.
>
>> drivers/hwmon/lm93.c:43:27: linux/i2c-vid.h: No such file or  
>> directory
>
> Has been renamed to linux/hwmon-vid.h.
>
>> drivers/hwmon/lm93.c:59: warning: type defaults to `int' in
>> declaration of `SENSORS_INSMOD_1'
>
> Has been renamed to I2C_CLIENT_INSMOD_1.
>
> Just changing these three changes should let you go somewhat further.
> Also note that you'll need an additional patch which restores the an
> SMBus block read function needed by the lm93 driver:
>
> http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-add-smbus-block- 
> read.patch
>
> Ideally we would merge the lm93 driver into mainline so that users can
> just use it, but that's a very large driver which would need some more
> review before I can accept it - and I don't have the time for that
> review work myself.
>
> --
> Jean Delvare


