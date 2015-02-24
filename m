From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 24 Feb 2015 11:59:31 +0000
Subject: Re: [lm-sensors] IT8620E working with it87 driver
Message-Id: <20150224125931.3f0baac3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMqk1ZyC2w7JnJ7xyDPwCvXkHQjwkPmG_LhyC8_doavpeXHXyA@mail.gmail.com>
In-Reply-To: <CAMqk1ZyC2w7JnJ7xyDPwCvXkHQjwkPmG_LhyC8_doavpeXHXyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tony,

Sorry for the late reply.

On Wed, 7 May 2014 17:02:06 +1000, Tony wrote:
> Thank you for you suggestion have tried loading the mod and got error no
> file have download it87 driver for the web site and did make, make
> install and rebooted and did sensors-detect and got the same as before
> can someone tell me what i am doing wrong (I have use LM Sensor on HP
> and Dell Servers and for the most part it just worked)

Sensors-detect is independent from the drivers installed on your
system, its output won't change just because you installed a newer
version of the it87 driver. If you need an updated version of
sensors-detect you can get it here:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
However in your case it seems unnecessary as you already know that you
need the it87 driver.

If you have installed a new it87 driver then "modprobe it87" as root
should load it. However please remember that the driver still does not
support the IT8620E part, so you must pass parameter force_id=0x8728
when loading the driver.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
