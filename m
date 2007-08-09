From: "dave jones" <s.dave.jones@gmail.com>
Date: Thu, 09 Aug 2007 08:51:29 +0000
Subject: [lm-sensors] How to define IN_TO_REG and IN_FROM_REG in w83627hf.c
Message-Id: <5628d8010708090151y3f14d2edh783cf86429e01259@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I don't understand why the IN_TO_REG(val) is defined by
(SENSORS_LIMIT((((val) + 8)/16),0,255)) and IN_FROM_REG(val) is
defined by ((val) * 16)

Would you teach me? Thank you.

BR,
Dave.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
