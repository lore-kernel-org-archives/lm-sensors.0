From: Wayne Tams <wayne.tams@gmail.com>
Date: Fri, 16 Dec 2011 15:33:37 +0000
Subject: [lm-sensors] i2cdetect running slow but not "bus inactive" slow,
Message-Id: <CAN=k24=RXfkyzdLqF2=xSU6nHT28YGwFFu9TDfJihn7wg8tsLQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i2cdetect is behaving in a fashion that I have not seen before and I
just would like to know if anyone has a suggestion on what it is
telling me.

Normally i2cdetect returns in <1s, if the bus were inactive it would
take closer to 20s. However I'm finding that the scanning is taken a
round 5s and the addresses returned appear random, except for one.
Obviously there must be a fault in my hardware, but I just wanted to
make sure that was/wasn't a common explanation for this behaviour
before I go debugging up the wrong tree.

Thanks

Wayne

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
