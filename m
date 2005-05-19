From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: update_lock
Message-Id: <20040320194110.GE10792@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320184909.4c7d8d80.khali@linux-fr.org>
In-Reply-To: <20040320184909.4c7d8d80.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 20, 2004 at 06:49:09PM +0100, Jean Delvare wrote:
> Hi all,
> 
> I have a question about the locking mechanism we have in all our i2c
> client drivers, 2.4 and 2.6 as well.
> 
> The data->update_lock semaphore is used in the *_update_dev function,
> and only there. There are various other places all over the drivers
> where we access the same internal data, (in get callback functions) and
> even write to it (in store callback functions typically), and also
> access the i2c bus (in store functions too).
> 
> Why is it that we don't use the lock here?
> 
> What are we trying to protect exactly?

I remember trying to figure this out a while ago too, and didn't come up
with an answer.  I sent in some patches that I thought were correct, but
others said no.

It would be good to figure this out.

thanks,

greg k-h
