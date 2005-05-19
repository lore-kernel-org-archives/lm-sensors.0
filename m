From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: sis5595
Message-Id: <20030718121158.GD22673@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Nicolas <linux@1g6.biz> [2003-07-16 16:04:39 +0200]:
> 
> kernel 2.4 doesn't work on my computer 
> (no networking because sis648/sis900),
                         ^^^^^^^^^^^^^

1. As Jean guessed, you don't have a sis5595.  Your port of that module,
even if it loads, is not what you want.

2. The workaround for kernel 2.4 is to load the i2c-sis645 module
*before* you load the sis900 module.

3. In kernel >= 2.5.7x (where x means I can't remember) you want to load
i2c-sis96x instead - sorry for the confusion, but that name is more
accurate.

So I might recommend to you...

Try kernel 2.4 again with I2C and sensors 2.8.0 release so that you can
see what sensors chip you have.  I assure you, it's not sis5595.  Then
see if that chip is supported by kernel 2.6... maybe so, or maybe you'll
want to port that one.

<snip>

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
