From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: [PATCH 2.6] Prevent i2c-dev oops with debug
Message-Id: <20040309230217.GA13763@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040302224909.444663af.khali@linux-fr.org>
In-Reply-To: <20040302224909.444663af.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 02, 2004 at 10:49:09PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Looks like i2c-dev suffers the same problem with dev_dbg as i2c-core did
> twice. Here is a patch that fixed a oops I and another user were
> experiencing when running sensors-detect.
> 
> Please note that I have no idea if this is the correct way to fix the
> problem. I mostly copied the fix from i2c-core. I don't quite understand
> what we are supposed to pass to dev_dbg.

Hm, I'll apply this for now.  I'm working on fixing the i2c-dev driver
up a bunch more, but this is good for now.

> BTW, I read that you don't plan to send any i2c patch to Linus before
> 2.6.4. I agree that we need to calm down a bit ;) but there are a
> several oops preventing patches in my list (i2c-core, i2c-i801,
> i2c-sis5595, i2c-ali1535 and now i2c-dev). Shouldn't these simple but
> important fixes be sent to Linus?

They only happen when people enable debugging, right?  That's a pretty
simple fix :)

> Also, I sent a mail to you some times ago about classes. The fact that 3
> bus drivers are unusable at the moment sounds like an important issue to
> me, and we would need to decide about what should be done.

Sorry, getting behind these days...  I saw your recent patch and that
looks good for now.  I'll put it in the queue to apply.

thanks,

greg k-h
