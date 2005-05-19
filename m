From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: support for SIS 648 - hint for starting
Message-Id: <20021229234710.A4422@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E01B039.C814F80B@info-systems.de>
In-Reply-To: <3E01B039.C814F80B@info-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jakob:

I believe the sis645 module can be made to support your
chipset very easily.  As Alexander suggested, we just need
to see the results of the lspci command in order to add the
support.

* Alexander Malysh <amalysh@web.de> [2002-12-19 14:56:16 +0100]:
> Hi Jakob,
> 
> can you please send lspci -vvv -xxx ?
> We will see , if your chip supported ...
> 
> Am Donnerstag, 19. Dezember 2002 12:40 schrieb Jakob Curdes:
> > Hi,
> >
> > I found that the SiS 648 is not supported yet.
> > Although I have some programming skills, I have no experience with
> > mainboard sensors. What should I read for a start to determine if I can
> > develop a driver for this chip ??

-- 
Mark M. Hoffman
mhoffman@lightlink.com
