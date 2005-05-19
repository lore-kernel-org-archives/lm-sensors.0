From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: [PATCH] 2.5.21: i2c conversion for drivers/media/video/saa7110.c
Message-Id: <3D13EB35.153C1689@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

did your patch work in testing?
Would you consider writing a porting guide from i2c-old to i2c for
others?

Frank Davis wrote:
> 
> Hello all,
>    Here's what I propose as a complete conversion from the old i2c-old
> interface to the current one (against 2.5.21). I used
> drivers/media/video/saa5249.c as a basis for the conversion, as well as
> reviewing the i2c documentation. Let me know what you think.
> Regards,
> Frank
>
