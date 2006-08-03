From: linux-kernel@hansmi.ch (Michael Hanselmann)
Date: Thu, 03 Aug 2006 06:53:33 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060803065333.GA10611@hansmi.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 02, 2006 at 07:11:27PM -0700, Andrew Morton wrote:
> On Wed, 2 Aug 2006 21:15:20 +0200
> Michael Hanselmann <linux-kernel at hansmi.ch> wrote:

> > This driver adds support for the Apple Motion Sensor (AMS) as found in
> > 2005 revisions of Apple PowerBooks and iBooks. It implements both the
> > PMU and I?C variants. The I?C driver and mouse emulation is based on
> > code by Stelian Pop <stelian at popies.net>, while the PMU driver has been
> > developped by myself. HD parking support will be added later.

> Confused.  What is the relatioship between this code and
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/broken-out/apple-motion-sensor-driver.patch
> ?

You already asked that on July 2 in
<20060702201415.791c6eb2.akpm at osdl.org>. My driver replaces the patch
from Stelian and includes all of his code.

Here's the mail conversation back then:

On Mon, Jul 03, 2006 at 08:56:28AM +0200, Michael Hanselmann wrote:
> On Sun, Jul 02, 2006 at 08:14:15PM -0700, Andrew Morton wrote:
> > On Mon, 3 Jul 2006 00:26:49 +0200
> > Michael Hanselmann <linux-kernel at hansmi.ch> wrote:

> > > Below you find the latest revision of my AMS driver.

> > I was about to merge the below, then this comes along.  Now what?

> > From: Stelian Pop <stelian at popies.net>

> > This driver provides support for the Apple Motion Sensor (ams), which
> > provides an accelerometer and other misc.  data.  Some Apple PowerBooks

> I just noticed yesterday that Stelian sent a patch to lkml in May. My
> work is based on his separate driver from his website.

> Given the fact that my driver includes all of his functionality and that
> replacing his with mine later in the process would mean to remove whole
> files again, I'd suggest to wait until I've fixed the outstanding issues
> (as seen in this thread) and then to merge mine.

This was approved by Stelian and yourself. So ? I think you can just
replace Stelian's patch with mine.

Thanks,
Michael

