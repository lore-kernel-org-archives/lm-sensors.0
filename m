From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: as99127f pwm registers
Message-Id: <20030723041758.GC24426@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722093411.25d749c5.khali@linux-fr.org>
In-Reply-To: <20030722093411.25d749c5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-07-22 09:34:11 +0200]:
> 
> The register we are fighting with this time is 0x5B. In our current
> driver implementation, this register is supposed to be PWM1 (fan speed
> control) as for the w83781d, but I did some tests on my motherboard
> (Asus A7V133-C, AS99127F) yesterday and it turned out that this register
> behaves like a temperature sensor mode selector (like the it87 has).
> What's your opinion about this register? Where would PWM1 be if it's not
> there?

Remember this guy?

http://archives.andrew.net.au/lm-sensors/msg02580.html

The zipped sensors.conf file attached to that message says that 0x5b is
a temp. mode selector.  That this is true for Asus BACH is further
evidence that the same is probably true for as99127f.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
