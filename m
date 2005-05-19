From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: lm_sensors on kernel 2.6.6
Message-Id: <Pine.LNX.4.58.0405301812590.1458@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040530155539.5BF6218FD9B@mail.writecode.org>
In-Reply-To: <20040530155539.5BF6218FD9B@mail.writecode.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

> This is one example of many. while on my machine the file:
> /sys/bus/i2c/devices/0-002d/in6_input exists

Yes you have wrong version of userspace utilities. Please
use latest CVS version.

http://secure.netroedge.com/~lm78/archive/lm_sensors-daily.tar.gz

Don't forget to wipe out all libraries in /usr/lib/libsens*
and /usr/local/lib/libsens*

After install check if your /etc/ld.so.conf if it has
/usr/local/lib entry. If not add it. Then run ldconfig

I hope this helps. You can ask at IRC Freenode network #linux-sensors
If any futher questions. (Or via this email)

Regards

Rudolf
