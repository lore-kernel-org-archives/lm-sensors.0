From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <3E76739A.3040709@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033213315@kroah.com>
In-Reply-To: <10476033213315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

I'm catching up on my mail. Glad to have you on the job.
It's good you are taking things from CVS.
As you may know, Kyosti Malkki did a lot of cleanup and
pre-2.4.9 compatiblility removal in January.
He branched i2c CVS (with the HEAD 2.5-compatible).
Lm_sensors CVS is not branched.

The biggest thing remaining to do in CVS is tackling
the PCI drivers. Approx. 20 of our 60 drivers are PCI.

I'd like to keep sensors CVS 2.4-compatible, or at least
delay a branch as long as possible. Kyosti was working
on getting to the point that we could submit a patch
to 2.4 (until we do that, CVS is incompatible with stock 2.4
kernels because of the i2c_driver struct change).
Any sensors changes/cleanups that are 2.4 compatible,
it's preferable to check those changes into CVS
for testing. Ideally we can submit drivers to 2.5 directly
out of CVS.

mds


Greg KH wrote:
> On Fri, Mar 14, 2003 at 08:21:42AM +0000, Christoph Hellwig wrote:
> 
>>On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:
>>
>>>ChangeSet 1.1106, 2003/03/13 10:50:41-08:00, greg@kroah.com
>>>
>>>i2c: get i2c-ali15x3 driver to actually bind to a PCI device.
>>
>>OOPS, should take a look at all patches first before complaining :)
> 
> 
> Heh :)
> 
> Yes, for the first changeset I just took the cvs version of the driver
> and added it.
> 
> Then I went and made the driver work, and started to clean it up.  These
> drivers still need a lot of cleanup (static, printk, indentation in
> places, etc.) and I'll be doing it.  This is a work in progress.  I
> wanted to make baby steps with these things and not just do one
> changeset with a description that said:
> 	Took cvs version of driver and cleaned up everything
> 
> I'm trying to bridge the gap between the sensor developers and the
> kernel group.  Hopefully by working this way it will help integrate them
> more into the kernel community, and get these drivers whipped into
> shape.
> 
> thanks for looking these over.
> 
> greg k-h
> 
