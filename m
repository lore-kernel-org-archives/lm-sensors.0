From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 13 Sep 2012 13:46:03 +0000
Subject: Re: [lm-sensors] [PATCH 4/9] drivers/hwmon/asus_atk0110.c: Remove useless kfree
Message-Id: <20120913134603.GB1400@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347462407-13499-4-git-send-email-peter.senna@gmail.com>
 <20120912161925.GA22539@roeck-us.net>
 <20120913090506.5f2d6834@endymion.delvare>
In-Reply-To: <20120913090506.5f2d6834@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Peter Senna Tschudin <peter.senna@gmail.com>, Luca Tettamanti <kronos.it@gmail.com>, kernel-janitors@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, Sep 13, 2012 at 09:05:06AM +0200, Jean Delvare wrote:
> On Wed, 12 Sep 2012 09:19:25 -0700, Guenter Roeck wrote:
> > On Wed, Sep 12, 2012 at 05:06:42PM +0200, Peter Senna Tschudin wrote:
> > > From: Peter Senna Tschudin <peter.senna@gmail.com>
> > > 
> > > Remove useless kfree() and clean up code related to the removal.
> > 
> > Queued for -next.
> 
> Patch looks good, but I don't see any "code clean-up". Either it was
> intended but forgotten, or the patch description claims too much.
> 
Thought that referred to the kfree. You are right, that isn't really a cleanup.
I'll drop that comment.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
