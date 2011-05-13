From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Fri, 13 May 2011 17:28:49 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110513172849.625881A987F@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18804.1305307729.1@kahu.w5pny.comcast.net>

Yes, I just did "insmod i8k.ko" without any options.

BTW, you had said in an earlier e-mail that you though
I'd have to pass force=1 or ignore_dmi=1 to get i8k to
load, but I never needed either of these.

This i8k seems to work fine, but the emc6w201 driver
does what I really need (almost) much much better.

Thanks again!

	Harry

On Fri, 13 May 2011 18:44:10 +0200 Jean Delvare wrote:

------- =_aaaaaaaaaa0
Content-Type: message/rfc822
Content-ID: <18804.1305307729.2@kahu.w5pny.comcast.net>
Content-Description: original message

Return-Path: khali@linux-fr.org
Delivery-Date: Fri, 13 May 2011 11:19:14 -0600
Return-Path: <khali@linux-fr.org>
X-Original-To: w5pny@localhost.localdomain
Delivered-To: w5pny@localhost.localdomain
Received: from kahu.w5pny.comcast.net (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with ESMTP id 0E5DF1A9865
	for <w5pny@localhost.localdomain>; Fri, 13 May 2011 11:19:14 -0600 (MDT)
X-Apparently-To: w5pny@w5pny.com via 74.6.114.37; Fri, 13 May 2011 09:45:42 -0700
X-YahooFilteredBulk: 212.85.147.21
Received-SPF: none (mta1023.biz.mail.mud.yahoo.com: domain of khali@linux-fr.org does not designate permitted sender hosts)
X-YMailISG: sZ57BdgcZAoIoMgKiWcH_HMrPXp8jnf_mWHlnzzcYoIw1CDg
 3X2KVhWKpm1rJfVDKTFY6AVkpDW7LsoXe6KcobbNyAvlS7fY18y8L8yMpwLj
 nnsNcBysS4qGBDrUuwHOD57nwy_.3q.VqMCouZjYeLs5.LxnlZePkxb364SK
 N2weMoKAR2.rCEt8CCS8eYqwMnP8t2BgnPtsiOzRfDQW0efcf5r_ivqyAP0x
 kwanBF7rYlb7iDXbq9XcTyUtTSY.mxdoQtL4s_4ewng.mMuXRO35fldsJpje
 Fi_tcAb62qSUkWtmBJUUzZpXGywQL2iBSpfj7KHZ.3r8MHM7O1qa3ihw4DYB
 R.JJdkrhxNjVKS5QNX8eKjuXoszE87MZ7h.G8hV9CGnN0wnng5BvXhl4Pr1r
 UGBYQ4fixQFY3S.cD.GRvLwJx9aYJoybkPP8q64XzLGryL_uxmnNLz4kVH7.
 RRGiCJgbaZywJsvFjU6SMswZwwXiXAOieJH.h2jLx5j.iso5nQ--
X-Originating-IP: [212.85.147.21]
Authentication-Results: mta1023.biz.mail.mud.yahoo.com  from=linux-fr.org; domainkeys=neutral (no sig);  from=linux-fr.org; dkim=neutral (no sig)
Received: from pop1.biz.mail.vip.ne1.yahoo.com [98.138.82.28]
	by kahu.w5pny.comcast.net with POP3 (fetchmail-6.3.19)
	for <w5pny@localhost.localdomain> (single-drop); Fri, 13 May 2011 11:19:14 -0600 (MDT)
Received: from 127.0.0.1  (EHLO services.gcu-squad.org) (212.85.147.21)
  by mta1023.biz.mail.mud.yahoo.com with SMTP; Fri, 13 May 2011 09:45:41 -0700
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1QKwcf-0004DI-I1
	(TLSv1:AES128-SHA:128)
	(envelope-from <khali@linux-fr.org>)
	; Fri, 13 May 2011 19:57:57 +0200
Date: Fri, 13 May 2011 18:44:10 +0200
From: Jean Delvare <khali@linux-fr.org>
To: w5pny@w5pny.com
Cc: Jeff Rickman <jrickman@myamigos.us>, Ric <fhj52rags@yahoo.com>,
 lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-ID: <20110513184410.1b60d368@endymion.delvare>
In-Reply-To: <20110513154228.89DA01A987F@localhost.localdomain>
References: <20110513170130.70957eec@endymion.delvare>
	<20110513154228.89DA01A987F@localhost.localdomain>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.20.1; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-filter: ifile 1.3.8 => Dell670

On Fri, 13 May 2011 09:42:28 -0600, Harry G McGavran Jr wrote:
> This new i8k seems to work on my system. 
> 
> ====================> 
> XX% /usr/bin/sensors
> i8k-virtual-0
> Adapter: Virtual device
> Left Fan:   64650 RPM
> Right Fan:  48390 RPM

As said before, you'd need option fan_mult=1 to get proper readings.
But well, in the long run I guess you'll stop using i8k anyway, as it
provides fewer values than the emc6w201 driver.

> emc6w201-i2c-0-2e
> Adapter: SMBus I801 adapter at e8a0
> Aux:            +1.82 V  (min =  +1.64 V, max =  +1.98 V)
> CPU VCore:      +1.26 V  (min =  +0.78 V, max =  +1.70 V)
> +3.3V:          +3.33 V  (min =  +3.08 V, max =  +3.52 V)
> +5V:            +5.10 V  (min =  +4.66 V, max =  +5.34 V)
> +12V:          +12.06 V  (min =  +0.81 V, max = +12.81 V)
> Chassis:       1613 RPM  (min =  300 RPM)
> CPU:           2153 RPM  (min =  200 RPM)
> CPU:            +54.0 C  (low  = -127.0 C, high = +88.0 C)  
> Remote Diode 5: +48.0 C  (low  = -127.0 C, high = +75.0 C)  
> Mainboard:      +44.0 C  (low  = -127.0 C, high = +80.0 C)  
> 
> =======================> 
> The only entry in syslog as a result of the above is:
> 
> May 13 09:37:40 kahu kernel: [167232.194108] i8k: unable to get SMM BIOS 
> version
> 
> but that has occurred with all the i8k's I've tried.

Looks very promising. Now let's wait for Jeff's report.

-- 
Jean Delvare

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18804.1305307729.3@kahu.w5pny.comcast.net>

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
