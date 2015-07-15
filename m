From: Dev Anand <anand.dev0@gmail.com>
Date: Wed, 15 Jul 2015 03:27:41 +0000
Subject: [lm-sensors] support for IT8586E
Message-Id: <CANOLSHBWuQCpJTUT3aNi7_rqPwPT4QK7CkVxvhcuyfm4qqFw8g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I got myself a Lenovo z50-75. The fan is always on. And, sensors-detect
reports the following.

Trying family `ITE'...                                      No

Probing for Super-I/O at 0x4e/0x4f

Trying family `National Semiconductor/ITE'...               Yes

Found unknown chip with ID 0x8586


Appears to be IT8586E. Are there any plans of supporting this chip. I don't
see it listed on the http://www.lm-sensors.org/wiki/Devices web site.

Thanks,
Dev
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
