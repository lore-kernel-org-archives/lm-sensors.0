From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [PATCH 2.6] I2C: New hardware monitor driver: adm9240
Message-Id: <57c07198c3pb47djhgqr5q4vpjmb0gnuin@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
In-Reply-To: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali, Greg,
On Wed, 27 Apr 2005 16:42:22 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>is not part of our sysfs standard. "chassis_clear" maybe?
done

>I think you have been a bit agressive in your includes removal. Please at
>least include linux/init.h, linux/module.h and linux/slab.h. The driver
>needs them.
back in

>> +static unsigned short normal_i2c[] = { 0x2c,0x2d,0x2e,0x2f,
>> I2C_CLIENT_END };
>
>Space after the commas please. There are a couple other places in the
>code where they are missing, please add them where needed.
done

>> +		adm9240_write_value(client, ADM9240_REG_TEMP_CONF, 0);
removed, leave adm9240 in power-up one-shot interrupt mode, as 
alarm status remains asserted over multiple reads and driver 
does not enable interrupt pin output.

>> +		adm9240_write_value(client, ADM9240_REG_CONFIG, 1);
this one starts measurement cycle, added a comment to that effect
>
>Otherwise I am fine with your code.
Thank you.  New patch soonish.

--Grant.
