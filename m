From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 02 May 2006 16:50:11 +0000
Subject: [lm-sensors] i2c bindings in python?
Message-Id: <20060502165011.GA2646@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605021625.31660.alexander.krause@erazor-zone.de>
In-Reply-To: <200605021625.31660.alexander.krause@erazor-zone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexander:

* Alexander Krause <alexander.krause at erazor-zone.de> [2006-05-02 16:25:31 +0200]:
> just wanna ask if there is some kind of library for python to handle 
> i2c-transfers (via usermode like i2cset and i2cget does).

Yes, almost.  This one doesn't do arbitrary I2C transfers, just the SMBus subset.
However, that would be enough to implement i2cset and i2cget in python.  Here is
the latest revision; sorry for the lack of documentation.

http://members.dca.net/mhoffman/sensors/python/20050122/

> I couldn't find any using google.

?!?!

Search "i2c python bindings" and the first two links will lead you to it.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


