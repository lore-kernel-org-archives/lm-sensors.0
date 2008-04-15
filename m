From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Apr 2008 12:58:58 +0000
Subject: Re: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <20080415145858.52c44b75@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
In-Reply-To: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 14 Apr 2008 23:51:03 +0800, Mini Stac wrote:
> GNU bash, version 3.2.25(1)-release (i486-pc-linux-gnu)
> 
> I am afraid I am not familiar with build, but if you can give me some steps
> or links to a tutorial I would be happy to try it out.

If you're not used to building tools from source code, most packages you
need (make, gcc, etc.) are probably not installed on your system so you
won't be able to build bash yourself.

On my end, I tried building bash 3.2 including all the patches ubuntu
is using, but I was still not able to reproduce the bug you reported:
pwmconfig worked OK for me. So I just don't know what is going on.

You may want to try reporting the bug to the Ubuntu bash package
maintainer (if there's anything like that) and see if he/she has an
idea.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
