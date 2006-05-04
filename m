From: alexander.krause@erazor-zone.de (Alexander Krause)
Date: Thu, 04 May 2006 16:54:25 +0000
Subject: [lm-sensors] i2c bindings in python?
Message-Id: <200605041854.26472.alexander.krause@erazor-zone.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605021625.31660.alexander.krause@erazor-zone.de>
In-Reply-To: <200605021625.31660.alexander.krause@erazor-zone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> http://members.dca.net/mhoffman/sensors/python/20050122/
i installed it via `python setup.py install` (it compiled the .c with a lot of 
warnings) but I'm getting 'undefined symbol: i2c_smbus_access' when using the 
module.

I suppose its cos of the linux-2.6 headers.

Is there a easy way to get it working?

btw, i'm using python-2.4 but that shouldn't matter.

cheers Alex
-- 
Alexander Krause
Amtmann-K?stner-Platz 11
99091 Erfurt, Germany

Mail alexander.krause at erazor-zone.de
Tel. +49 (179) 4725826

