From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [CVS PATCH] Sync cvs tree with latest 2.5 bk tree
Message-Id: <3EA9D419.9070701@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030425183641.GB2257@kroah.com>
In-Reply-To: <20030425183641.GB2257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks.
Since we haven't yet branched lmsensors, we have some things to decide before I apply this patch.
Namely, do we do another 2.4-compatible release.
I'm in favor of at least one more, because I would like to clear up some problems in 2.7.0.
The problems are really on the i2c side though.

I just studied up on CVS merging. It appears that you can only merge from the branch to the trunk?
In i2c, 2.4 is the branch and 2.5 is the trunk. I want to get some changes from
the trunk (for example new ID's in i2c-id.h) over to the 2.4 branch before we
do a release from the 2.4 branch.

Let's decide what we want to do. I just went through 36 tickets covering almost 4 weeks.

Phil? Mark H? others? comments please

mds

Greg KH wrote:
> Hi all,
> 
> Here's a patch to sync up the lmsensors cvs tree with the current 2.5 bk
> tree.  Anyone with commit permissions want to submit it?
> 
> The header files should be renamed too, as they have been in the kernel
> tree, but a cvs diff can't show that :)
> 
> I'll submit a i2c sync patch, after this is applied, as that is out of
> date quite a bit too.
> 
> Ah, now you all see why it's tough to do work in two trees...
> 
> thanks,
> 
> greg k-h
> 
>
