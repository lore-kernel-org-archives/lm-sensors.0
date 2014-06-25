From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 25 Jun 2014 05:49:31 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (w83l786ng) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140625074931.10342140@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403609228.348.1.camel@phoenix>
In-Reply-To: <1403609228.348.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 24 Jun 2014 07:38:46 -0700, Guenter Roeck wrote:
> The driver could also benefit from some cleanup. It wastes code space by using
> function macros instead of SENSOR_ATTR_2, and functions should be reordered
> to get rid of forward declarations. Difficult to do without HW or at least
> simulation, though. Jean, do you have a register dump, by any chance ?

I have the following:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
20: c0 c1 c2 XX XX 25 26 XX 88 89 XX ff 00 ff 00 ff
30: 00 XX XX XX XX 50 4b 50 4b XX XX ff ff f0 f0 XX
40: 01 00 00 de fe 00 00 00 XX 00 00 00 a3 5c 80 XX
50: XX 00 04 41 11 XX XX XX XX XX XX XX XX XX XX XX
80: 3c ff ff 00 00 00 00 ff ff 00 00 00 00 33 XX 22
90: 00 14 0a 00 00 00 19 19 XX XX XX XX XX XX XX XX

It was stored under the name w83l786ng-powerup.dump, so it is likely
that I generated it based on the default register values in the
datasheet and this isn't an real chip dump. Hope that helps anyway.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
