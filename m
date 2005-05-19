From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Adding .class field to struct i2c_client (was Re: [PATCH][2.6]
Message-Id: <20040924164315.GA7475@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41500BED.8090607@linuxtv.org> <20040921115442.M18286@linux-fr.org> <415067CB.1020101@linuxtv.org> <20040924000202.GO14868@kroah.com> <4153BD2A.8030407@linuxtv.org>
In-Reply-To: <4153BD2A.8030407@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hunold <hunold@linuxtv.org>
Cc: Jean Delvare <khali@linux-fr.org>, sensors@Stimpy.netroedge.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Sep 24, 2004 at 08:22:34AM +0200, Michael Hunold wrote:
> Hi,
> 
> On 24.09.2004 02:02, Greg KH wrote:
> >On Tue, Sep 21, 2004 at 07:41:31PM +0200, Michael Hunold wrote:
> >
> >>Please have a look and tell me what you think. The big problem will be, 
> >>that we cannot test all configurations, so it's possible that some 
> >>devices won't be recognized anymore, because the .class entries don't 
> >>match.
> 
> >I like the patches.  If you get them in a state you like (and drop the
> >printk(), and use dev_dbg() instead), 
> 
> Ok.
> 
> >and send them 1 patch per file
> >with the Signed-off-by: line, I'll be glad to apply them.
> 
> I'll re-create them against 2.6.9-rc2-mm2.
> 
> Do you really mean one patch per file, ie. about 50 separate patches? (I 
> don't care, I simply write a script that splits them up)

Sorry, I ment one email per patch (you sent more than one patch in that
email.)

thanks,

greg k-h
