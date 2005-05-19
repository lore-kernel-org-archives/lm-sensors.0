From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Asus a7v266ex // lm_sensors // fan solution
Message-Id: <20030806044300.GB2371@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308040114.06823.info@i-service.de>
In-Reply-To: <200308040114.06823.info@i-service.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-08-05 08:14:21 +0200]:
> 
> > The fan_min and fan_div are related.  Unfortunately, many (most?) of
> > our chip drivers have this problem: when one changes the fan div, the
> > fan min silently changes due to the relation.  When your sensors.conf
> > specifies a change to both fan_min and fan_div, a race is possible
> > that would require you to run `sensors -s` twice to actually get what
> > you want.
> > 
> > I fixed this when I ported lm78.c to 2.5/2.6 - I took the hint from
> > someone else's code (might have been Phil P.)  Haven't had time to
> > propagate that to other drivers though.
> 
> If you can tell me how it can be fixed, I could take some time to modify
> the other drivers.

I just committed changes to lm78.c as an example.

Yes, it has locking issues as do many of the chip drivers when writing
registers.  There was a long, inconclusive thread about that in June:

http://archives.andrew.net.au/lm-sensors/msg02991.html

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
