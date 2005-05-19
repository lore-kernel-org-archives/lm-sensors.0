From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [PATCH 2.6] I2C: New hardware monitor driver: adm9240 (2nd try)
Message-Id: <nn5171525mm4ligefva05n6uhoefe5pcab@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
In-Reply-To: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,

On Thu, 28 Apr 2005 09:29:54 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>
>Hi Grant,
>
>> +		for (i = 1; i < 6; i++) {
>> +			adm9240_write_value(client,
>> +					ADM9240_REG_IN_MIN(i), 0);
>> +			adm9240_write_value(client,
>> +					ADM9240_REG_IN_MAX(i), 255);
>> +		}
>
>Shouldn't i start from 0 here?
Yep, missed that :)

>> +		/* start measurement cycle */
>> +		adm9240_write_value(client, ADM9240_REG_CONFIG, 1);
>
>I'm sorry but I'm still not quite happy with this. You want to change
>one bit and end up writing 8. What about something along the lines of:
>
>	reg = adm9240_read_value(client, ADM9240_REG_CONFIG);
>	adm9240_write_value(client, ADM9240_REG_CONFIG,
>		(reg | 0x01) & 0x7f);

That would fail to start the measurement cycle and leave user-space 
able to assert a hardware interrupt signal, plus it writes zero to 
bit 7 for what reason?

Thanks,
--Grant.
