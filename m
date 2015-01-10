From: Patrik Dufresne <ikus060@gmail.com>
Date: Sat, 10 Jan 2015 02:47:18 +0000
Subject: [lm-sensors] X10SLM-F with SMBus
Message-Id: <CAJ=kj5z6mGzSjvTKoWvCM2DT73hipFfaEM-5sKWr+2f+yBAmqA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="089e0149d2dcac1f69050c434adb"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--089e0149d2dcac1f69050c434adb
Content-Type: text/plain; charset=UTF-8

Hello,

I'm not particularly familiar with lm-sensors or i2c-tools. I'm trying to
hack it so my sensors on motherboard "X10SLM-F" is working. It has a SMBus
but sensors-detect doesn't find anything on it. According to the
documentation, it should be attached to the PSU. I've played a bit with the
i2c-tools without a clue to interpret it.

As recommanded, see attachment for sensors-detect, sensors, lspci -nn,
lsmod, i2cdetect and dmesg.

I'm also wondering how to get IPMI working.

--
Patrik Dufresne

--089e0149d2dcac1f69050c434adb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--089e0149d2dcac1f69050c434adb--
