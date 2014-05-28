From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 28 May 2014 07:41:11 +0000
Subject: Re: [lm-sensors] [PATCH v2] powerpc/powernv: hwmon driver for power values, fan rpm and temperature
Message-Id: <1401262871.8262.22.camel@pasglop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140519141931.9248.11356.stgit@neelegup-tp-t420.in.ibm.com>
 <53858F02.2020808@roeck-us.net>
In-Reply-To: <53858F02.2020808@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, sbhat@linux.vnet.ibm.com, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, jdelvare@suse.de

On Wed, 2014-05-28 at 00:23 -0700, Guenter Roeck wrote:
> Consider using of_property_read_u32().
> 
> > +             sdata[count].id = *sensor_id;
> > +             sdata[count].type = type;

Especially since this is broken for Little Endian !

Neelesh, please make sure you test your patch on LE.

Cheers,
Ben.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
