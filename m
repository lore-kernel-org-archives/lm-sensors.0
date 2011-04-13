From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 13 Apr 2011 13:11:10 +0000
Subject: Re: [lm-sensors] [PATCH] hwmod: sensors: mma845x gravity sensor
Message-Id: <4DA5A0EE.7040505@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302695813-9606-1-git-send-email-jiejing.zhang@freescale.com>
In-Reply-To: <1302695813-9606-1-git-send-email-jiejing.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/13/11 13:33, Jean Delvare wrote:
> On Wed, 13 Apr 2011 19:56:53 +0800, Zhang Jiejing wrote:
>> This patch add basic support for mma8450 mma8451 gravity
>> sensor chips, and will support mma8452, mma8453 in same
>> driver file.
>>
>> They are i2c controller and support 3-axis gravity accelerator
>> sensor.
>>
>> mma8450 have some different from mma845[1,2,3] in register map, so
>> there are some switch case between mma8450 and others.
>>
>> Product Information can be found here:
>> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MMA8450Q
>> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MMA8451Q
>>
>> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
>> ---
>>  drivers/hwmon/Kconfig   |   10 +
>>  drivers/hwmon/Makefile  |    1 +
>>  drivers/hwmon/mma845x.c |  568 +++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 579 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/hwmon/mma845x.c
> 
> Nack. Accelerometers don't belong to hwmon. Several such drivers were
> kicked out of drivers/hwmon recently, and we won't accept any such
> driver in the future. Push this to drivers/misc, drivers/input or
> drivers/staging/iio, whichever your prefer, but not drivers/hwmon.
Taking a quick look, you already have a polled input device in here
and it makes no use of hwmon interfaces whatsoever so input is the
obvious target.

Couple of quick things I noticed whilst scan reading...

id table contains only 8451 and 8450, get_mmax845x_name contains
8452 and 8453.

Use the names in the id table to provide you with the names rather than
an additional function.

Take a look at how other drivers handle subtly different parts. There
are much neater ways of doing it than things like get_ctrl_register.

Shift it over to input and I'll do a full review.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
