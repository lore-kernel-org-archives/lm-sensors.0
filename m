From: alfred steele <alfred.jaquez@gmail.com>
Date: Wed, 15 Jul 2009 14:22:56 +0000
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire
Message-Id: <528f13590907150722q2a91139bve72d65cbd555b8e9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>
	 <4A5CB908.4060404@cam.ac.uk>
	 <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>
	 <4A5D6C0A.7030903@gmx.de>
In-Reply-To: <4A5D6C0A.7030903-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

Hi Jonathan/Michael,
> I'd say this is just the wrong way round:
> Design goal should be to keep application as is and just load another
> driver on H/W change + changing access path in some config file.
I get that.
I am assuming that in order to get the sht15 driver working on my
platform, all i need to do is populate the correct GPIO's in the
platform device structure. Any idea as to how to do that , i mean
where(which file in the source) does the actual platform device
strucutre's pdata get populated. What would be the optimal method to
tie it to the userspace. Can i add an ioctl to the sht15 driver and
export it for the userspace driver to use.

Appreciate your comments.
Thanks,
Alfred.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
