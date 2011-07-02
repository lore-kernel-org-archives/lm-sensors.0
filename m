From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 02 Jul 2011 21:14:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Don't leak info in adm1275_probe
Message-Id: <20110702211451.GA11378@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LNX.2.00.1107022202520.16316@swampdragon.chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1107022202520.16316@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesper Juhl <jj@chaosbits.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>

On Sat, Jul 02, 2011 at 04:04:29PM -0400, Jesper Juhl wrote:
> In drivers/hwmon/adm1275.c:adm1275_probe() we'll leak the memory
> allocated to 'info' if the call to i2c_smbus_read_byte_data() returns
> less than zero.
> 
> This patch fixes the leak by simply calling kfree(info) when needed.
> I also considered just moving the 'info' memory allocation below the
> call to i2c_smbus_read_byte_data(), but I was not sure if it mattered
> to get the -ENOMEM first in that case or if it would be bad to first
> have a successful i2c_smbus_read_byte_data() call and then fail the
> mem alloc, so I stuck with the safe option.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Hi Jesper,

the fix for this problem is already enqueued as 
"hwmon: (adm1275) Free allocated memory if probe function fails".

There is also a second error condition, which occurs if pmbus_do_probe() 
returns an error.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
