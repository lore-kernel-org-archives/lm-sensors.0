From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 12 May 2014 19:55:13 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/emc1403.c: add support for emc14x2
Message-Id: <20140512215513.42076761@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140512123409.GB16252@dashie>
	<20140512161415.GA16770@roeck-us.net>
	<20140512190327.4f65c90a@endymion.delvare>
	<20140512184727.GA9003@roeck-us.net>
In-Reply-To: <20140512184727.GA9003@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Josef Gajdusek <atx@atx.name>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, 12 May 2014 11:47:27 -0700, Guenter Roeck wrote:
> The chips are not only compatible, the even have the same device IDs.
> Maybe I missed it, but I did not find a difference.

The EMC141x seem to have fewer package options (no SOIC) but better
internal sensor accuracy (+/- 1=B0C instead of +/- 2=B0C.) The +/- 1=B0C
accuracy for the external channels is also guaranteed over a wider
temperature range. Just from a quick look at the product features,
there may be more.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
