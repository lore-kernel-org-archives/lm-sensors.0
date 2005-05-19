From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Finding user/kernel pointer bugs [no html]
Message-Id: <20040611192116.1bb87553.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu>
	<20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk>
	<20040610165821.GB32577@kroah.com>
	<20040610191004.GA1661@kroah.com>
In-Reply-To: <20040610191004.GA1661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, sensors@Stimpy.netroedge.com, rtjohnso@eecs.berkeley.edu, linux-kernel@vger.kernel.org

> And to be complete, here's a patch to clean up the warnings in the
> drivers/i2c tree.  I've also applied it to my trees.
> (...)
> # I2C: sparse cleanups for drivers/i2c/*

Should any of these be backported to i2c in 2.4?

-- 
Jean Delvare
http://khali.linux-fr.org/
