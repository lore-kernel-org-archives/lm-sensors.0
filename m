From: matt@lqx.net (Matt Kulka)
Date: Thu, 09 Feb 2006 19:15:06 +0000
Subject: [lm-sensors] lm93 driver for 2.6
Message-Id: <55F0BEFC-1AA3-486A-BF3E-FA06EAA5895B@lqx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
In-Reply-To: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm attempting to build the lm93 driver on kernel 2.6.14. The patches  
(specifically the 2.6.13-rc3-mm3 version) provided by Eric Bowersox  
patch the appropriate source files successfully. However, building  
fails due to some missing files and undeclared variables, below is  
the output. Is there an appropriate patch for 2.6.14?

drivers/hwmon/lm93.c:42:30: linux/i2c-sensor.h: No such file or  
directory
drivers/hwmon/lm93.c:43:27: linux/i2c-vid.h: No such file or directory
drivers/hwmon/lm93.c:59: warning: type defaults to `int' in  
declaration of `SENSORS_INSMOD_1'
drivers/hwmon/lm93.c:59: warning: parameter names (without types) in  
function declaration
drivers/hwmon/lm93.c:59: warning: data definition has no type or  
storage class
drivers/hwmon/lm93.c:141: error: field `type' has incomplete type
drivers/hwmon/lm93.c: In function `LM93_VID_FROM_REG':
drivers/hwmon/lm93.c:242: warning: implicit declaration of function  
`vid_from_reg'
drivers/hwmon/lm93.c: In function `lm93_detect':
drivers/hwmon/lm93.c:2261: error: `lm93' undeclared (first use in  
this function)
drivers/hwmon/lm93.c:2261: error: (Each undeclared identifier is  
reported only once
drivers/hwmon/lm93.c:2261: error: for each function it appears in.)
drivers/hwmon/lm93.c: In function `lm93_attach_adapter':
drivers/hwmon/lm93.c:2363: warning: implicit declaration of function  
`i2c_detect'
drivers/hwmon/lm93.c:2363: error: `addr_data' undeclared (first use  
in this function)
drivers/hwmon/lm93.c: At top level:
drivers/hwmon/lm93.c:56: warning: 'normal_i2c' defined but not used
make[2]: *** [drivers/hwmon/lm93.o] Error 1
make[1]: *** [drivers/hwmon] Error 2
make: *** [drivers] Error 2


Matt Kulka
matt at lqx.net




