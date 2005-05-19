From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040220223601.GA17393@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 20, 2004 at 10:37:36PM +0100, Jean Delvare wrote:
> > As we discussed before one problem is that adapter numbers don't match
> > device numbers.
> 
> This is the main problem for sure. I guess (hope) that Greg will take a
> look someday if he has some free time?

Yeah, I'll try to get to that next week...

> > So can we move, link, or create an additional 'name' entry in
> > each directory /sys/class/i2c-dev/i2c-x ??
> 
> This is the kind of question we want to ask to Greg (which supposes you
> CC him ;)).

What would that "name" file hold?

thanks,

greg k-h
