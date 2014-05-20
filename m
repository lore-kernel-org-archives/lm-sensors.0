From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 20 May 2014 21:20:29 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Introduce the use of the managed version of kzalloc
Message-Id: <20140520232029.2631e56b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140520181536.GA11483@himangi-Dell>
	<20140520200336.GA11723@roeck-us.net>
In-Reply-To: <20140520200336.GA11723@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Himangi Saraogi <himangi774@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr

On Tue, 20 May 2014 13:03:36 -0700, Guenter Roeck wrote:
> On Tue, May 20, 2014 at 11:45:37PM +0530, Himangi Saraogi wrote:
> Applied to -next, just for the sake of it, but frankly that driver
> is screwed up so badly that it is pretty much unusable anyway.
> Almost all of its attributes are non-standard, and for most of them
> that is completely unnecsssary.
> 
> Maybe we should create a to-be-removed list and put it there
> as first candidate.

The traditional way for this is to move the driver to drivers/staging,
mention a deadline in the commit message, and delete it after a few
releases if nobody steps up.

An alternative would be to contact the maintainer (or short of that,
the original contributor) of the driver for an update. Again, with a
deadline.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
