From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm sensors sysfs file structure
Message-Id: <20030327192517.GJ32667@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E83459A.3090803@portrix.net> <20030327185222.GI32667@kroah.com> <1048792523.7569.102.camel@nosferatu.lan>
In-Reply-To: <1048792523.7569.102.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>, KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com

On Thu, Mar 27, 2003 at 09:15:23PM +0200, Martin Schlemmer wrote:
> On Thu, 2003-03-27 at 20:52, Greg KH wrote:
> 
> > > Is this the way you want to go? Just an example for the voltages.
> > 
> > That looks very good to me, nice 
> 
> While we are at it, some form question.  The w83781d have a
> magnitude of files in sysfs if you split them like this, so
> I went for the shorter (easier?) way.
> 
> This ok, or should I split it up a bit more.  Note that I
> have not done much for indentation yet.

This is fine with me, whatever works for you.  Either way, we are
abusing macros a bunch :)

thanks,

greg k-h
