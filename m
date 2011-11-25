From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 25 Nov 2011 16:57:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: convert drivers/hwmon/* to use
Message-Id: <20111125165708.GA11317@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1322204787.11718.1.camel@phoenix>
In-Reply-To: <1322204787.11718.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Corentin Labbe <corentin.labbe@geomatys.fr>, Dirk Eibach <eibach@gdsys.de>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Steve Glendinning <steve.glendinning@smsc.com>, Riku Voipio <riku.voipio@iki.fi>, Guillaume Ligneul <guillaume.ligneul@gmail.com>, David George <david.george@ska.ac.za>, "Hans J. Koch" <hjk@hansjkoch.de>, Marc Hulsman <m.hulsman@tudelft.nl>, Rudolf Marek <r.marek@assembler.cz>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Nov 25, 2011 at 02:06:27AM -0500, Axel Lin wrote:
> This patch converts the drivers in drivers/hwmon/* to use the
> module_i2c_driver() macro which makes the code smaller and a bit
> simpler.
> 
> Cc: Corentin Labbe <corentin.labbe@geomatys.fr>
> Cc: Dirk Eibach <eibach@gdsys.de>
> Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
> Cc: Steve Glendinning <steve.glendinning@smsc.com>
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Guillaume Ligneul <guillaume.ligneul@gmail.com>
> Cc: David George <david.george@ska.ac.za>
> Cc: "Hans J. Koch" <hjk@hansjkoch.de>
> Cc: Marc Hulsman <m.hulsman@tudelft.nl>
> Cc: Rudolf Marek <r.marek@assembler.cz>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

What is the plan for those patches ? Are they expected to all go through the same tree,
or through individual trees after the necessary defines are introduced into mainline ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
