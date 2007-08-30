From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 30 Aug 2007 09:57:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add power meters to
Message-Id: <20070830115743.4dd8b2d5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com>
	<20070828015029.GA10107@khazad-dum.debian.net>
	<20070828131942.18449886@hyperion.delvare>
	<20070828164440.GL32667@tree.beaverton.ibm.com>
	<20070829111052.503a73a5@hyperion.delvare>
	<20070829145002.GQ32667@tree.beaverton.ibm.com>
In-Reply-To: <20070829145002.GQ32667@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Darrick,

On Wed, 29 Aug 2007 07:50:03 -0700, Darrick J. Wong wrote:
> On Wed, Aug 29, 2007 at 11:10:52AM +0200, Jean Delvare wrote:
> 
> > I'm not sure if we want these "historical" files. We don't have them for
> > the other input types, and I believe that it's not the driver's job to
> > compute and export these values. If anyone cares about the history of
> 
> In the case of ibmpex, it is the _hardware_ that computes the historical
> data; the driver merely exports what it sees.

OK, that's a bit different then, but I'm still not sure that there is
much value in exporting these values in sysfs, in particular if there
is no way to reset them.

I am also not happy with the names you proposed: power1_max_input and
power1_min_input are somewhat confusing IMHO, I'd suggest
power1_input_highest and power1_input_lowest to make them clearly
different from the min and max limits we have for other sensor types.
If we have them at all, of course.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
