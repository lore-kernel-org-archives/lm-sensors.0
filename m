From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [PATCH] i2c/i2c-dev.c::i2c_dev_init() cleanup
Message-Id: <20040709165643.GA32099@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407090741.i697f8El055192@zone3.gcu-squad.org>
In-Reply-To: <200407090741.i697f8El055192@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 09, 2004 at 09:41:08AM +0200, Jean Delvare wrote:
> 
> >> I don't think this ever made it to the list:
> >
> >I got it and applied it to my tree, thanks.
> 
> Is it something that should be ported back to CVS and/or 2.4 kernel tree?

Only if you really want to, it's just a "being paranoid" check :)

thanks,

greg k-h
