From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: [PATCH 2.6] i2c documentation update (2/2)
Message-Id: <20040401071641.GC13028@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040330203245.37525dcd.khali@linux-fr.org>
In-Reply-To: <20040330203245.37525dcd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 31, 2004 at 09:21:26AM +0200, Jean Delvare wrote:
> According to Greg KH:
> 
> > > Here is a patch to Documentation/i2c/sysfs-interface. This is
> > > mostly my intent to make the document more readable. There are
> > > also a few incorrectnesses fixed, and some comments added.
> > 
> > Hm, well if people understand the units correctly, I don't have a
> > problem :)
> 
> I think I can feel some irony in your answer...

Heh, yes.  There was a huge flamefest on linux-kernel a number of months
ago about units and proper terms for them.  I avoided all of that by
wording that file in the way that I did :)

> My point was that sentences such as "Fixed point value in the form
> XXXXX" were not very informative, and that simply stating the unit the
> value was in would probably be clearer. If you think it's not the case
> and if you can think of something better, feel free to change it.

Nah, we can leave your change in for now.  If people complain, we will
worry about it then...

thanks,

greg k-h
