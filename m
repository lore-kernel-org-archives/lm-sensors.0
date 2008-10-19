From: Thomas <p_thomas@gmx.net>
Date: Sun, 19 Oct 2008 12:48:40 +0000
Subject: [lm-sensors] ATI graphics card temperature -> lm-sensors
Message-Id: <1224420520.19051.5.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

I wonder how difficult it would be to incorporate temperature and
fanspeed of ATI graphics cards into lm-sensors.

There is the aticonfig tool which provides the data (and more, like
clockspeeds, ...):
aticonfig --adapter=0 --od-gettemperature
aticonfig --pplib-cmd "get fanspeed 0"

What would be the best way to do that?
I guess I could do if I knew where to start :)

-Thomas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
