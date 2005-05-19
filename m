From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: i2c-sis645 / lm_sensors problems
Message-Id: <20030718113117.GB22673@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jon Still <jon@tertial.org> [2003-07-10 22:23:34 +0100]:
> Hi Mark,
> 
> I got your details from the i2c-sis645 page lm-sensors.nu  
> (http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/busses/i2c- 
> sis645), and I was wondering if you could give me a hand with getting  
> lm_sensors working.  I've made sure that i2c in my kernel (2.4.21) is  
> set to module.  I've installed i2c-2.7.0 (make all, make install) and  
> the same for lm_sensors-2.7.0.  I then try to modprobe i2c-sis645 and I  
> get the following errors:

<snip>

> And finally lspci shows:
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device  
> 0648 (rev 03)

<snip>

Your chipset has been supported in CVS for some time now; it is also
supported by the recent 2.8.0 release.  Let us know if this still
doesn't work.

Also - please use the mailing list for questions.  You might get a 
faster answer e.g. if the developer was on vacation.  ;)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
