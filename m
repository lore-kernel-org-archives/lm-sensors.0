From: <samu.p.onkalo@nokia.com>
Date: Fri, 16 Apr 2010 05:11:52 +0000
Subject: Re: [lm-sensors] [RFC PATCH] lis3: Change lis3 driver to one module
Message-Id: <62697B07E9803846BC582181BD6FB6B826A8525A49@NOK-EUMSG-02.mgdnok.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1271333702-1729-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1271333702-1729-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>-----Original Message-----
>From: ext Jean Delvare [mailto:khali@linux-fr.org]
>Sent: 15 April, 2010 15:25
>To: Onkalo Samu.P (Nokia-D/Tampere)
>Cc: eric.piel@tremplin-utc.net; lm-sensors@lm-sensors.org
>Subject: Re: [lm-sensors] [RFC PATCH] lis3: Change lis3 driver to one
>module
>
>On Thu, 15 Apr 2010 15:15:02 +0300, Samu Onkalo wrote:
>> If lis3 driver is compiled as module, it consists of two modules:
>> core and interface. However, both of them are mandatory for
>> proper functionality. Furthermore, it is possible to keep
>> /dev/freefall open and remove interface part of the driver.
>> Kernel crashes when the /dev/freefall handle is closed.
>>
>> Makefile is modifed so that now there is
>> only one module. Filename for core part is also changed
>> from lis3lv02d to lis3lv02d-core.c.
>>
>> New modules:
>> lis3lv02d (for hp-laptops)
>> lis3lv02d_i2c for I2C connected boards
>> lis3lv02d_spi for SPI connected boards.
>
>This duplicates 11kB of binary code across 3 drivers. And you won't be
>able to load more than one of them due to common symbols. So, nack.
>There must be a better way to solve this problem.

Well, there is only one statically reserved instance of lis3_dev which contains
pointers to interface specific functions. It is possible to use only one 
interface at time, I think.

-Samu


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
