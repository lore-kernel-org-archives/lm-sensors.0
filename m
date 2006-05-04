From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 04 May 2006 18:11:44 +0000
Subject: [lm-sensors] i2c bindings in python?
Message-Id: <20060504181144.GE5121@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605021625.31660.alexander.krause@erazor-zone.de>
In-Reply-To: <200605021625.31660.alexander.krause@erazor-zone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexander:

* Alexander Krause <alexander.krause at erazor-zone.de> [2006-05-04 18:54:25 +0200]:
> > http://members.dca.net/mhoffman/sensors/python/20050122/
> i installed it via `python setup.py install` (it compiled the .c with a lot of 
> warnings) but I'm getting 'undefined symbol: i2c_smbus_access' when using the 
> module.
> 
> I suppose its cos of the linux-2.6 headers.
> 
> Is there a easy way to get it working?
> 
> btw, i'm using python-2.4 but that shouldn't matter.

Yes, yes, and yes.

Get the lm_sensors2 package and do 'make user' and (as root)
'make user_install'.  That will put the proper header file
(for access to i2c-dev devices) in place.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


