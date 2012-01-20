From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 20 Jan 2012 09:57:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: convert drivers/hwmon/* to use module_i2c_driver()
Message-Id: <20120120095721.GA31838@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327045098.29773.0.camel@phoenix>
In-Reply-To: <1327045098.29773.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, Corentin Labbe <corentin.labbe@geomatys.fr>, Dirk Eibach <eibach@gdsys.de>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Steve Glendinning <steve.glendinning@smsc.com>, Riku Voipio <riku.voipio@iki.fi>, Guillaume Ligneul <guillaume.ligneul@gmail.com>, David George <david.george@ska.ac.za>, "Hans J. Koch" <hjk@hansjkoch.de>, Marc Hulsman <m.hulsman@tudelft.nl>, Rudolf Marek <r.marek@assembler.cz>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Jan 20, 2012 at 02:38:18AM -0500, Axel Lin wrote:
> This patch converts the drivers in drivers/hwmon/* to use the
> module_i2c_driver() macro which makes the code smaller and a bit simpler.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
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
> ---

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
