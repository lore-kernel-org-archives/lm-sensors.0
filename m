From: Jonathan Cameron <jic23@kernel.org>
Date: Thu, 21 Mar 2013 07:16:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Move the IIO client driver for hwmon out of staging
Message-Id: <514AB3E1.8070107@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1363818079-31470-1-git-send-email-jic23@kernel.org> <20130320234405.GA29172@roeck-us.net>
In-Reply-To: <20130320234405.GA29172@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-iio@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org

On 03/20/2013 11:44 PM, Guenter Roeck wrote:
> On Wed, Mar 20, 2013 at 10:21:19PM +0000, Jonathan Cameron wrote:
>> This driver uses channel maps, defined either through device tree
>> or platform data, to create a hwmon driver which acts as a client
>> for the underlying IIO device channels.  Thus a general purpose
>> IIO adc driver can be used to provide hardware monitoring using a subset
>> of its channels.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> cc: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
>>
>> --
>>  The only non move changes here concern the description and changes to the
>>  dependencies to IIO explicit and hwmon implicit.
>>
>>  I'm proposing moving this into hwmon on the basis of placing drivers
>>  based on what they provide rather than what their underlying hardware
>>  is.
>>
> That is what I would suggest as well.
> 
> I assume you will take this through the iio tree, as it depends
> on my previous patch, correct ?
Yes.   All moves from staging like this one (rather than rewrites) go through
GregKH's staging tree anyway so routing through IIO (which he pulls into there)
is definitely the way to go.

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
