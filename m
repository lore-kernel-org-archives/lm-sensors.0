From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 05 Jul 2014 14:43:45 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adm9240) Avoid forward declaration
Message-Id: <53B80F21.50303@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404395989.4895.12.camel@phoenix>
In-Reply-To: <1404395989.4895.12.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/05/2014 06:39 AM, Guenter Roeck wrote:
>
> Something else though that would help: SMBus block commands.
> Any idea why this is not currently supported ? I see that
> I2C_SMBUS_I2C_BLOCK_DATA is supported, so I2C_SMBUS_BLOCK_DATA
> should not be hard. Am I missing something ?
>
Hi Jean,

I took a stab at that. Guess the main difference to
I2C_SMBUS_I2C_BLOCK_DATA is that it needs a separate buffer
for the SMBus data block; the 'word' buffer can not be used.
Turns out that was quite straightforward to implement.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
