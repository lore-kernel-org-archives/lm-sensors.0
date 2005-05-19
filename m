From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c patch out of 2.6.4-rc1-mm1
Message-Id: <20040301173206.GH8515@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1078150396.404344fc41690@imp.gcu.info>
In-Reply-To: <1078150396.404344fc41690@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 01, 2004 at 03:13:16PM +0100, Jean Delvare wrote:
> Hi Andrew, hi Greg,
> 
> I just saw that the i2c stuff from Greg's tree have been backed out
> from 2.6.4-rc1-mm1. Quoting the release notes:
> 
> "bk-i2c.patch was dropped pending it getting its lmsensors act
> together."
> 
> I don't quite understand what I am (well, what we are...) supposed to
> do (actually, I do not even get the meaning of the sentence itself). I
> clearly exposed my reasons for an interface change and as far as
> I know, nobody objected to that particular point.

The problem is that there is no way a user can get a working libsensors
to work with the -mm kernel right now, correct?  I thought you were
going to make a new release for the 2.6.3 kernel, and then commit your
changes to cvs to allow users running the -mm tree to use that version.

Is this the case?

thanks,

greg k-h
