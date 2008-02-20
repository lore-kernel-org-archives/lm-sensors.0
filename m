From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Feb 2008 19:07:42 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Skip "random" I/O port
Message-Id: <20080220200742.7ad77f60@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218223317.2142dc16@hyperion.delvare>
In-Reply-To: <20080218223317.2142dc16@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 18 Feb 2008 22:33:17 +0100, Jean Delvare wrote:
> Hi all,
> 
> As a follow-up of this discussion on LKML:
>   http://lkml.org/lkml/2008/2/13/390
> I would like to propose the following patch to sensors-detect:
> (...)
> The idea is to skip "random" I/O port probing on PPC, as it won't find
> anything anyway and can cause the kernel to oops.
> 
> Christian, can you please test this patch and confirm that it solves
> your problem?

My patch wasn't correct, I forgot to chomp the trailing new line
returned by uname -m. I've just committed a working fix to SVN, please
try this instead.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
