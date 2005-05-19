From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Xeon II motherboard and CPU temp readings
Message-Id: <20040618213916.GB2661@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSU.4.58.0406181602240.12794@adore.lightlink.com>
In-Reply-To: <Pine.GSU.4.58.0406181602240.12794@adore.lightlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again:

* Rudolf Marek <R.Marek@sh.cvut.cz> [2004-06-18 23:03:48 +0200]:
> Before that you can try to solve CPU temp problems.
> 
> > modprobe adm1021

That may or may not work, as the built-in Xeon temp sensors look
like adm1021.

http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/doc/chips/xeontemp

I still think Homer will want to move to the latest release, 2.8.7.
(which also gets him improved support for the other chip, w83627hf)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
