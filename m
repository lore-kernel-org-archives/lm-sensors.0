From: Clemens Ladisch <clemens@ladisch.de>
Date: Tue, 26 Oct 2010 14:52:15 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <4CC6EB1F.5030609@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Tue, 26 Oct 2010 15:53:29 +0200, Clemens Ladisch wrote:
> > And on the newest CPUs, Intel has switched to one temperature sensor per
> > package.
> 
> Really? Starting with which CPU model?

Sandy Bridge (pkgtemp driver).

> > I'll look into the datasheet to see if this situation (two northbridges
> > per CPU) is documented and can be detected so that the driver can ignore
> > these superfluous sensors.
> 
> If these sensors exist, I see no valid reason to ignore them.

It might be possible that these are just two ways to read the same
sensor, i.e., that two sensors per CPU do not actually exist.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
