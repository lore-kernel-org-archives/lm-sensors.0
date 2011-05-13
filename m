From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Fri, 13 May 2011 22:55:16 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110513225516.2998D1A987F@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2562.1305327316.1@kahu.w5pny.comcast.net>

What I was getting at was the "device" that was not found
might be the same device that fan data was obtained from.
It just seemed like a good hunch based of the fact that
the fan tachometer is a "device" and the module isn't
finding a "device." Granted there is no reason for the
"devices" to be the same.  Coincidences are not all that
common so it was a guess. 

	Harry McGavran


On Fri, 13 May 2011 23:10:51 +0200 Jean Delvare wrote:

------- =_aaaaaaaaaa0
Content-Type: message/rfc822
Content-ID: <2562.1305327316.2@kahu.w5pny.comcast.net>
Content-Description: original message

Return-Path: khali@linux-fr.org
Delivery-Date: Fri, 13 May 2011 16:50:45 -0600
Return-Path: <khali@linux-fr.org>
X-Original-To: w5pny@localhost.localdomain
Delivered-To: w5pny@localhost.localdomain
Received: from kahu.w5pny.comcast.net (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with ESMTP id C24F51A987F
	for <w5pny@localhost.localdomain>; Fri, 13 May 2011 16:50:45 -0600 (MDT)
X-Apparently-To: w5pny@w5pny.com via 74.6.114.38; Fri, 13 May 2011 14:12:20 -0700
X-YahooFilteredBulk: 212.85.147.21
Received-SPF: none (mta1009.biz.mail.mud.yahoo.com: domain of khali@linux-fr.org does not designate permitted sender hosts)
X-YMailISG: iBF4R2IcZAon2SOiKCUTMGMJaCcyaj2iYoIb2cYcMBdXCK_4
 cEiCvp6vSKemuuvmR0DQFZOcKPKsbjyApPC4eyZJyKvDRg_S5QszM0._GmES
 1Vkzrf3UVkMrfQRPpVtOj8spsrjIXpqH_u_ri9WVzctpJf4BJoUXYIXOOVFQ
 RrjmR7U5gLWu_lsIUk0xXJjw_YCeG7MCdR.dgTgJsOR6U.oXGzh.D0T5c2JX
 6JfhWMUcRHRe10G0MAtK4cW5JWBVnOSwzilP.3oxirhsx.gKg5GqHDJlGdyK
 d7UbRgmEhsyA7qr5sro8yrlu2t4FLZ.JxsJVW.mVtvkK90ZOPgouk5BxZMVb
 UeNWsXP8ByYyKWVuDVS5B.h9.JbRmC95b6qobhHTogTKMEeHnS0s3eTG.VGJ
 FHfAjo2I.Skqb_H5KeRdzXC2mRBeWzNfXC.Nn5xnCkARm0UreTlTrTKf0KCD
 p7i75bxyaHwk8B2CYMbAwVj2TiN4haXp7arTxvmBGxPlpUsK6A--
X-Originating-IP: [212.85.147.21]
Authentication-Results: mta1009.biz.mail.mud.yahoo.com  from=linux-fr.org; domainkeys=neutral (no sig);  from=linux-fr.org; dkim=neutral (no sig)
Received: from pop1.biz.mail.vip.bf1.yahoo.com [98.139.210.98]
	by kahu.w5pny.comcast.net with POP3 (fetchmail-6.3.19)
	for <w5pny@localhost.localdomain> (single-drop); Fri, 13 May 2011 16:50:45 -0600 (MDT)
Received: from 127.0.0.1  (EHLO services.gcu-squad.org) (212.85.147.21)
  by mta1009.biz.mail.mud.yahoo.com with SMTP; Fri, 13 May 2011 14:12:20 -0700
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1QL0mk-00036d-By
	(TLSv1:AES128-SHA:128)
	(envelope-from <khali@linux-fr.org>)
	; Sat, 14 May 2011 00:24:38 +0200
Date: Fri, 13 May 2011 23:10:51 +0200
From: Jean Delvare <khali@linux-fr.org>
To: w5pny@w5pny.com
Cc: Ric <fhj52rags@yahoo.com>, lm-sensors@lm-sensors.org, Luca Tettamanti
 <kronos.it@gmail.com>
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-ID: <20110513231051.29c767a7@endymion.delvare>
In-Reply-To: <20110513194713.30E4C1A987F@localhost.localdomain>
References: <20110513213617.5bfac5b5@endymion.delvare>
	<20110513194713.30E4C1A987F@localhost.localdomain>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.20.1; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-filter: ifile 1.3.8 => inbox

On Fri, 13 May 2011 13:47:13 -0600, Harry G McGavran Jr wrote:
> I'm certainly not a wiz on device drivers, but could it be
> that the N/A's Jeff is getting have something to do with
> that fact the he has to do the "force" insmod option to avoid
> "no such device" errors.

Yes Harry this is certainly related. But I have no idea why he needs
the force and you don't.

-- 
Jean Delvare

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2562.1305327316.3@kahu.w5pny.comcast.net>

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
