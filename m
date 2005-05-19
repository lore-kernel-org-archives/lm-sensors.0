From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC PATCH libsensors: change vid for adm1025, adm1026 and adm9240
Message-Id: <8pDd2qe9.1115803808.5910250.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bd381pbap6v9k0l51b80728rplvfvhvqk@4ax.com>
In-Reply-To: <7bd381pbap6v9k0l51b80728rplvfvhvqk@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Thankyou, but I noticed RW and changed it to R in adm1026

True, nice catch.

> > This one is not needed, as it will be properly handled by a "constant
> > mapping" in proc.c.
>
> Is that the same for adm9240?  I tried to follow same style.

Yes it is, I hadn't noticed.

>     { SENSORS_ADM9240_VID, "vid", NOMAP, NOMAP,
>-                  R, ADM9240_SYSCTL_VID, VALUE(1), 2, "in1_ref", 3 },
>+                  R, ADM9240_SYSCTL_VID, VALUE(1), 3 },

You're changing the magnitude for the 2.4 driver here! This is no good.

Thanks,
--
Jean Delvare
