From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 09 Jun 2005 09:58:10 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <25381867050609005745c36255@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It does, over time.  I can see the sensor files moving to be class
> attributes instead of device attributes.  But we need to do that so we
> don't break all of the userspace code at the same time :)

Yes, fair enough :). That's basically the point Mark made too, and I
can understand, the userspace interface hasn't exactly been stable for
lm-sensors 2.6. I really like the hwmon direction overall though, and
hopefully the ipmi sensors driver will be an ideal example of what the
hwmon patch is all about. I keep encountering little hurdles to jump
over though on the way..

Thanks,
Yani
