From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Wed, 11 May 2011 17:15:05 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110511171506.076881A987F@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2688.1305134105.1@kahu.w5pny.comcast.net>

This new i8k crashes on my machine, the old one does not.

	Harry McGavran

On Wed, 11 May 2011 17:08:17 +0200 Jean Delvare wrote:

------- =_aaaaaaaaaa0
Content-Type: message/rfc822
Content-ID: <2688.1305134105.2@kahu.w5pny.comcast.net>
Content-Description: original message

Return-Path: khali@linux-fr.org
Delivery-Date: Wed, 11 May 2011 09:48:20 -0600
Return-Path: <khali@linux-fr.org>
X-Original-To: w5pny@localhost.localdomain
Delivered-To: w5pny@localhost.localdomain
Received: from kahu.w5pny.comcast.net (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with ESMTP id 8A01E1A9865
	for <w5pny@localhost.localdomain>; Wed, 11 May 2011 09:48:20 -0600 (MDT)
X-Apparently-To: w5pny@w5pny.com via 74.6.114.40; Wed, 11 May 2011 08:34:28 -0700
X-YahooFilteredBulk: 212.85.147.21
Received-SPF: none (mta1008.biz.mail.mud.yahoo.com: domain of khali@linux-fr.org does not designate permitted sender hosts)
X-YMailISG: AzyUr7wcZAqVNUkZJfKNTbXFskNqFMJoZzBy9C1hjthsEXpX
 Emi.9NLdspaLDcj0ArFkYiNa_Pp64C6brB1rtmHD8ReAYEouu5wLInrjxmHw
 Xn3yFkmAuS.jENIfO.O5_IcMdcW9.Rr9rVg2crywgbMat_sn6I7GCXc32fst
 X1FFc8YywQnoXuFU2crUhycKx7WHD_EeoxzkOJe2_40C2QMcxjhuOAa09_k6
 LyMImhNXzBhJZ6TwgZil_uTkLWN3z3IgljSXGMCTIVHPlKIVQo1iSPHors35
 zWtt1wz.0KE1RxuL1LMTrhv8OmlLZjNd3uZX5nYaGidtFsy2w5eYvVF1QULE
 ezBvi079Ae9LR5OyLsl24Q1io9KSmiJzwWpKcBOz2kk2BtXWaeom1FedAph8
 .hMBDnndKNmC8sCkrPkaokrtgQeL4C9pww36RXdCsY8zHB4TbNUd_pB9v9zx
 r7qDMMB6_9GFM0hB714BXyrGEbT38D9xvb779dtj9DPffDp.vbr1Y0LvwJRQ
 sSd7ui4P0X.a1_1aKGrHpkZNt7KF
X-Originating-IP: [212.85.147.21]
Authentication-Results: mta1008.biz.mail.mud.yahoo.com  from=linux-fr.org; domainkeys=neutral (no sig);  from=linux-fr.org; dkim=neutral (no sig)
Received: from pop1.biz.mail.vip.sp1.yahoo.com [69.147.84.46]
	by kahu.w5pny.comcast.net with POP3 (fetchmail-6.3.19)
	for <w5pny@localhost.localdomain> (single-drop); Wed, 11 May 2011 09:48:20 -0600 (MDT)
Received: from 127.0.0.1  (EHLO services.gcu-squad.org) (212.85.147.21)
  by mta1008.biz.mail.mud.yahoo.com with SMTP; Wed, 11 May 2011 08:34:28 -0700
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1QKC9R-0005WC-4E
	(TLSv1:AES128-SHA:128)
	(envelope-from <khali@linux-fr.org>)
	; Wed, 11 May 2011 18:20:41 +0200
Date: Wed, 11 May 2011 17:08:17 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Jeff Rickman <jrickman@myamigos.us>, w5pny@w5pny.com, Ric
 <fhj52rags@yahoo.com>, lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-ID: <20110511170817.08d8a203@endymion.delvare>
In-Reply-To: <20110511142804.GA27621@nb-core2.darkstar.lan>
References: <20110508152737.6DB861A987F@localhost.localdomain>
	<4DC76040.2020908@myamigos.us>
	<20110509214231.26a98b87@endymion.delvare>
	<4DC9438D.7000301@myamigos.us>
	<20110510162433.0dbd4d76@endymion.delvare>
	<4DC95439.8080001@myamigos.us>
	<20110511124334.GA23421@nb-core2.darkstar.lan>
	<20110511134859.GA24405@nb-core2.darkstar.lan>
	<20110511161545.0f8aeb78@endymion.delvare>
	<20110511142804.GA27621@nb-core2.darkstar.lan>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.20.1; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-filter: ifile 1.3.8 => Dell670

On Wed, 11 May 2011 16:28:04 +0200, Luca Tettamanti wrote:
> On Wed, May 11, 2011 at 04:15:45PM +0200, Jean Delvare wrote:
> > On Wed, 11 May 2011 15:48:59 +0200, Luca Tettamanti wrote:
> > > The driver uses lahf to copy the lowest byte of EFLAGS to eax, then
> > > shifts it to right and test the lowest bit (CF).
> > > Using pushf instead we get the whole EFLAGS and test the lowest bit.
> > > Does it make sense? Someone should double check the patch, I don't trust
> > > my assembly skills ;)
> > > 
> > > diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
> > > index d72433f..3554d10 100644
> > > --- a/drivers/char/i8k.c
> > > +++ b/drivers/char/i8k.c
> > > @@ -139,8 +139,8 @@ static int i8k_smm(struct smm_regs *regs)
> > >  		"movl %%edi,20(%%rax)\n\t"
> > >  		"popq %%rdx\n\t"
> > >  		"movl %%edx,0(%%rax)\n\t"
> > > -		"lahf\n\t"
> > > -		"shrl $8,%%eax\n\t"
> > > +		"pusfh\n\t"
> > 
> > I think you meant pushf, not pusfh, right?
> 
> Yeah, right... hand me that brown paper bag ;)
> 
> > 
> > > +		"popl %%eax\n\t"
> > >  		"andl $1,%%eax\n"
> > >  		:"=a"(rc)
> > >  		:    "a"(regs)
> > 
> > I am no asm expert, but I don't get why you removed the shrl
> > instruction. As I understand it, your pushf+popl replaces only lahf,
> > the bit shifting is still needed (I assume the code wants to test bit 8
> > in the flag register.)
> 
> AFAIK lahf loads the lowest byte of EFLAGS into AH which is the upper
> half of AX, hence the shift.

Yes, you're right, of course. So much for my asm skills. Please return
the brown paper bag to me when you're done ;)

> The popl is wrong though, pushf only pushes 2 bytes... so let's try
> again:
> 
> diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
> index d72433f..f71f266 100644
> --- a/drivers/char/i8k.c
> +++ b/drivers/char/i8k.c
> @@ -139,8 +139,8 @@ static int i8k_smm(struct smm_regs *regs)
>  		"movl %%edi,20(%%rax)\n\t"
>  		"popq %%rdx\n\t"
>  		"movl %%edx,0(%%rax)\n\t"
> -		"lahf\n\t"
> -		"shrl $8,%%eax\n\t"
> +		"pushf\n\t"
> +		"pop %%ax\n\t"
>  		"andl $1,%%eax\n"
>  		:"=a"(rc)
>  		:    "a"(regs)

Looks reasonable. I can't test it as I don't have the hardware, but I
have updated the driver at:
  http://khali.linux-fr.org/devel/misc/i8k/
with the above fix. Jeff, Harry, can you test?

Thanks,
-- 
Jean Delvare

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2688.1305134105.3@kahu.w5pny.comcast.net>

-- 

Harry G. McGavran, Jr.

E-mail: w5pny@w5pny.com




------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------- =_aaaaaaaaaa0--
