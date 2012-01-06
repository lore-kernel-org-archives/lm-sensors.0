From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 06 Jan 2012 14:44:54 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: fix trailing whitespace
Message-Id: <20120106144454.GA13647@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Fri, Jan 06, 2012 at 03:35:05AM -0500, Frans Meulenbroeks wrote:
> 
[...]
>  
>     If you still prefer cross-driver patches, I guess that's better than
>     not getting contributions from you at all, but then please at least
>     ensure that checkpatch doesn't complain about your patches, even if
>     that means fixing more than one issue at once. BTW, all whitespace
>     fixes can go in the same patch to start with, it makes sense to group
>     them IMHO.
>    
> 
> Hi Jean,
> 
> Thanks for your feedback.
> I did not really consider things from the perspective of the reviewer and user.
> Please ignore this patch. I'll revert back to file specific patches.
> Note that I am not planning to clean all files with checkpatch problems, but
> I'll probably do a few more inbetween other things (e.g. waiting for a kernel
> rebuild).
> 
Please don't feel discouraged. You are doing extremely well for a kernel newbie.

I agree with Jean that file specific patches are better for us, but, yes, cross-drive
patches are better than none.  The only thing we really ask for is that any patches
you submit should not have any checkpatch errors or warnings.

There is also a script named cleanpatch which is supposed to fix whitespace errors
in patches.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
