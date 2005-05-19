From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Finding user/kernel pointer bugs [no html]
Message-Id: <20040611175946.GA16673@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com> <20040610191004.GA1661@kroah.com> <20040611192116.1bb87553.khali@linux-fr.org>
In-Reply-To: <20040611192116.1bb87553.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, rtjohnso@eecs.berkeley.edu, linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 07:21:16PM +0200, Jean Delvare wrote:
> > And to be complete, here's a patch to clean up the warnings in the
> > drivers/i2c tree.  I've also applied it to my trees.
> > (...)
> > # I2C: sparse cleanups for drivers/i2c/*
> 
> Should any of these be backported to i2c in 2.4?

Nah, it's not worth it.

thanks,

greg k-h
