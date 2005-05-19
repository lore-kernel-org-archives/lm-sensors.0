From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: driver initialization of chips
Message-Id: <20031115045649.GB10074@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB5ADC8.A055A6E5@paradyne.com>
In-Reply-To: <3FB5ADC8.A055A6E5@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark D. Studebaker <mds@paradyne.com> [2003-11-14 23:38:32 -0500]:
> I'd like to modify all the drivers to not initialize the chips unless
> there's an init=1 argument (i.e. init=0 is the default).
> I know there's been some who favor this change...
> comments?

I'd just as soon rip the init code out altogether.  It just reproduces
the functionality of 'sensors -s', and that in an unconfigurable way.

The ASB100 driver has bare minimum init code - i.e. read the vid,
and turn on monitoring - period.  Sheesh, I don't know why I even
read the vid there... 

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
