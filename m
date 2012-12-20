From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 20 Dec 2012 01:07:33 +0000
Subject: [lm-sensors] i2c tools build failure with gcc 4.6
Message-Id: <20121220010733.GA31336@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Seen with latest i2c-tools from svn repository.

gcc 4.6:

gcc-4.6  -Llib -li2c -o tools/i2cdetect tools/i2cdetect.o tools/i2cbusses.o
tools/i2cdetect.o: In function `main':
i2cdetect.c:(.text.startup+0x557): undefined reference to `i2c_smbus_write_quick'
i2cdetect.c:(.text.startup+0x5e9): undefined reference to `i2c_smbus_read_byte'
collect2: ld returned 1 exit status
make: *** [tools/i2cdetect] Error 1

gcc-4.4:
gcc-4.4  -Llib -li2c -o tools/i2cdetect tools/i2cdetect.o tools/i2cbusses.o

[ no error ]

Any idea ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
