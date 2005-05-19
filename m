From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <200407150733.i6F7XHAE033337@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10898500251206@kroah.com>
In-Reply-To: <10898500251206@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> Is this right that we don't want to explicitly initialize the adm1031_id
>> counter?
>>
>> Why is that?
>
>Because the compiler/linker does it already for you :)
>
>See the kernel janitor's list for more information about why this is a
>good thing to change.

Hm, then I want to update my i2c client porting guide to mention that?

Thanks,
Jean Delvare
