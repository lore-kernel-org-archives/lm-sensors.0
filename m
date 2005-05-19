From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c/kernel i2c.h i2c-velleman.c i2c-rpx.c i2c-proc.c
Message-Id: <Pine.OSF.4.50.0301150212530.11865-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E23647B.2070805@paradyne.com>
In-Reply-To: <3E23647B.2070805@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 14 Jan 2003, Mark Studebaker wrote:

> I haven't used CVS branches before so please bear with me.
>
> Did you do only the tag in preparation for branching or did you do the
> branch as well?

A branch for 2.4 was made, and tagged "lk2-4". At first I forgot to put
a symbolic tag to checkout branch point, use POST-2-4-9-KERNELS.

> Could you give us some instructions on how to:
> 	- check out 2.4 or 2.5 branch

For the latest of 2.4, use the branch name tag to checkout or update.

 cvs co -r lk2-4 i2c

As 2.5 is main branch, you are in it by default.

> 	- check into 2.4 or 2.5 branch

Once you checkout or update using some tag in the 2.4 branch,
your working directory is locked into 2.4 branch as long
as you explicilty remove the "sticky tag" for branch lk2-4:
 cvs up -A

While the sticky tag is valid, commits will only go to the respective
branch.

> 	- merges (guidelines?)
> 	- make 2.4 and 2.5 releases (perhaps update
> lm_sensors2/doc/developer/checklist?)

I'll comment on these later today.

> If you branched at a point where some drivers wouldn't even compile in 2.4
> then isn't it a little messy? I want to test/fix under 2.4
> (I'm not running 2.5) but I need a little help.

I branched after removing VERSION_CODE < 2.4.9 tests.
This is now tagged POST-2-4-9-KERNELS. Diff against previously patched
2.4.20 kernel looks good to me.

> I can also put a note on the home page on the status of CVS once
> I understand it :)

I am stuck with emacs, I know there are better alternatives to show the
tag tree. Now that main and branch both have tags, it will open your
eys.

Good, since I haven't played with that part at all.
Apologies for the rush and good night.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
