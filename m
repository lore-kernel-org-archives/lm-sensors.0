From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: system hang
Message-Id: <20030903041044.GA26379@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030903034244.73f27e9f.miguel.vagos@mail.telepac.pt>
In-Reply-To: <20030903034244.73f27e9f.miguel.vagos@mail.telepac.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Miguel <miguel.vagos@mail.telepac.pt> [2003-09-03 03:42:44 +0000]:
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticketi7
> 
> Does this still occur with version 2.8.0 (i2c and lm_sensors) or has the module been modified already ?

Er, that ticket is almost 2 years old; it mentions version 2.6.1.
By "the module" you mean w83781d right?  That has been modified
many, many times in the last 2 years.  The parameter mentioned in
the ticket is "init=0".  Probably you won't find out if it works
until you try it and see...

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
