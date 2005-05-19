From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: probe order for 2.6 sensor chips
Message-Id: <20030811214633.GA18733@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811204839.GA18442@kroah.com>
In-Reply-To: <20030811204839.GA18442@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 11, 2003 at 11:33:18PM +0200, Jean Delvare wrote:
> > Any thoughts as to the correct order?
> 
> First note: some drivers cannot possibly be detected, so building them
> into the kernel will result in a mess. The mess will be full if these
> drivers are loaded before the others (preventing the regular driver to
> handle the chip), and limited if these drivers are loaded after the
> others (exporting bad values).

Yeah, I'm not saying it's a good idea, just something that some users
like to do :)

> Second note: proper operation of our modules sometimes require module
> parameters. Since all our drivers have common parameter names, having
> them all in the kernel will not allow for passing such a parameter to
> only one of them. So our drivers are really meant to be compiled as
> modules, not to be built into the kernel.

Module paramaters are able to be converted into simple boot arguments
with only 1 small change to the kernel module code.  I'm going to do
that after I add kobject support for modules (should be a few weeks.)

So we need to be able to support building these drivers into the kernel
for as much as we possibly can.

> Grep'ing doc/chips tells that there is only one driver having multiple
> addresses: w83781d. However I know that ddcmon has a similar mechanism,
> so there are at least two. So a preliminary list of "high priority"
> modules follows:
> 
> w83781d
> ddcmon
> 
> And a list of "low priority" modules now (undetectable ones):
> 
> ltc1710
> pcf8574
> pcf8591

Ok, as we only have one of the above drivers in the 2.6 tree, I'll go
move the w83781d driver to the top of the list for now.  That should
solve this single bug report, and help others out in the future.

> Additionally, there's smbus-arp, but I'm not too sure about this one,
> and it shouldn't intefere with other drivers anyway, so you can leave it
> apart.

I have a port of smbus-arp to 2.6 in my local kernel tree, I just need
to clean it up to get it into shape to add to the main kernel.org tree
one of these days...

thanks for the info.

greg k-h
