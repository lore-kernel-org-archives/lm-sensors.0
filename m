From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: testers wanted
Message-Id: <Pine.LNX.4.53.0312232320490.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031222231810.53439aaf.khali@linux-fr.org>
In-Reply-To: <20031222231810.53439aaf.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 23 Dec 2003, Jean Delvare wrote:

> I have a second patch on my stack, provided by Ky?sti. This is km1 (drop
> older kernels compatibility), reviewed, fixed and extended. Attached.
>
> Patch is voluntarily generated with -U1 so that it won't fail if applied
> without the first patch. Since this patch only contains removals, no
> context is really needed.
>
> Ky?sti, the next patch I'll push on my stack will be km3+km5. I've
> cleaned it up and fixed what needed to be so that it compiles and work
> fine, but there are three points I'd like to hear you about:
>
> 1* What is the reason for disabling i2c_get_client? Is it in any way
> related to locks? To me it belongs to a different patch.

Yes, it is missing locks. I'll add the locks instead.

> 2* Your patch includes a large rewrite of i2cproc_bus_read. How tightly
> is it related to locks? I see that the new version uses locks, but it
> also looks like this isn't the reason why the function was rewritten. If
> possible, we'd better split the patch in two pieces, one for the locks,
> and one for the rewrite.

The inode will match only one adapter. This patch moves the real work
outside the loop, after the correct adapter is found. Changed indent
makes it look like a rewrite but it is not.

> 3* The argument name change in i2c_smbus_xfer doesn't belong to this
> patch either. Is it OK to move it apart, or am I missing something?

Well, it is down(&adap->bus) in 2.8.2. That's why.


More patches on Saturday. These will include:

Fix i2c_get_client.

Fix module reference counting to use try_inc_mod_count in place of
__MOD_INC_USE_COUNT, and have i2c_inc_use_client return int. While this
is an API change, the return code is just silently ignored. Fix
i2c_use_client to study the mentioned return code.

Fix reference counting in i2c-dev open/close.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
