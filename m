From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <20030803035047.GB5202@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark M. Hoffman <mhoffman@lightlink.com> [2003-08-02 23:31:55 -0400]:
> 
> This just tells your system to update its list of where to find
> shared libraries.  There will be notes about this at the end of
> the second "make install" - read them and you should be all set.

Oops, I lied.  The notes are actually in lm_sensors2/INSTALL...

> If `sensors' returns some error message about not being able to load
> libsensors, you have to add the directory in which it is installed
> (by default /usr/local/lib) to /etc/ld.so.conf and run `ldconfig'.

Dunno why I thought that was added to the "make install" notes - sorry.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
