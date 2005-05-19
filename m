From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: it87 enhancements
Message-Id: <3F9C7DFF.28141250@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was thinking of adding pwm support to it87.
Also exporting sensor type to /proc a la w83781d so that you don't need
the temp_type= setting at modprobe time.
Anybody working on this already?
Anybody have a board to test on if I come up with something?
