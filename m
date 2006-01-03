From: punkytse@punknix.com (Punky Tse)
Date: Tue, 03 Jan 2006 18:04:53 +0000
Subject: [lm-sensors] [Voyage-linux] RE: scx200_acb: unexpected ACBCTL2
Message-Id: <43BABCC5.2000903@punknix.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben, Joe and Mike,

I am patching the kernel.  Looking at the patch file you mentioned, I see one line difference.  In debain 2.6.8 kernel, 
it uses schedule_timeout(HZ/100+1) instead of yield() stated in the patch.

And I just tested the 2.6.8 kernel without patch, the modprobe fail problem appear immediately.  Not the same I 
experienced in 2.6.14 kernel.

Moreover, tested the 2.6.14 kernel with your patch appiled, modprobe fail problem also appears immediately. Running with 
"modprobe sc200_acx base=0x820,0", it return no delay and no error!

Thanks a lot,
Punky


BGardner at Wabtec.com wrote:
> Hi Mike, Joe -
> 
> It looks like the scx200_acb driver scans two IO addresses by default
> (0x820, 0x840).
> One of them doesn't exist. That explains the ACBCTL2 readback problem.
> =)
> You should be able to get rid of that message by using the 'base' module
> parameter.
> Here's a guess at the format.
> $ modprobe scx200_acb base=0x820,0
> 
> 
> In [1], Joe mentioned a 15 second delay.
> 
> The scx200_acb driver has a flaw where it misses the NACK indication
> when it tries to write to an address that doesn't exist. This causes it
> to timeout instead of immediately returning a failure.  Likely, your
> hardware is 'scanning' for around 15 devices that don't exist. 
> 
> Refer to this patch for a possible fix: 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2005-December/014716.ht
> ml
> 
> Another thing to do is to add 'ignore' parameters to modprobe so that
> the chip drivers don't scan for devices that don't exist.
> 
> For example, I use this for my lm83:
> $ modprobe lm83 force=0,0x4c
> ignore=0,0x18,0,0x19,0,0x1a,0,0x29,0,0x2a,0,0x2b,0,0x4d,0,0x4e
> 
> Ben
> 
> 
>>-----Original Message-----
>>From: lm-sensors-bounces at lm-sensors.org 
>>[mailto:lm-sensors-bounces at lm-sensors.org] On Behalf Of 
>>Michael Renzmann
>>Sent: Tuesday, January 03, 2006 1:53 AM
>>To: lm-sensors
>>Subject: [lm-sensors] scx200_acb: unexpected ACBCTL2 readback
>>
>>Hi.
>>
>>On the voyage-linux mailing list there recently has been a 
>>report about
>>a problem related to scx200_acb in 2.6.x kernels. The 
>>original report is
>>at [1], a short but more detailed analysis of the problem is at [2]. 
>>
>>The problem seems to be that loading scx200_acb fails during 
>>the probing
>>phase, but loading and using LM77 after that still works fine. Quoting
>>[2]:
>>
>>== cut =>>Same here with a non-voyage 2.6.11 kernel. I enabled 
>>debugging and added
>>a bit more info into the relevant message and I get:
>>
>>i2c /dev entries driver
>>scx200_acb: ACBCTL2 readback failed, got 0xff
>>  : probe failed
>>
>>The driver write 0x70 to ACBCTL2 and expects to read 0x70 back, but it
>>gets 0xff instead. Looked into the manual briefly, but seems too
>>complicated to figure out quickly. As you mention, lm77 works fine
>>thereafter. Weird...
>>== cut =>>
>>Comments?
>>
>>Bye, Mike
>>
>>[1]
>>http://list.voyage.hk/pipermail/voyage-linux/2005-December/000548.html
>>[2]
>>http://list.voyage.hk/pipermail/voyage-linux/2006-January/000565.html
>>
>>
>>_______________________________________________
>>lm-sensors mailing list
>>lm-sensors at lm-sensors.org
>>http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>>
> 
> 
> 
> _______________________________________________
> Voyage-linux mailing list
> Voyage-linux at list.voyage.hk
> http://list.voyage.hk/mailman/listinfo/voyage-linux


