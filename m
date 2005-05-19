From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c changes Was: sensors in 2.5.54
Message-Id: <3E1B6F24.3030700@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Kyosti Malkki wrote:
> On Sat, 4 Jan 2003, Mark Studebaker wrote:
> 
> 
>>The patch for i2c-amd756, i2c-amd8111, adm1021, and lm75,
>>submitted by Pavel Machek, has been included,
>>with modifications, in kernel 2.5.54 by Cristoph Hellwig.
> 
> 
> Attached patch removes unnecessary include of i2c header files
> at few locations. With luck it still compiles. Should..
> 
> It seems that sysctl enumeration has moved out of sensors.h, but
> libsensors depends on this. While the list is long and boring, so is
> linux/sysctl.h. I believe we want it back.
> 

agreed

> 
>>Note that we'll have to go through the changes he made,
>>figure them out, backport them into CVS, and apply
>>to the other drivers.
>>
>>This will be somewhat easier after we remove 2.2 support.
>>But there are still several 2.4<->2.5 differences which
>>we will have to keep out of CVS, or at least #ifdef,
>>and the patcher will have to deal with those.
> 
> 
> One could generate a branch in CVS from i2c release V2-6-4 to trace back
> changes in 2.5 tree, and then reapply it on 2.5 to sync revision tags.
> I briefly reviewed some i2c diffs, they mostly handle module refcounting
> and declarations which are not likely to change for 2.4 support.
> 

I have Pavel's mail from December 4 to linux-kernel with his submission,
which is taken from the contents of our 2.7.0 release of Dec. 8.
Right Pavel? (if you made changes before you submitted the patch
let's start by having you check those changes in!)
So I think we only have to go back to 2.7.0, so the resync won't be
_too_ bad.

If we do branch we shouldn't do it before 2.8.0, when we remove 2.2 support.

Hopefully there aren't many 2.4-2.5 differences and the 2.5 patch submitter could
keep up manually rather than having to branch.

If somebody could generate and submit the refcount changes to 2.4,
would that make things better- or worse?

> Optimally, we could keep up with the pace and have relevant 2.5 patches
> go through i2c CVS first and have files in sync. This seems not be the
> case, so I say it is better to remove revision tags from i2c files in
> Linus's tree altogether.
> 
> 

For i2c, we've kept up for years - in fact we have the opposite problem now,
we have lots of stuff in the i2c tree that we haven't gotten in to either 2.4 or 2.5.
(2.4 is at our release 2.6.1, about 15 months old, and 2.5 is at 2.6.4, about
15 months old).

Cristoph's changes are largest I can recall that didn't come from us.
That's what happens when we aren't getting changes in - other
folks make the changes and we get where we are now.
