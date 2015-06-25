From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 25 Jun 2015 17:18:35 +0000
Subject: Re: [lm-sensors] [PATCH] fix nct7802_temp_is_visible
Message-Id: <20150625171835.GA5009@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435186051-10196-1-git-send-email-const@MakeLinux.com>
 <558B4486.9070802@roeck-us.net>
 <CAE7jHC95bpZfqDyFOsh-Do3vvrsVDcWVEpSicLx5arzS9c6qKg@mail.gmail.com>
In-Reply-To: <CAE7jHC95bpZfqDyFOsh-Do3vvrsVDcWVEpSicLx5arzS9c6qKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Constantine Shulyupin <const@makelinux.com>
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Constantine,

On Thu, Jun 25, 2015 at 08:10:36PM +0300, Constantine Shulyupin wrote:
> Hi Guenter,
> 

Please don't top-post.

> Excerpt from datasheet:
> 7.2.32 Mode Selection Register
> RTD3_MD : 00=Closed , 01=Reserved , 10=Thermistor mode , 11=Voltage sense
> 
> As I understand the datasheel value 11b is valid too and the resister
> should be visible. It is legit to hide registers on 00=Closed and
> optionally on 01=Reserved (RTD3_MD only).
> 
modeb configures the sensor to voltage mode, and the voltage is then
reported with inX_input. Why do you think it should be reported as
temperature ? How do you propose to translate the reported voltage
to a temperature value ?

> I suppose condition RTD3_MD = 01b can be uncounted because is it reserved
> should not be used. temp3_* registers should be visible when RTD3_MD is 10b
> or 11b and hidden when RTD3_MD = 0 and optionally when RTD3_MD = 1
> 
> Therefore I propose to hide temp3_* when RTD3_MD != 0:
>  if (index >= 18 && index < 27 && !(reg & 0x30)  /* RD3 */
> 
> or when RTD3_MD = 0 or RTD3_MD = 1:
>  if (index >= 18 && index < 27 && (reg & 0x30) <= 0x10)  /* RD3 */
> 
> Do you agree?

No - see above. You don't explain why you want voltages reported as
temperatures, and you don't explain the proposed transition function
from voltages to temperatures, or the rationale for it.

What error are trying to fix, actually ? Do you have a temperature sensor
connectecd to the chip which reports a temperature as voltage and
needs a translation function from voltage to temperature ? Can you
provide a link to the datasheet for that sensor, and details on how it is
connected to the chip ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
