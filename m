From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Aug 2011 15:25:50 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm90) Make code more readable
Message-Id: <20110829172550.71b2ab59@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110829134206.14886878@endymion.delvare>
In-Reply-To: <20110829134206.14886878@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 29 Aug 2011 08:11:46 -0700, Guenter Roeck wrote:
> On Mon, 2011-08-29 at 07:42 -0400, Jean Delvare wrote:
> > Clean up the code to make it more readable:
> > * Remove reg_ and new_ prefixes from variable names, they made the
> >   names longer, causing extra line breaks, while not adding much
> >   value.
> > * Introduce struct device dev* = &client->dev in two functions, to
> >   avoid repeating client->dev everywhere in these functions.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Hi Jean,
> 
> Nitpick: You could probably merge several of the multi-line if
> statements into a single line or at least into fewer lines. Not sure if
> you did not do that on purpose, so
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

You are right, and yes this was left as is on purpose. These could have
been merged even before shortening the variable names, but I think it
is easier to validate the checks done for every chip type with one
check per line.

Thanks for the reviews,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
