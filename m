From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Sis 645DX problem
Message-Id: <20030322233349.3d7b4483.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200303161357.19874.contact@haloscan.com>
In-Reply-To: <200303161357.19874.contact@haloscan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


*** PLEASE REPLY TO THE LIST, NOT TO ME ONLY ***

> Thanks for responding!
> 
> Yes, the motherboard is relatively new. Here is the manufacturer's
> site: http://www.asus.com.tw/mb/socket478/p4s533-e/overview.htm
> (...)
> lspci -n shows:
> -------------------------------
> bash-2.05b# lspci -n
> 00:00.0 Class 0600: 1039:0646
> 00:01.0 Class 0604: 1039:0001
> 00:02.0 Class 0601: 1039:0962 (rev 04)
> (...)

OK, support has been added by Mark M. Hoffman in January and is
available in CVS. So you'll have to try the CVS version to get
lm_sensors to work on your motherboard. Beware that the CVS is a bit
unstable nowadays, so you may have to insist to get it to work. That's
the only solution we have to offer though.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
