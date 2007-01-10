From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 10 Jan 2007 09:49:51 +0000
Subject: [lm-sensors] sensors.conf for supermicro x7dbe+
Message-Id: <20070110104951.0c43b9e0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701031701.08165.nromer@arcmailtech.com>
In-Reply-To: <200701031701.08165.nromer@arcmailtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gong,

On Wed, 10 Jan 2007 16:59:05 +0800, JGong at winbond.com wrote:
> 
> Hi, Noah 
> >> En, you can try this one to see the temp6 mode:
> >> 
> >> cat /sys/bus/i2c/drivers/w83793/0-002f/temp6_type
> 
> >'0'
> 
> Ok, that is to say, the temp6 channel is disabled, and you can ignore
> the temp6 readings by adding one line "ignore temp6" into your
> sensors.conf.
> 
> By now, I am sorry that the w83793 driver has done nothing with the
> disabled temperature channel situation. :(

I agree, it's not handled properly; let's make it better. I see 3
possibilities:

1* We display the sensor type in "sensors". This is what we do for the
IT87xxF devices. When the sensor type is "disabled", the user should
realize that the reading is meaningless.

2* We change sensors to not even display tempN if that sensor is
disabled. This is probably even more user-friendly.

3* We change the w83793 driver to not present the temperature value
when the sensor is disabled. A bit more difficult, but doable. There's
something of this kind done in the f71805f hardware monitoring driver.

A combination of 2 and 3 sounds best to me. Gong, what do you think?
Can you please propose patches?

Thanks,
-- 
Jean Delvare

