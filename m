From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 07 Dec 2006 13:51:54 +0000
Subject: [lm-sensors] Status update generic chipset support
Message-Id: <20061207135154.GG5592@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061205235059.24a657b4@ws01.atreidis.nl.eu.org>
In-Reply-To: <20061205235059.24a657b4@ws01.atreidis.nl.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bob:

* Bob Schl?rmann <bob2 at dsv.nl> [2006-12-05 23:50:59 +0100]:
> Hello all,
> 
> It has been a while since my last message in which I promised a
> patch soon, due to some other duties it got delayed a bit. However we
> are still working on the changes and a patch will be posted within a
> week.
> 
> We also started with the printing routine, this is currently finished
> for about 80%. The total lines of additional code is about 300,
> but it should support almost every chipset.

Nice.

> Some problems we encoutered and how the function currently gets around
> are below:
> 
> - Some chipsets support features that aren't supported by any other
> chipset, for example the adm1021 has a die-code feature. 
> 
> The function currently ignores these. It could be handled by some
> additional chip specific callback function.
> 
> - When reading a certain feature of a chip, some chips return 127 as the
> current value. The print routines of these chips will then either ignore
> or warn about this feature.
> 
> The function currently just prints the 127.
> 
> - The following chips have a special feature that indicates the type of
> temp. sensor used, (w83781d, it87, f71805f). None of these have
> specifified the main temp. feature as their mapping in lib/chips.c. This
> means the function can't easily find out to which temp. it belongs.
> 
> It would be easier when there was a mapping.

Don't be afraid to patch this also. ;)

> - Most chips use a bitmask to indicate which feature holds an alarm. As
> this is chip specific it (almost) can't be used in the function.
> 
> Some chips do have a different file/feature for each alarm, changing
> all/most of the chips to this model would be easier for the function.

That's true, and Jean Delvare is working toward this goal as he has time.

I'm OK with the way you're handling these problems for now.  Also, please don't
be afraid to start posting some patches, even stuff that is only partially
complete.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


