From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Fri, 13 May 2011 15:42:28 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110513154228.89DA01A987F@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13666.1305301348.1@kahu.w5pny.comcast.net>

This new i8k seems to work on my system. 

====================
XX% /usr/bin/sensors
i8k-virtual-0
Adapter: Virtual device
Left Fan:   64650 RPM
Right Fan:  48390 RPM

emc6w201-i2c-0-2e
Adapter: SMBus I801 adapter at e8a0
Aux:            +1.82 V  (min =  +1.64 V, max =  +1.98 V)
CPU VCore:      +1.26 V  (min =  +0.78 V, max =  +1.70 V)
+3.3V:          +3.33 V  (min =  +3.08 V, max =  +3.52 V)
+5V:            +5.10 V  (min =  +4.66 V, max =  +5.34 V)
+12V:          +12.06 V  (min =  +0.81 V, max = +12.81 V)
Chassis:       1613 RPM  (min =  300 RPM)
CPU:           2153 RPM  (min =  200 RPM)
CPU:            +54.0 C  (low  = -127.0 C, high = +88.0 C)  
Remote Diode 5: +48.0 C  (low  = -127.0 C, high = +75.0 C)  
Mainboard:      +44.0 C  (low  = -127.0 C, high = +80.0 C)  

=======================
The only entry in syslog as a result of the above is:

May 13 09:37:40 kahu kernel: [167232.194108] i8k: unable to get SMM BIOS 
version

but that has occurred with all the i8k's I've tried.

	Harry

On Fri, 13 May 2011 17:01:30 +0200 Jean Delvare wrote:

------- =_aaaaaaaaaa0
Content-Type: message/rfc822
Content-ID: <13666.1305301348.2@kahu.w5pny.comcast.net>
Content-Description: original message

Return-Path: khali@linux-fr.org
Delivery-Date: Fri, 13 May 2011 09:16:48 -0600
Return-Path: <khali@linux-fr.org>
X-Original-To: w5pny@localhost.localdomain
Delivered-To: w5pny@localhost.localdomain
Received: from kahu.w5pny.comcast.net (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with ESMTP id 0D6BC1A9880
	for <w5pny@localhost.localdomain>; Fri, 13 May 2011 09:16:48 -0600 (MDT)
X-Apparently-To: w5pny@w5pny.com via 74.6.114.33; Fri, 13 May 2011 08:03:00 -0700
X-YahooFilteredBulk: 212.85.147.21
Received-SPF: none (mta1009.biz.mail.mud.yahoo.com: domain of khali@linux-fr.org does not designate permitted sender hosts)
X-YMailISG: AkPoQkocZArspGm3vSjnya9_4oRE7pbyKXdy1uEFoY.W2Hw2
 pbslEzOv9IVATq7YtWGPhF2wv7WY0WouJwP18d8kJZh4Km.CFBCW0OJlHEMC
 0S5p7_enWWOfACf.1PTlQ9EtvF4dRtBFQ5hwMNi6hsGxfDMGX3A56Oq7zn17
 1yEUFiIv4l.Wp.c4Uuo7TZXVkMCkaepU2j14tTq5n5Xg09jag.Tfe0F_f4lb
 nmSWqjAOTQfwztbq_rHQ2iEUGyksmB68sirIl.mXVJAJSfGcEy4AjZGq9R49
 06YpVfKU4rekKPRv02p39RJdnnypA7Rmx.sk2pn52hm4Zq15Pfh3FWrd2Nah
 U81PJECAw8UDQOQh.hpDxGjwHuXuJRbb4oclUd__KltqE9C6Tn88g.SqJZBL
 9_tB1QoLMHWIK1Tc4OtkRyRfsqKSiuOGZuK6pbxofN0UcHRCTcFv_KYHGRyA
 Sa61.sjUGn8l33Br5VJMkUi.GHBMPdj1E3gC5y4bwXRFTRQn3dWyVuZmwAAp
 ifTrZ0iGEvXyzTX2h6Gzt7VkfkS0
X-Originating-IP: [212.85.147.21]
Authentication-Results: mta1009.biz.mail.mud.yahoo.com  from=linux-fr.org; domainkeys=neutral (no sig);  from=linux-fr.org; dkim=neutral (no sig)
Received: from pop1.biz.mail.vip.ne1.yahoo.com [98.138.82.28]
	by kahu.w5pny.comcast.net with POP3 (fetchmail-6.3.19)
	for <w5pny@localhost.localdomain> (single-drop); Fri, 13 May 2011 09:16:48 -0600 (MDT)
Received: from 127.0.0.1  (EHLO services.gcu-squad.org) (212.85.147.21)
  by mta1009.biz.mail.mud.yahoo.com with SMTP; Fri, 13 May 2011 08:03:00 -0700
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1QKv1J-0005iS-L0
	(TLSv1:AES128-SHA:128)
	(envelope-from <khali@linux-fr.org>)
	; Fri, 13 May 2011 18:15:17 +0200
Date: Fri, 13 May 2011 17:01:30 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Harry G McGavran Jr <w5pny@w5pny.com>, Jeff Rickman
 <jrickman@myamigos.us>, Ric <fhj52rags@yahoo.com>,
 lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-ID: <20110513170130.70957eec@endymion.delvare>
In-Reply-To: <20110513124726.GA20870@nb-core2.darkstar.lan>
References: <20110512180051.50b1525b@endymion.delvare>
	<20110512234944.9205E1A987F@localhost.localdomain>
	<20110513124726.GA20870@nb-core2.darkstar.lan>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.20.1; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-filter: ifile 1.3.8 => Dell670

On Fri, 13 May 2011 14:48:01 +0200, Luca Tettamanti wrote:
> On Thu, May 12, 2011 at 05:49:44PM -0600, Harry G McGavran Jr wrote:
> > I went back through the logs to make sure there was nothing
> > about the latest i8k in them.  Actually I found only ONE
> > line in syslog:
> > 
> > May 11 11:07:12 XX kernel: [173400.479332]  [<ffffffffa00613f2>] 
> > i8k_hwmon_show_fan+0x32/0x40 [i8k]
> 
> Ok, this is consistent with the hung program reported by Jeff, there's
> an error at kernel level while the sensor is being read.
> 
> AMD64 Architecture Manual says that:
> 
>  (pushf) In 64-bit mode, this instruction defaults to a 64-bit operand
>  size and there is no prefix available to encode a 32-bit operand size.

D'oh. I suspected something like this, but given that pushfq exists, I
assumed pushf had to be different. I guess I shouldn't have assumed...

> 
> so my patch may be corrupting the stack. Lets try like this:
> 
> diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
> index d72433f..ee01716 100644
> --- a/drivers/char/i8k.c
> +++ b/drivers/char/i8k.c
> @@ -139,8 +139,8 @@ static int i8k_smm(struct smm_regs *regs)
>  		"movl %%edi,20(%%rax)\n\t"
>  		"popq %%rdx\n\t"
>  		"movl %%edx,0(%%rax)\n\t"
> -		"lahf\n\t"
> -		"shrl $8,%%eax\n\t"
> +		"pushfq\n\t"
> +		"popq %%rax\n\t"
>  		"andl $1,%%eax\n"
>  		:"=a"(rc)
>  		:    "a"(regs)
> 
> 
> If it still doesn't work we should involve someone who actually has a
> clue about x86 asm ;)

Hopefully it will work OK this time. I've updated the driver at:
  http://khali.linux-fr.org/devel/misc/i8k/
Harry, Jeff, care to try again? Thanks.

-- 
Jean Delvare

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13666.1305301348.3@kahu.w5pny.comcast.net>

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
