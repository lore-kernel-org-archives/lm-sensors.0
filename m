From: James Cloos <cloos@jhcloos.com>
Date: Tue, 25 Oct 2011 22:12:03 +0000
Subject: Re: [lm-sensors] fan change between 3.1.0-rc6 and commit b172e38
Message-Id: <m3fwig201g.fsf@jhcloos.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <m339flbipr.fsf@jhcloos.com>
In-Reply-To: <m339flbipr.fsf@jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

D'Oh.  I had forgotten that I had upgraded the board's firmware (which
flashrom(8) makes supremely easy).  It turns out that the manuf defaults
the fan control to max rather than dynamic.

Apologies for the noise.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
