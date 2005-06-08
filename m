From: medaglia@gmail.com (Cadu)
Date: Wed, 08 Jun 2005 14:14:02 +0000
Subject: [lm-sensors] w83627ehf driver development
Message-Id: <797de5c30506080513d85ee5e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Sorry for my delay... In the last weeks I was very busy, but I've
worked in the driver on free time, and I have some questions:

1) Should the chip driver calculate the real voltage values or just
put the values read from the device in the data struct?

2) How can I add the voltage values in the lm_sensors w83627ehf lib?
I've looked at the code, but it has some defines with some numbers
that I can't see any logic. What do those numbers mean?

Thank you so much!
Cadu
