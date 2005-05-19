From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Winbond W83792D driver
Message-Id: <425B3D23.8080303@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42461044.3080406@mds.gotdns.com>
In-Reply-To: <42461044.3080406@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the way I read the datasheet the first time (page 44) bits 2 and 6 were fixed at 0 and 1;
that's why I coded it the way I did.
But reading again that doesn't look right, that's just the power-up default,
they aren't fixed.
So your patch looks good.
thanks
mds

Jean Delvare wrote:
> Hi Chunhao,
> 
> 
>>>This should be fixed in the 2.4 driver as well.
>>
>>Would you please help to fix the bug in 792 driver for linux 2.4?
>>Because you have the CVS account. I think I need NOT generate a patch
>>this time.
> 
> 
> I have a patch ready, it's sitting in my local CVS repository. I was
> only waiting for Mark to comment on this in case I had missed something.
> I'll commit it this evening.
> 
> After that, I think we are ready to release 2.9.1 :)
> 
> --
> Jean Delvare

