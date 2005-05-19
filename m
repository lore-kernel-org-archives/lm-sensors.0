From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <20040215165904.GC25709@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 15, 2004 at 12:39:58PM +0100, Jean Delvare wrote:
> > Ok, how about writing up a summary of the proposal, listing the name
> > changes you want to make, and why, and post it to lkml so that
> > everyone has some advance notice of what will happen.  They can then
> > discuss anything that we might not have caught.
> 
> Hm, looks like this list is the adequate place for such a discussion
> (and I'm glad that everyone finally took part of it, because it is so
> important).
> 
> Posting the proposal alone on LKML is likely to duplicate the exchanges
> we had here. On the other hand, adding all the suggestions Philip
> Pokorny, Mark Hoffman and Mark Studebaker together with my answers will
> make the post long and possibly hard to read, and I am not sure people
> will want to read it.
> 
> Would it be correct to post a summary together with a link to this
> thread? That way, people who want to know more can read the whole story
> in a convenient form.

I doubt that would be ok.  We need to let the world know why we are
changing a public interface during a "stable" kernel series.  Remember,
there are other users of the sysfs sensor interface other than
lmsensors.

So I think a summary of what we want to change, and why to lkml is still
necessary.  If enough people object, we might be stuck with what we
currently have...

thanks,

greg k-h
