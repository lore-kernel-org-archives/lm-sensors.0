From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c patch out of 2.6.4-rc1-mm1
Message-Id: <20040301193042.GB9609@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1078150396.404344fc41690@imp.gcu.info>
In-Reply-To: <1078150396.404344fc41690@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 01, 2004 at 07:52:07PM +0100, Jean Delvare wrote:
> > > I just saw that the i2c stuff from Greg's tree have been backed out
> > > from 2.6.4-rc1-mm1. Quoting the release notes:
> > > 
> > > "bk-i2c.patch was dropped pending it getting its lmsensors act
> > > together."
> > > 
> > > I don't quite understand what I am (well, what we are...) supposed
> > > to do (actually, I do not even get the meaning of the sentence
> > > itself). I clearly exposed my reasons for an interface change and as
> > > far as I know, nobody objected to that particular point.
> > 
> > The problem is that there is no way a user can get a working
> > libsensors to work with the -mm kernel right now, correct?
> 
> Not quite. The necessary patches are available on my personal server, as
> advertised here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m7787111318197
> 
> Maybe the address should have been advertised more.

Yes it should have :)

> I was a bit surprised that the changes went into Andrew's tree for
> testing (although I now understand and agree that it was the right
> thing to do) and we suddenly had to support two incompatible trees
> with one single CVS repository.

Andrew is picking up my usb, pci, driver, and i2c trees in the -mm
series to get them more testing before they go into the mainline kernel.
It's working out quite well so far, thanks for doing this Andrew!

> I thought we wanted to have our CVS repository always compatible with
> the latest Linus' tree, this is why I had not commited the sysfs
> interface change yet. And also because I did not want to "force" the
> kernel patch to be accepted.

Ok, how about doing this:
	- make a lmsensors release now.  I'm not going to send any i2c
	  patches to Linus until after 2.6.4 is out, so you can cut a
	  release today if you want to.
	- add your fixes to the lmsensors cvs tree, so that users of the
	  -mm kernel can get them if they want to.  Idealy you could
	  also make another lmsensors release, as these patches will go
	  into Linus's tree after 2.6.4 is out.

Sound good?  That way the i2c patches can go back into the -mm kernel,
and users can test them and the lmsenors changes out.

thanks,

greg k-h
