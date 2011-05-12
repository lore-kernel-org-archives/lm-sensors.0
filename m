From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Thu, 12 May 2011 23:49:44 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110512234944.9205E1A987F@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10855.1305244184.1@kahu.w5pny.comcast.net>

I went back through the logs to make sure there was nothing
about the latest i8k in them.  Actually I found only ONE
line in syslog:

May 11 11:07:12 XX kernel: [173400.479332]  [<ffffffffa00613f2>] 
i8k_hwmon_show_fan+0x32/0x40 [i8k]

So, presumably set segfault occurs right after that....
But, maybe it's a clue for Jean or someone...

	Harry

On Thu, 12 May 2011 18:00:51 +0200 Jean Delvare wrote:

------- =_aaaaaaaaaa0
Content-Type: message/rfc822
Content-ID: <10855.1305244184.2@kahu.w5pny.comcast.net>
Content-Description: original message

Return-Path: khali@linux-fr.org
Delivery-Date: Thu, 12 May 2011 10:08:34 -0600
Return-Path: <khali@linux-fr.org>
X-Original-To: w5pny@localhost.localdomain
Delivered-To: w5pny@localhost.localdomain
Received: from kahu.w5pny.comcast.net (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with ESMTP id B09221A9865
	for <w5pny@localhost.localdomain>; Thu, 12 May 2011 10:08:34 -0600 (MDT)
X-Apparently-To: w5pny@w5pny.com via 74.6.114.38; Thu, 12 May 2011 09:02:21 -0700
X-YahooFilteredBulk: 212.85.147.21
Received-SPF: none (mta1025.biz.mail.mud.yahoo.com: domain of khali@linux-fr.org does not designate permitted sender hosts)
X-YMailISG: XpSk3fccZApIGqRdol7.I_eI9OkkbnfQv2a.P_HimnqVclE2
 .Gv2pnkqejyTCp2TXjumG9aOfGrN82cnU9gFqKwuWbI_mXMc25ltIJgNPipQ
 .0XbOXA.M1WbwuIji39KVFmqnNB2l8RqzGFn5lQEyIhm73ACOYhlowAXUMWq
 ujyFKGixVse_6QQKZ.QPZPmpYBzN6vptPkuMWpURSMl4rI9BKm1rUiNEVURg
 bFIYdz7gxGVhwhBTN7eNbMk6hIgWnuHPGQBgwg24sCYyZNLwt2Pb.D8P9m9s
 mwfKNAU_ySSMQz1bnGIzNTDcOoHchCDOxN2MGVXAURL8SVEzG6qsKpszTng0
 17RUCnzeF_2jCS8XcMgRUMB5Z98faCZj1spAGH2ATiOoF4YbP.magOyj9pzS
 xygnJ50ZJiMGS3TANVuQKEzGP4ZhK3aYUkN4bEpzLNJCVxDrAr1QYl8kfHrj
 zEx00L8PXvuFsdg_jl6qUObLbiGkjQGmwgcWTxRxIJrVZjJa4w--
X-Originating-IP: [212.85.147.21]
Authentication-Results: mta1025.biz.mail.mud.yahoo.com  from=linux-fr.org; domainkeys=neutral (no sig);  from=linux-fr.org; dkim=neutral (no sig)
Received: from pop1.biz.mail.vip.sp1.yahoo.com [69.147.84.46]
	by kahu.w5pny.comcast.net with POP3 (fetchmail-6.3.19)
	for <w5pny@localhost.localdomain> (single-drop); Thu, 12 May 2011 10:08:34 -0600 (MDT)
Received: from 127.0.0.1  (EHLO services.gcu-squad.org) (212.85.147.21)
  by mta1025.biz.mail.mud.yahoo.com with SMTP; Thu, 12 May 2011 09:02:21 -0700
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1QKZTB-0006Dq-8r
	(TLSv1:AES128-SHA:128)
	(envelope-from <khali@linux-fr.org>)
	; Thu, 12 May 2011 19:14:37 +0200
Date: Thu, 12 May 2011 18:00:51 +0200
From: Jean Delvare <khali@linux-fr.org>
To: w5pny@w5pny.com
Cc: Jeff Rickman <jrickman@myamigos.us>, Ric <fhj52rags@yahoo.com>,
 lm-sensors@lm-sensors.org, Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-ID: <20110512180051.50b1525b@endymion.delvare>
In-Reply-To: <20110512151841.B706F1A987F@localhost.localdomain>
References: <20110512154743.64d11d7b@endymion.delvare>
	<20110512151841.B706F1A987F@localhost.localdomain>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.20.1; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-filter: ifile 1.3.8 => ALSA

On Thu, 12 May 2011 09:18:41 -0600, Harry G McGavran Jr wrote:
> The latest i8k insmod's ok, but when I run /usr/bin/sensors
> after loading it I get the emc report and then the i8k report.
> Right after sensors prints the i8k line and just before
> it would give me the sensors info I get a segfault
> from something related to the app, maybe /usr/bin/sensors 
> itself, but the window where the command is typed is frozen.
> No keyboard interrupts will stop it, one has to kill the
> window to stop /usr/bin/sensors.  At that point other windows
> are still active.  There are no messages in the /var/log/messages,
> syslog, or daemon log about it.  As root if I try to rmmod i8k
> that hangs in the same way.  Ps reports that the rmmod
> is in some kind of wait state and that is not interuptable either.
> 
> A reboot is the only way to clear it up.
> 
> emc6w201 seems to depend on i2c_801 and i2c_dev which I believe

There is a soft dependency between i2c-i801 and emc6w201, in that the
former is needed for the latter to reach the monitoring device, yes.
i2c-dev isn't needed other than for sensors-detect and debugging.

> i8k does as well, so I didn't load any other modules except i8k.

i8k doesn't depend on any other kernel module.

> I had removed the Ubuntu i8kutils package as I'm no longer using i8k,
> and perhaps there is some module in that package that the i8k module
> needs -- I didn't check.  That might be the reason, but I was guessing

No, i8kutils contains a user-space helper for the i8k module, and
that's all. My changes to the i8k make it partly useless (on purpose).

> the i8k modules dependencies were the came as emc6w201's.
> There was nothing in the logs about any of this and no core file
> for whatever is segfaulting. The only error message is the "segmentation fault"
> after the /usr/bin/sensors i8k announcement line.

You can check with "ulimit -c" if a core dump will be written on
segmentation fault. But it could be that no core is written because the
problem is in i8k itself and not in the user-space application.

Unfortunately I have no idea how to investigate this further. This
makes me feel sad because Luca's findings were very promising :(

-- 
Jean Delvare

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10855.1305244184.3@kahu.w5pny.comcast.net>

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
