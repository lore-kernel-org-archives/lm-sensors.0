From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: ASB100 PWM
Message-Id: <20031115062211.GE10074@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031111062929.GA30118@earth.solarsys.private>
In-Reply-To: <20031111062929.GA30118@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Vitaly V. Bursov <vitalyb@mail333.com> [2003-11-11 14:48:52 +0200]:

> $ echo $[ 0x80 ] 1 > pwm1
> It works for me! Thanks!

OK great!  It's committed.

> I have an Asus A7V8X mobo rev 1.04, ASB100 chip marking follows
> 
> ASB100-A    Bach
> TPV268981   0240E
> 
> i2cdump`s output for banks 0-4 is attached.
> 
> And I checked a photo in the manual. It is a mobo rev 1.02
> ASB100 marking:
> 
> ASB100-A    Bach
> TKF100471AE 0227
> 
> Looks differently...

Indeed, mine says this:

ASB100      Bach
TSR393731AD 0148

I'm therefore assuming that ASB100-A supports pwm1, while
plain ASB100 does not.  Looking through your attached
chip dump (quickly, I'll admit) I don't see a way to
distinguish the two.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
