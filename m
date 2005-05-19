From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: LM sensors amd 2.6 kernel...
Message-Id: <20031120064833.GC30286@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <holnzh.oeishy@webmail.batcom-it.net>
In-Reply-To: <holnzh.oeishy@webmail.batcom-it.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* R. Reucher <rene.reucher@batcom-it.net> [2003-11-19 13:57:17 +0100]:

> Not sure, if I can help your group or not... but I'm highly interested in the
> sensors package for Linux 2.6. Well, I'm patient, but how is the status of the
> userland tools f?r 2.6? I'd like to assist you in testing, if you drop me a
> note, where to get the latest releases (if any).

Good timing.  Mark Studebaker just committed some code to CVS.  Look here
at the bottom of the page:

http://secure.netroedge.com/~lm78/download.html

mds: please correct me if I'm wrong here...

Make sure that the appropriate i2c/sensors modules are built into your
2.6 kernel.  Then (while running that kernel) I think you only need to
build the lm_sensors2 userspace by doing 'make user' and 'make user_install'.

> Hardware I'm going to test on: Tyan Thunder K7X with 2 Athlon MPs (2200+).
> 
> SMP kernel: 2.6.0-test9
> 
> Thanks in advance for any info. Let me know, if I can help in any way.

Thanks for testing!

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
