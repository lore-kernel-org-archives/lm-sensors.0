From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 09 Oct 2007 20:40:37 +0000
Subject: Re: [lm-sensors] [PATCH v4] IBM power meter driver
Message-Id: <20071009204037.GF16003@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare> <20070828164905.GM32667@tree.beaverton.ibm.com> <20070828232504.GP32667@tree.beaverton.ibm.com> <20070911132335.GJ31992@jupiter.solarsys.private> <20070914193346.GM30825@tree.beaverton.ibm.com> <20071009120044.GP3835@jupiter.solarsys.private> <470BAFD7.10305@tiscali.nl>
In-Reply-To: <470BAFD7.10305@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roel Kluin <12o3l@tiscali.nl>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Jean Delvare <khali@linux-fr.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, haveblue@us.ibm.com

On Tue, Oct 09, 2007 at 06:44:07PM +0200, Roel Kluin wrote:

> >> +	if (IS_ERR(data->hwmon_dev)) {
> >> +		printk(KERN_ERR DRVNAME ": Error, unable to register hwmon "
> >> +		       "class device for interface %d\n",
> >> +		       data->interface);
> >> +		kfree(data);
> >> +		return;
> 
> don't you want to goto out_user here instead?

Err, yes, thank you for catching that.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
