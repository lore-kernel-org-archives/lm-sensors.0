From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c/kernel i2c.h i2c-velleman.c i2c-rpx.c i2c-proc.c  i2c-pport.ci2c-philips-par.c
Message-Id: <3E24A6A4.1030200@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E23647B.2070805@paradyne.com>
In-Reply-To: <3E23647B.2070805@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I haven't used CVS branches before so please bear with me.

Did you do only the tag in preparation for branching or did you do the branch as well?

Could you give us some instructions on how to:
	- check out 2.4 or 2.5 branch
	- check into 2.4 or 2.5 branch
	- merges (guidelines?)
	- make 2.4 and 2.5 releases (perhaps update lm_sensors2/doc/developer/checklist?)

If you branched at a point where some drivers wouldn't even compile in 2.4
then isn't it a little messy? I want to test/fix under 2.4
(I'm not running 2.5) but I need a little help.

I can also put a note on the home page on the status of CVS once
I understand it :)

thanks
mds


Ky?sti M?lkki wrote:
> On Tue, 14 Jan 2003, Mark Studebaker wrote:
> 
> 
>>I thought we were going to change the refcounts
>>from .inc_use to .owner _after_ the branch...
> 
> 
> Well, yes. I made the branch already for 2.4 with tag lk2-4.
> I am just about to commit most of 2.5<->2.4 changes back to 2.4.
> 
> 
>>But if you can get the refcount changes into 2.4.21 then maybe we
>>don't need to branch at all?
> 
> 
> I am optimistic, it is backported from 2.5.53-54 changes.
> In 2.5.54+, the mentioned video4linux drivers were converted.
> Without i2c, video4linux backporting can not proceed.
> And i2c-proc used .owner in 2.3.37 already.
> 
> The branch is still useful.
> I would like to push some changes to i2c interface during the 2.5
> cycle, without worrying about 2.4 compatibility:
>  - i2c-algo-biths
>  - master_send/recv removal (issues with multi-master)
>  - pass *client with i2c_transfer (have per-client speed)
>  - master transmitter as slave receiver
> 
