From: bezaur@gmail.com (Charles Spirakis)
Date: Wed, 11 Oct 2006 02:04:10 +0000
Subject: [lm-sensors] 2.6 kernel and ipmi bmc?
Message-Id: <5bfe43f80610101904y7d7a9e52g58fe5e302ca245c6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All --

I now have a board which is known to have the Renesas H8S/2168 sensor
controller on ipmi. I saw older drivers for the 2.4 kernel (a "fake"
driver for i2c-ipmi and a bmcsensors.c) but I don't see anything in
the 2.6 kernel. I tried searching for ipmi and bmc on the lm-sensors
website and the closest I came was:
http://www.lm-sensors.org/ticket/1937.

Has anyone gotten sensors sitting in ipmi land working on the 2.6
kernel using lm-sensors tools?

I am aware of the impiutil and ipmitool and have that working, but I
was hoping to use the somewhat standardized lm-sensors methodology for
all the boards I deal with...

-- charles

