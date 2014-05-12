From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 13:11:45 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/emc1403.c: add new revision numbers to emc1403_detect()
Message-Id: <5370C891.3070502@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140512114826.GA16252@dashie>
In-Reply-To: <20140512114826.GA16252@dashie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Josef Gajdusek <atx@atx.name>, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 05/12/2014 04:48 AM, Josef Gajdusek wrote:
> Adds new chip revision numbers to emc1403.c. Altough the datasheet (for emc1412) does not say so directly, it seems to suggest, that chips with revision ID 0x03 exist.
>

In Table 10.1:

Rev. 1.37 (12-23-09) Section 7.17, "Revision Register"

Changed default from 01h to 03h to match the actual value.

Rev. 1.38 changed it to 0x04.

> Signed-off-by: Josef Gajdusek <atx@atx.name>

Thanks, will apply.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
