From: clepple@ghz.cc (Charles Lepple)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: error: "SMBus collision!"/"sending abort" in 2.6.0test2
Message-Id: <1D98A118-C22E-11D7-BB43-003065DC6B50@ghz.cc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I accidentally started up two copies of a sensord-for-2.6 kludge (just 
cats a bunch of /sys nodes, and jams the results into rrdtool). A 
little while after I started the second copy, I started seeing this in 
my kern.log:

Jul 29 21:19:45 vole kernel: i2c_adapter i2c-0:  SMBus collision!
Jul 29 21:19:46 vole kernel: i2c_adapter i2c-0: : Sending abort.
Jul 29 21:20:17 vole last message repeated 52 times

removing the modules didn't help-- nothing showed up in 
/sys/bus/i2c/devices afterwards.

ideas?

thanks,

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/
