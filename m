From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: struct i2c_adapter
Message-Id: <42374514.6020202@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050313095755.65690.qmail@web30809.mail.mud.yahoo.com>
In-Reply-To: <20050313095755.65690.qmail@web30809.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ron Rindzunski wrote:
> Hi !
> trying to port my own application using i2c 2.6.1 interface version to 
> i2c 2.9.0 version i got two compile errors, both referring to changes 
> been done in struct i2c_adapter in i2c.h file:
> problem # 1:
> struct i2c_adapter {
> -    struct semaphore lock;
>       was replaced by    
> +   struct semaphore bus;
> +   struct semaphore list;
> problem # 2:
> -    int client_count;
>      has been deleted completely
> }
>  
> can you please explain to me what were those fields original intention, 
> why did you apply the changes, and most important - what should i do in 
> order to overcome the problems resulting from those changes.
>  
> thanks
> Ron
> rindjon@yahoo.com <mailto:rindjon@yahoo.com>  
>

they have to do with locking.
the i2c and sensors CHANGES documents provide some background, you
can see more information from the cvs logs.
The best way to fix it is to diff a similar driver from 2.6.1 to 2.9.0 and
that will show you what changes you have to make.
If you have specific questions  let us know.

mds
