From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <20040121235655.GF1958@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10745567662012@kroah.com> <10745567661358@kroah.com> <20040121225012.1addb5c7.khali@linux-fr.org>
In-Reply-To: <20040121225012.1addb5c7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 10:50:12PM +0100, Jean Delvare wrote:
> > Also note that I slightly altered the condition to display the PCILynx
> > comment. I think it's more logical that way. Without it, the user
> > could get the message he/she needs I2C, go to enable it, come back and
> > still not see the option.
> 
> For the records, please let it be noted that this change is *not* included
> in the patch submitted by Greg.
> 
> That said, I still think it was a good idea. Not that it matters much to
> me since I don't use that driver, but anyway... Who should I contact to
> get it included?

The ieee1394 maintainer?
