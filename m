From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 29 Mar 2016 20:02:47 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: adc128d818: Support operation mode 1
Message-Id: <20160329200247.GC27318@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1459278219-5573-1-git-send-email-mail@alexanderkoch.net>
In-Reply-To: <1459278219-5573-1-git-send-email-mail@alexanderkoch.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Koch <mail@alexanderkoch.net>
Cc: Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Michael Hornung <mhornung.linux@gmail.com>

On Tue, Mar 29, 2016 at 09:03:37PM +0200, Alexander Koch wrote:
> The ADC128D818 offers four different chip operation modes which vary in the
> number and measurement types of the available input signals (see datasheet
> sec. 8.4.1).
> 
> The current version of the driver only supports the default chip operation mode
> (mode 0), providing seven analog values and a temperature reading.
> 
> This patch series adds support for operation mode 1 (eight analog inputs but no
> temperature), selectable through the device tree attribute 'mode':
> 
>         adc1: adc128d818@1d {
>                 compatible = "ti,adc128d818";
>                 reg = <0x1d>;
>                 mode = /bits/ 8 <1>;
>         };
> 
> The changes are transparent as 'mode' defaults to mode 0 which yields the
> previous behaviour. Code has been tested on real hardware using an evaluation
> board.
> 
> Alexander Koch (2):
>   hwmon: adc128d818: Implement chip mode selection
>   hwmon: adc128d818: Implement operation mode 1
> 
>  drivers/hwmon/adc128d818.c | 113 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 95 insertions(+), 18 deletions(-)
> 

Please send follow-up patches to linux-hwmon@vger.kernel.org.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
