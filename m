From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: no cpu temp or fan readouts.
Message-Id: <20030522020454.GB23674@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1053558627.814.23.camel@localhost.localdomain>
In-Reply-To: <1053558627.814.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(oops, forgot to CC the list on my original reply)

* Matthew Ives <M.Ives@zzzzx.plus.com> [2003-05-22 00:10:27 +0100]:

> First of all, my hardware is quite standard stuff:
> Abit Kr7a mainboard
> Athlon xp 2100 cpu
> 512 mb pc2100 ram.

If this diagram is true, you have a Winbond W83697HF:

http://www.sharkyextreme.com/img/2002/04/abit_kr7a/mb_diagram.jpg

That sensors chip is supported by the w83781d module.  Sensors-detect
should have found it.  But, I think your chip is "ISA only".  Are
you sure you said "yes" to the ISA probing?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
