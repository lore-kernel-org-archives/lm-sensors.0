From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Fri, 13 May 2011 19:47:13 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110513194713.30E4C1A987F@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26415.1305316033.1@kahu.w5pny.comcast.net>

I'm certainly not a wiz on device drivers, but could it be
that the N/A's Jeff is getting have something to do with
that fact the he has to do the "force" insmod option to avoid
"no such device" errors.

	Harry



On Fri, 13 May 2011 21:36:17 +0200 Jean Delvare wrote:

------- =_aaaaaaaaaa0
Content-Type: message/rfc822
Content-ID: <26415.1305316033.2@kahu.w5pny.comcast.net>
Content-Description: original message

Return-Path: khali@linux-fr.org
Delivery-Date: Fri, 13 May 2011 13:45:05 -0600
Return-Path: <khali@linux-fr.org>
X-Original-To: w5pny@localhost.localdomain
Delivered-To: w5pny@localhost.localdomain
Received: from kahu.w5pny.comcast.net (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with ESMTP id D7AB41A9865
	for <w5pny@localhost.localdomain>; Fri, 13 May 2011 13:45:05 -0600 (MDT)
X-Apparently-To: w5pny@w5pny.com via 74.6.114.48; Fri, 13 May 2011 12:37:48 -0700
X-YahooFilteredBulk: 212.85.147.21
Received-SPF: none (mta1006.biz.mail.mud.yahoo.com: domain of khali@linux-fr.org does not designate permitted sender hosts)
X-YMailISG: VxcVmJIcZAo3rMyxv4sVfGvBV8IFFOp9zfpQBc2SNKfNCws3
 uLcYIUhG.D9XXBwNPXHkI0dXjY6108NrBvE5oKQ4qlj02ll4tBsfJbPlp21Z
 tSmG1XwTlMCZRqnaZkNoDqqoE_4pqRMUL5bMq3JukhrVkvrtDsI4xeKJGSaF
 PvoOP8pp9NobJPlD7k2kV7y9mJb84wFNWi0uv90VQh2PaJ5Hbdu1ZiNdHH7g
 NToeYXsy4UdFofheKV4zHb4uDwqMJe4YCVLUNWbXVp7AdVfxWo_GVCnZo4HS
 I3tvTC8zGM3uEwL.UYttbjK50d_7bmkPktLIakoouhjQ2yBdijqnul6fzQ50
 56auRU0bDEwdHi.KoumO7WOIkAqyy62rS.mxsQEpTIrncDZGxbp8fDM1iGzJ
 531A_GZi4CTbFIJ0DHcuobVsC1dw2b4xLUnFNVf8oqxmlZ.JeaxfMW81WDX9
 RnYkN1KH9Ljzr8zRbnpwlGVQFnqep0SKPL0ry98zEd0DdU2rHA--
X-Originating-IP: [212.85.147.21]
Authentication-Results: mta1006.biz.mail.mud.yahoo.com  from=linux-fr.org; domainkeys=neutral (no sig);  from=linux-fr.org; dkim=neutral (no sig)
Received: from pop1.biz.mail.vip.bf1.yahoo.com [98.139.210.98]
	by kahu.w5pny.comcast.net with POP3 (fetchmail-6.3.19)
	for <w5pny@localhost.localdomain> (single-drop); Fri, 13 May 2011 13:45:05 -0600 (MDT)
Received: from 127.0.0.1  (EHLO services.gcu-squad.org) (212.85.147.21)
  by mta1006.biz.mail.mud.yahoo.com with SMTP; Fri, 13 May 2011 12:37:48 -0700
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1QKzJF-0005Jb-77
	(TLSv1:AES128-SHA:128)
	(envelope-from <khali@linux-fr.org>)
	; Fri, 13 May 2011 22:50:05 +0200
Date: Fri, 13 May 2011 21:36:17 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jeff Rickman <jrickman@myamigos.us>
Cc: w5pny@w5pny.com, Ric <fhj52rags@yahoo.com>, lm-sensors@lm-sensors.org,
 Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-ID: <20110513213617.5bfac5b5@endymion.delvare>
In-Reply-To: <4DCD6E9B.7020700@myamigos.us>
References: <20110513170130.70957eec@endymion.delvare>
	<20110513154228.89DA01A987F@localhost.localdomain>
	<20110513184410.1b60d368@endymion.delvare>
	<4DCD6E9B.7020700@myamigos.us>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.20.1; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-filter: ifile 1.3.8 => Dell670

Hi Jeff,

On Fri, 13 May 2011 12:47:07 -0500, Jeff Rickman wrote:
> On 5/13/2011 11:44 AM, Jean Delvare wrote:
> > Looks very promising. Now let's wait for Jeff's report.
> 
> I have promising results; no crash messages. "sensors" out that shows 
> N/A. See attached.
> 
> I still need to use the "force" option or else I get the "no such 
> device" error message. See attached.

That's good enough as far as I'm concerned. The driver wasn't written
for this machine, it happens to work on Harry's, good for him, but as
long as the driver doesn't crash, that's fine with me. If you see N/A
in the output of "sensors" because the driver doesn't get any value
from the BIOS (cat /proc/i8k will certainly return many -22s.) Why it
works on Harry's machine and not on yours while they seem pretty
similar is certainly strange, but that's out of scope for me.

So, thanks Jeff and Harry for the testing on i8k, at least the assembly
code problem is solved. Luca, are you going to make a proper
submission, or should I handle it? I don't want to steal the credit
from you.

-- 
Jean Delvare

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26415.1305316033.3@kahu.w5pny.comcast.net>

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
