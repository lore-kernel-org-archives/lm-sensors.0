From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] restore correct vaio handling in eeprom driver
Message-Id: <20040117083153.17edabcb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111205346.6182c330.khali@linux-fr.org>
In-Reply-To: <20040111205346.6182c330.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> One comment: 
> > -	if ((jiffies - data->last_updated > 300 * HZ) |
> > -	    (jiffies < data->last_updated) || !data->valid) {
> > -		dev_dbg(&client->dev, "Starting eeprom update\n");
> > +	if (!(data->valid & (1 << slice)) ||
> > +	    (jiffies - data->last_updated[slice] > 300 * HZ) ||
> > +	    (jiffies < data->last_updated[slice])) {
> 
> We do these jiffies comparisons a lot, is everyone sure they are
> correct?  We should probably be using the proper macros/functions for
> this, right?  I think I looked at this a while ago, and think they
> look correct, but it would be good if someone else can verify this.

Well, what the code is meant to do looks clear to me (do not refresh
more often than every 300 seconds, do not get hosed by jiffies cycling).
So I'd expect it to just work, and BTW it wouldn't be much of a problem
if it did not (OK, it'll refresh more often, shouldn't harm too much).
OTOH, if a macro exists that does this, and maybe handle more corner
cases (not that I can think of any, but who knows), sure we should use
it. Can you point us to it?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
