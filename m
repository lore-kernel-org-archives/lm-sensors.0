From: greg@kroah.com (Greg KH)
Date: Thu, 09 Mar 2006 23:54:08 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <20060309235408.GA29806@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 09, 2006 at 09:21:56PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> > > The only data I am missing now is the memory used by each additional
> > > sysfs file we create. We need to know, as Hans objected that too many
> > > sysfs files could have a negative impact on memory consumption. I dug
> > > down the sysfs code yeterday evening to find out, but didn't find what
> > > I was looking for yet. I hope to get the answer this evening.
> > 
> > sysfs files are very light.  The "large" memory structures for a ram
> > based file system are the dentry and inode structures.  sysfs now
> > creates them on the fly when they are needed, and if we have memory
> > pressure on our internal kernel caches, they are freed.
> > 
> > So in short, don't worry about creating new sysfs files, it's not an
> > issue.  The people running 20,000 disks on a 31bit s390 system have
> > already done the hard work for you :)
> 
> Thanks for your enlightened comment on this. Now, this still raises the
> question of how much the dentry and inode structures take. You say that
> they are created on the fly, but let's imagine a hardware monitoring
> utility polling the sysfs files on a regular basis, I guess that these
> structures could be considered as "permanently allocated" for this set
> of sysfs files, so the dentry and inode sizes would start to matter.

No, if memory pressure is high, they are flushed out of the kernel
caches and the memory is used by whatever else needed it.  So, it
doesn't matter how recently you touched it, if the kernel really needs
that memory due to something else, it _will_ take it back.

> >From /proc/slabinfo, I get the following sizes:
> x86: dentry 124 bytes, inode 336 bytes
> x86_64: dentry 200 bytes, inode 608 bytes

That sounds about right.

> For 33 additional files, counting one of each structure per file (which
> might not be correct, I'm really ignorant of how it actually works),
> it's around 17 kB on x86 and 29 kB on x86_64. While still not
> unacceptable (IMHO at least), this is much more than my first
> estimation.

But again, that memory is "free" so don't worry about it :)

The main point here is that yes, adding new sysfs files do take up more
memory, but don't be scared of it.  You add another disk to your box and
suddenly you just allocated way more sysfs files than that.  And again,
the people with tiny amounts of memory and 20000 disks have already
proven that loads of sysfs files are not a problem.

thanks,

greg k-h

