From: akpm@osdl.org (Andrew Morton)
Date: Thu, 03 Aug 2006 07:26:23 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060803002623.c54d1da7.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 3 Aug 2006 08:53:33 +0200
Michael Hanselmann <linux-kernel at hansmi.ch> wrote:

> On Wed, Aug 02, 2006 at 07:11:27PM -0700, Andrew Morton wrote:
> > On Wed, 2 Aug 2006 21:15:20 +0200
> > Michael Hanselmann <linux-kernel at hansmi.ch> wrote:
> 
> > > This driver adds support for the Apple Motion Sensor (AMS) as found in
> > > 2005 revisions of Apple PowerBooks and iBooks. It implements both the
> > > PMU and I?C variants. The I?C driver and mouse emulation is based on
> > > code by Stelian Pop <stelian at popies.net>, while the PMU driver has been
> > > developped by myself. HD parking support will be added later.
> 
> > Confused.  What is the relatioship between this code and
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/broken-out/apple-motion-sensor-driver.patch
> > ?
> 
> You already asked that on July 2 in
> <20060702201415.791c6eb2.akpm at osdl.org>.

I thought it was such a good question that I'd use it again.

> My driver replaces the patch
> from Stelian and includes all of his code.

Stelian, can we have a signed-off-by:, please?

Also, the previous patch had an s-o-b from Johannes.  Does this version
need one too?  

