From: jjDaNiMoTh <jjdanimoth@gmail.com>
Date: Thu, 28 May 2009 20:03:38 +0000
Subject: Re: [lm-sensors] [PATCH] adt746x compatibile with lm_sensors
Message-Id: <7b71803f0905281303s780bdcd6o81e45cf512c1b6e4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <7b71803f0904090550i37f489d0hb37cc777c844671f@mail.gmail.com>
In-Reply-To: <7b71803f0904090550i37f489d0hb37cc777c844671f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2009/4/9 DaNiMoTh <jjdanimoth@gmail.com>:
> Hello to all,
>
> After the first attempt to make a better driver for adt746x, I follow
> what Jean said to me.
> So, there is a patch for the actual adt746x driver that move the sysfs
> attributes from /sys/devices/temperature to /sys/class/hwmon/ and also
> it renames the old attributes (ex. from sensor1_temperature to
> temp1_input).
>
> As result, now I'm able to see two temperatures and two fan speed from
> lm_sensors.
>

Hello, any news for this ?

There are something that I do wrong ?

Many thanks :)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
