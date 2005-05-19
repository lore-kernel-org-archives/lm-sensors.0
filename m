From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <20030923200824.A24300@infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10642734271572@kroah.com> <1064273428551@kroah.com> <20030923091617.B10818@infradead.org> <20030923161929.GB4402@kroah.com> <20030923172258.B19880@infradead.org> <20030923190440.GA5205@kroah.com>
In-Reply-To: <20030923190440.GA5205@kroah.com>; from greg@kroah.com on Tue, Sep 23, 2003 at 12:04:40PM -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Tue, Sep 23, 2003 at 12:04:40PM -0700, Greg KH wrote:
> Heh, good point.  Ok, I dug out a box that uses a isa i2c adapter and
> tested the patch below.  As the chip drivers are using request_region
> properly, taking this check out of i2c-sensor.c makes sense.

Looks better already, but I really wonder WTF this i2c_check_addr
thing is.  It looks at least as racy as check_region..
