From: Michael Mercier <michael.mercier@inria.fr>
Date: Mon, 19 Jan 2015 09:05:45 +0000
Subject: [lm-sensors] Py-smbus for Python 3
Message-Id: <1421658345.2937.1@smtp.inria.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I am working on a project that use the py-smbus module. The problem is 
I am using python 3.x and the py-smbus library is not compatible with 
this version.

I found a lot of hack to do so, like:
http://www.raspberrypi.org/forums/viewtopic.php?f2&t"348
http://procrastinative.ninja/2014/07/21/smbus-for-python34-on-raspberry/
http://comments.gmane.org/gmane.linux.drivers.i2c/11290
http://www.spinics.net/lists/linux-i2c/msg08427.html

I enventually manage to make it work but this code only wirking with 
python 3.

I like distribute it but I do not know where. Is there someone that can 
merge this upstream properly (with python2 compatibility)
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
