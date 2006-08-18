From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 18 Aug 2006 11:48:28 +0000
Subject: [lm-sensors] [RFC-patch] pc87360 - unchecked
Message-Id: <20060818134828.c1188dc1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D2514B.2090202@gmail.com>
In-Reply-To: <44D2514B.2090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim,

> BTW - are you considering these as 18 bugfix material, or are they
> "long standing sub-optimalities" for 19 when it opens ?  (ie when 18 is out)
> 
> Obviously (from the experimentalism in my patches), Ive been treating it 
> as 19 stuff ;-)

Definitely not .18, as they don't fix any bug. So it's .19 material,
for what we can have ready before the .19 merge window. All drivers
need to be converted, this is a significant amount of work. Also the
change is likely to break other patches, so I don't want to wait for
all drivers to be converted to push all the patches - this would block
too many other patches. We can make several batches, one for .19 and
one or more after that.

A summary would be: ".19 at earliest, then as soon as possible, as time
permits". This is a background job, we have many other, more important
things in the works.

> Apologies for making this more *in-need-of-feedback* than it has to be,
> but I guess I cant quite resist..

No worry, getting feedback is the point of posting to a mailing list :)

-- 
Jean Delvare

