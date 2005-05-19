From: jchapman@katalix.com (James Chapman)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH: 2.6.11-rc5] i2c chips: ds1337 RTC driver
Message-Id: <42274D78.8020608@katalix.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42235171.80500@katalix.com>
In-Reply-To: <42235171.80500@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I just posted a revised version. I forgot to include i2c-ids.h in
my original patch. The new patch should also fix the reference to
client->id.

/james

Andrew Morton wrote:

> James Chapman <jchapman@katalix.com> wrote:
> 
>>Add DS1337 RTC chip driver.
>>
> 
> 
> drivers/i2c/chips/ds1337.c:60: `I2C_DRIVERID_DS1337' undeclared here (not in a function)
> 
> 
> Also, there are changes in Greg's i2c tree which break your new driver:
> 
> drivers/i2c/chips/ds1337.c:60: initializer element is not constant
> drivers/i2c/chips/ds1337.c:60: (near initialization for `ds1337_driver.id')
> drivers/i2c/chips/ds1337.c: In function `ds1337_get_datetime':
> drivers/i2c/chips/ds1337.c:155: structure has no member named `id'
> drivers/i2c/chips/ds1337.c: In function `ds1337_set_datetime':
> drivers/i2c/chips/ds1337.c:206: structure has no member named `id'
> drivers/i2c/chips/ds1337.c: In function `ds1337_detect':
> drivers/i2c/chips/ds1337.c:333: structure has no member named `id'
> drivers/i2c/chips/ds1337.c:343: structure has no member named `id'
> 
> 
> 
> 


-- 
James Chapman
E-mail  : jchapman@katalix.com
PGP key : http://www.katalix.com/~jchapman/pgpkey.txt
