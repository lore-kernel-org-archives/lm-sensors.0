From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jul 2007 13:28:34 +0000
Subject: Re: [lm-sensors] py-smbus
Message-Id: <20070708132834.GC3584@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1183894739.4690ccd3a0748@webmail.monix.cz>
In-Reply-To: <1183894739.4690ccd3a0748@webmail.monix.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Petr:

* petr@tpc.cz <petr@tpc.cz> [2007-07-08 13:38:59 +0200]:
> Hi,
> trying to install py-smbus but no success. I am sending install log in the
> attachment. Thanks for your comments and suggestions...
> Petr Jakes

Log file says...
> smbusmodule.c:19:20: Python.h: No such file or directory

On RedHat/Fedora systems, this is resolved by installing the python-devel
package.  Whatever is the equivalent for Ubuntu - install it and try again.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
