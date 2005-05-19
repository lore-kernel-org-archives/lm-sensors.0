From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <20030925005439.GD25614@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com>
In-Reply-To: <20030802052904.GA9782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Greg KH <greg@kroah.com> [2003-09-24 11:09:56 -0700]:
> > I did it this way, as ioremap returns a void *.  And it's ok to do
> > math on a void pointer, works the same way as math on a char *.  It
> > got rid of two casts in the driver with this change.

* Jean Delvare <khali@linux-fr.org> [2003-09-24 22:40:49 +0200]:
> Not too sure abour that. Gcc wouldn't have a flag (-Wcast-arith) for
> this without a reason.

Sorry, at my day job I work with compilers that reject that.  Apparently
gcc will reject it too if you specify -pedantic.  Funny how this is ok
in linux but // comments (legal C99) are vigorously removed. ;)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
