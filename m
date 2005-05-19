From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: i2c adapters class
Message-Id: <20040312212631.GB1860@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040224223843.2fb3394a.khali@linux-fr.org>
In-Reply-To: <20040224223843.2fb3394a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 12, 2004 at 07:39:03PM +0100, Jean Delvare wrote:
> > But what are these "classes" used for exactly?  That was my main
> > question.  Does anyone really use them?  Can we just delete them
> > altogether?
> 
> Aha. I was expecting you to tell us ;) You are the one who introduced
> them in the first place, aren't you? If not, we definitely want to
> contact that person to know what he/she had in mind.
> 
> There were no classes concept in our 2.4 drivers, which tends to prove
> that we can possibly live without them. See my previous posts for my
> opinion on the topic.

Ah, in digging through the change log entries I found the following:

ChangeSet 1.1738 2003/05/06 16:41:46 kraxel@bytesex.org
  [PATCH] i2c #3/3: add class field to i2c_adapter
    
      This is the last of three patches for i2c.  It introduces a new
      field to i2c_adapter which classifies the kind of hardware a i2c
      adapter belongs to (analog tv card / dvb card / smbus / gfx card
      ...).  i2c chip drivers can use this infomation to decide whenever
      they want to look for hardware on that adapter or not.  It doesn't
      make sense to probe for a tv tuner on a smbus for example ...



So this was a video developer's request.  Does that help explain it a
bit more now?

thanks,

greg k-h
