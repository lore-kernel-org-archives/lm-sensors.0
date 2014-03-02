From: Romanic Dean <romanicdean@gmail.com>
Date: Sun, 02 Mar 2014 07:30:33 +0000
Subject: [lm-sensors] LM73 chip access through userspace
Message-Id: <CAAi8uRy6EmTDvKavChvx6_bUZvcoVD3Et=Tt5R66h6NkkHAcUA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am working with 3.8 version of kernel and its device tree driven kernel
I wanted to read temperature from lm73 sensor.It should happen from user
land application.

Now first of all have enabled the dts support for lm73 device by adding
below in my dts file

dtt@49 {
    compatible = "lm73";
    reg = <0x49>;
    };

and kernel driver compiled is lm73.o .

I could see in my boot logs that driver's probe method is called ,so now
how DO I confirm that lm73 device is Probed OK and usable?

Now if it initialized OK then what all expected entries I should see in
/sys/bus/i2c/devices file system?

How Do I read temperature from lm73 sensor using sysfs in userspace?

Thanks
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
