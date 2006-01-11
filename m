From: greg@kroah.com (Greg KH)
Date: Wed, 11 Jan 2006 19:03:49 +0000
Subject: [lm-sensors] describe the patch flow, review process
Message-Id: <20060111190349.GA3608@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BEB2C3.5050706@gmail.com>
In-Reply-To: <43BEB2C3.5050706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 06, 2006 at 11:11:15AM -0700, Jim Cromie wrote:
> 3.   Greg then
>     a. puts them here ??  (I dont see them)
>         http://www.kernel.org/pub/linux/kernel/people/gregkh/

Close:
	kernel.org/pub/linuc/kernel/people/gregkh/gregkh-2.6/patches/
Note that there is a lot of non-sensor stuff in there so you probably
only care about:
	kernel.org/pub/linuc/kernel/people/gregkh/gregkh-2.6/patches/i2c/
but not always.

>     b.  pushes them to AKPM for inclusion in -mm

No, Andrew picks them up from:
	kernel.org/pub/linuc/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c/
which is the staging area for him.

>           does he consolidate them to 1 patch ?

No.

>              I think not, that would lose the attributions
> 
> 
> and this is where I get a bit fuzzy.

I then push them to Linus when it's ok to do so, by taking the patches,
creating a temporary git tree and asking Linus to pull it.  I also post
the patches that I'm asking Linus to pull to this list.

> 2.6.15-mm1 came out recently  
>     http://lkml.org/lkml/2006/1/5/149
> 
> but none of the stuff in 2.a  is there   (I looked for mine).

It takes a while to bubble up :)

> Is that because theyre going to Linus  / main / git  instead ?
> and if so (not going to -mm)  why ?
>         dont they warrant more testing / exposure there ?

If I've already sent the patches to Linus, and he's applied them, then
they get into -mm with the "latest linus patch".

Hope this helps,

greg k-h

