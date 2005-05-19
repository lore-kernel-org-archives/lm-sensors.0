From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c cvs repository status
Message-Id: <20031223011358.GH5427@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031220120151.27b9db49.khali@linux-fr.org>
In-Reply-To: <20031220120151.27b9db49.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 20, 2003 at 10:59:41PM +0100, Jean Delvare wrote:
> 
> Greg, how do you think future developments should take place now that
> Linux 2.6.0 is out? I certainly have a few ideas about the topic but
> these are not shared by everyone, as you can see ;)

I don't think that you should use a CVS tree at all!  You will miss
changes that happen in the main kernel tree, and cause those changes to
get un-applied when trying to apply your patches.  It also causes a
mindset of only syncing up with the kernel tree at infrequent intervals,
which is not a good thing.

So, I recommend just working off of the main kernel.org tree, and submit
any changes that you might have to the main tree.  That encourages
small changes and you don't miss things that happen to the i2c code by
other people (which will happen, just get used to it...)

Personally I use BitKeeper to do this kind of development, it provides a
_very_ easy way to merge your changes forward and then break them out
and send them on to someone else as a patch.  You can also do this with
just patch and diff (which is also what I used for a number of years.)
I wrote an article for Linux Journal a while ago that explained one way
of doing this (for both patch/diff and bitkeeper.)

That's my opinion, thanks for asking :)

greg k-h
