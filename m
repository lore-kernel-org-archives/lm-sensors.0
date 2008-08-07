From: David Brownell <david-b@pacbell.net>
Date: Thu, 07 Aug 2008 21:58:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Drop legacy i2c driver
Message-Id: <200808071458.52213.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080807091432.6a5eab3f@hyperion.delvare>
In-Reply-To: <20080807091432.6a5eab3f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Thursday 07 August 2008, Jean Delvare wrote:
> David, if you haven't already, can you please test this patch and
> confirm it doesn't cause any regression for you? Thanks.

Worked for me.  But I found a bizarre non-I2C problem.

It seems the second element of my i2c_boardinfo array
is getting its "type" field clobbered very early ...
it's correct in the object file, but not when the table
gets handed off to the I2C code.  New behavior.  :(

- Dave




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
