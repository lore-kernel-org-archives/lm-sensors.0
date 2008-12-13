From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 13 Dec 2008 22:26:27 +0000
Subject: Re: [lm-sensors] Winbond W83667HG Super IO Sensors
Message-Id: <20081213232627.1bcfbbc5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4943F25E.3080806@gmx.de>
In-Reply-To: <4943F25E.3080806@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Reinhard,

On Sat, 13 Dec 2008 18:35:26 +0100, Reinhard Nissl wrote:
> sensors-detect reports 'to-be-written'. Is someone already
> working on this driver?

Yes, Gong Jun (Cc'd) is working on adding support to the w83627ehf
driver already. He posted a patch [1] which I have reviewed [2] and
updated a bit [3]. It might be a bit difficult to grab from the list
archive so I am making it temporarily available for download at:
http://jdelvare.pck.nerim.net/sensors/hwmon-add-support-for-w83667hg.patch
You are very welcome to test it and report.

At this point I consider the patch usable but it needs some more work
for upstream acceptance (at least in the form of a comment about the
in6 special code, and maybe some related code changes.) I am waiting
for Gong Jun to comment on my review.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-December/024802.html
[2] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-December/024880.html
[3] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-December/024881.html

> I ported the fscher driver in 2003. Maybe I could try to port
> some existing driver for this chip too.

BTW, is this system still in use? We moved support for all FSC chips to
a unified driver (fschmd). If your system still works, you might want
to give it a try and report how it's doing for you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
