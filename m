From: rindjon@yahoo.com (Ron Rindzunski)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: struct i2c_adapter
Message-Id: <20050324150434.19253.qmail@web30807.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050313095755.65690.qmail@web30809.mail.mud.yahoo.com>
In-Reply-To: <20050313095755.65690.qmail@web30809.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean and Mark
 
Thanks for the fast answer guys!
I did looked at the docs and although it took me a while to figure them out, my application is now working OK.
 
will be glad to write to you again,
 
Ron Rindjunsky

Jean Delvare <khali@linux-fr.org> wrote:
Hi folks,

> > trying to port my own application using i2c 2.6.1 interface version
> > to i2c 2.9.0 version i got two compile errors, both referring to
> > changes been done in struct i2c_adapter in i2c.h file:
> > problem # 1:
> > struct i2c_adapter {
> > - struct semaphore lock;
> > was replaced by 
> > + struct semaphore bus;
> > + struct semaphore list;
> > problem # 2:
> > - int client_count;
> > has been deleted completely
> > }
> > 
> > can you please explain to me what were those fields original
> > intention, why did you apply the changes, and most important - what
> > should i do in order to overcome the problems resulting from those
> > changes.
> 
> they have to do with locking.
> the i2c and sensors CHANGES documents provide some background, you
> can see more information from the cvs logs.
> The best way to fix it is to diff a similar driver from 2.6.1 to 2.9.0
> and that will show you what changes you have to make.

This probably won't help. These members are used by i2c-core only, other
drivers should NOT use them. If Ron's driver broke, I suspect it is
using them, but really shouldn't.

-- 
Jean Delvare

		
---------------------------------
Do you Yahoo!?
 Yahoo! Small Business - Try our new resources site! 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050324/60cfdef7/attachment.html
