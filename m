From: me@andrew.net.au (Andrew Pollock)
Date: Fri, 21 Apr 2006 05:01:24 +0000
Subject: [lm-sensors] Dell Latitude D610 and 2.6.16
Message-Id: <20060421050124.GY14481@daedalus.andrew.net.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey,

I just thought I'd try out lm-sensors on my Dell D610 with what's in 2.6.16,
and sensors-detect decided that i2c-i801 and eeprom should be loaded, but
the sensors command fails, and there's nothing in /sys/class/hwmon (where I
presume from stracing sensors there is supposed to be something).

Should this work with this hardware?

regards

Andrew

