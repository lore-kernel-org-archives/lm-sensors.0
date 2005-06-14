From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 14 Jun 2005 17:17:15 +0000
Subject: [lm-sensors] Do my Xeon's have a temp sensor in them?
Message-Id: <42AEF4B5.9000308@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42ABD95E.1060205@ca-flower.com>
In-Reply-To: <42ABD95E.1060205@ca-flower.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello,

It might happen that the sensor is on another bus, or uses some other chips.
But I think compaq has its own proprietary infrastructure called cpqhealth but I think it is not for 2.6 kernels.
Please ask them for support, or how to access their chips.

You can also try:

modprobe i2c-piix4
modprobe i2c-dev
i2cdetect 0

And send the output to us. It will detect again in "raw" form. But I think there will be nothing.

Regards

Rudolf
