From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Thu, 12 May 2011 15:18:41 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110512151841.B706F1A987F@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23613.1305213521.1@kahu.w5pny.comcast.net>

The latest i8k insmod's ok, but when I run /usr/bin/sensors
after loading it I get the emc report and then the i8k report.
Right after sensors prints the i8k line and just before
it would give me the sensors info I get a segfault
from something related to the app, maybe /usr/bin/sensors 
itself, but the window where the command is typed is frozen.
No keyboard interrupts will stop it, one has to kill the
window to stop /usr/bin/sensors.  At that point other windows
are still active.  There are no messages in the /var/log/messages,
syslog, or daemon log about it.  As root if I try to rmmod i8k
that hangs in the same way.  Ps reports that the rmmod
is in some kind of wait state and that is not interuptable either.

A reboot is the only way to clear it up.

emc6w201 seems to depend on i2c_801 and i2c_dev which I believe
i8k does as well, so I didn't load any other modules except i8k.
I had removed the Ubuntu i8kutils package as I'm no longer using i8k,
and perhaps there is some module in that package that the i8k module
needs -- I didn't check.  That might be the reason, but I was guessing
the i8k modules dependencies were the came as emc6w201's.
There was nothing in the logs about any of this and no core file
for whatever is segfaulting. The only error message is the "segmentation fault"
after the /usr/bin/sensors i8k announcement line.

	Harry

On Thu, 12 May 2011 15:47:43 +0200 Jean Delvare wrote:

------- =_aaaaaaaaaa0
Content-Type: message/rfc822
Content-ID: <23613.1305213521.2@kahu.w5pny.comcast.net>
Content-Description: original message

Return-Path: khali@linux-fr.org
Delivery-Date: Thu, 12 May 2011 09:09:04 -0600
Return-Path: <khali@linux-fr.org>
X-Original-To: w5pny@localhost.localdomain
Delivered-To: w5pny@localhost.localdomain
Received: from kahu.w5pny.comcast.net (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with ESMTP id CF7601A9865
	for <w5pny@localhost.localdomain>; Thu, 12 May 2011 09:09:04 -0600 (MDT)
X-Apparently-To: w5pny@w5pny.com via 74.6.114.33; Thu, 12 May 2011 06:48:31 -0700
X-YahooFilteredBulk: 212.85.147.21
Received-SPF: none (mta1025.biz.mail.mud.yahoo.com: domain of khali@linux-fr.org does not designate permitted sender hosts)
X-YMailISG: y0O54XMcZAoWX4ZZo6J6M2jo3E3C6X4fxENSkZp4k.Ilmtl7
 f1mZ9DAvRdmAfEKsIBlTvGXFOi8eCU69GwbMeIGHOQzJ49KCMH5St2rjrND9
 Bi24X9TMKz2yZgxxsRVC4kymwkqQ7kMyatCoQeGWWK.rrayEZPUcNejTO64N
 ERFcUxeRFeMnzssZVNakaIzB.KSJ15ijKKAF4P4RAoN1SDGqebAsTyWpWrMi
 qrTQ3OWdqZ9HieirzOqENbPXu5fA05_l34vVggBvUqA6z8USKBxlY8A_Yhcd
 3cw7ZY1WD5I8m5JSpbDxRmMrqBtZwIbYTXmQWnTXRwDFCwBJkP.MF042VKKR
 SsKRTV.AgA2EcnQYTDU37jFy8gWUxosBt2jBsVq26NnZPp.Zm7.ecm7hRwnc
 wUayxaAUNiemabnwnalA7jEN3f78Wsqtw0nBNx8EPkHg3sDixHk1EH2u0EU_
 03Lgsyeb7mgaho88UeP5yv32GuUDKkmWNwUmt23icCV_XgGtSA--
X-Originating-IP: [212.85.147.21]
Authentication-Results: mta1025.biz.mail.mud.yahoo.com  from=linux-fr.org; domainkeys=neutral (no sig);  from=linux-fr.org; dkim=neutral (no sig)
Received: from pop1.biz.mail.vip.sp1.yahoo.com [69.147.84.46]
	by kahu.w5pny.comcast.net with POP3 (fetchmail-6.3.19)
	for <w5pny@localhost.localdomain> (single-drop); Thu, 12 May 2011 09:09:04 -0600 (MDT)
Received: from 127.0.0.1  (EHLO services.gcu-squad.org) (212.85.147.21)
  by mta1025.biz.mail.mud.yahoo.com with SMTP; Thu, 12 May 2011 06:48:30 -0700
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1QKXNg-0008H2-9D
	(TLSv1:AES128-SHA:128)
	(envelope-from <khali@linux-fr.org>)
	; Thu, 12 May 2011 17:00:48 +0200
Date: Thu, 12 May 2011 15:47:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: w5pny@w5pny.com
Cc: Jeff Rickman <jrickman@myamigos.us>, Ric <fhj52rags@yahoo.com>,
 lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-ID: <20110512154743.64d11d7b@endymion.delvare>
In-Reply-To: <20110511171506.076881A987F@localhost.localdomain>
References: <20110511170817.08d8a203@endymion.delvare>
	<20110511171506.076881A987F@localhost.localdomain>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.20.1; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Harry,

On Wed, 11 May 2011 11:15:05 -0600, Harry G McGavran Jr wrote:
> This new i8k crashes on my machine, the old one does not.

This is bad news. Can you tell us more? Maybe a backtrace in the logs
when the crash happens? The full error message would be useful.

-- 
Jean Delvare

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23613.1305213521.3@kahu.w5pny.comcast.net>

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
