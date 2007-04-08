From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Apr 2007 17:40:30 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070408194030.b56f4a85.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On Sun, 8 Apr 2007 10:33:48 +0200, Axel Thimm wrote:
> On Sun, Apr 08, 2007 at 10:14:30AM +0200, Jean Delvare wrote:
> > It seems that we lose the history of changes when merging a branch, the
> > logs only show the merge and not the individual log messages. Is this
> > expected? I guess so :(
> 
> The problem is if you have two branches A and B and merge/copy over
> parts of B onto A, then a file in A has semantically two histories,
> one for the per-merge copy in A and one for the pre-merge copy in
> B. Since the history of the B copy remains in B and also since the
> true history of A != B, there isn't much choice.

Well, some source code management tools do handle it just fine, git for
example. So it's technically feasable.

>                                                  It is also a conflict
> of interests: The developer of branch A would like to see what changed
> from his POV, the one in B from his own.

Not necessarily. In my case, my wish is exactly the opposite, I would
like to have an history of all the changes, whether they originate from
my branch or not.

> But you do get a marker for copies or merges that you can follow to
> fork off A's history into B's.

True, but that's hardly convenient if merges are frequent and/or if the
number of branches is important. I start understanding why people
working with many branches don't even consider Subversion.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
