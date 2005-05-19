From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] restore correct vaio handling in eeprom driver
Message-Id: <20040116221421.GE3028@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111205346.6182c330.khali@linux-fr.org>
In-Reply-To: <20040111205346.6182c330.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 16, 2004 at 07:52:55PM +0100, Jean Delvare wrote:
> > Depends on what the patch looks like.  Care to make it up to see if
> > it's not too ugly?
> 
> Here you go. Comments at the bottom.

Ok, very persuasive argument, I've applied this :)

One comment: 
> -	if ((jiffies - data->last_updated > 300 * HZ) |
> -	    (jiffies < data->last_updated) || !data->valid) {
> -		dev_dbg(&client->dev, "Starting eeprom update\n");
> +	if (!(data->valid & (1 << slice)) ||
> +	    (jiffies - data->last_updated[slice] > 300 * HZ) ||
> +	    (jiffies < data->last_updated[slice])) {

We do these jiffies comparisons a lot, is everyone sure they are
correct?  We should probably be using the proper macros/functions for
this, right?  I think I looked at this a while ago, and think they look
correct, but it would be good if someone else can verify this.

thanks,

greg k-h
