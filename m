From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 08 Dec 2013 20:32:15 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon/adt7411: Add devicetree bindings
Message-Id: <52A4D74F.7010701@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1386532718-13586-1-git-send-email-bgamari.foss@gmail.com> <1386532718-13586-2-git-send-email-bgamari.foss@gmail.com>
In-Reply-To: <1386532718-13586-2-git-send-email-bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On 12/08/2013 11:58 AM, Ben Gamari wrote:
> There isn't reallly any configuration necessary so the bindings are
> consequently quite simple.
>
> Signed-off-by: Ben Gamari <bgamari.foss@gmail.com>
> ---

i2c devices don't require explicit bindings unless driver specific bindings are needed.
Please see Documentation/devicetree/bindings/i2c/trivial-devices.txt for details.
You might want to consider adding the device into the trivial-devices.txt file instead.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
