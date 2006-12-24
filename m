From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Dec 2006 13:27:22 +0000
Subject: [lm-sensors] Andigilog aSC7621 & Intel D975XBX2 Motherboard
Message-Id: <20061224142722.8544b801.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061223234012.GA5410@seahunt.dyndns.org>
In-Reply-To: <20061223234012.GA5410@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi George,

On Sat, 23 Dec 2006 17:44:49 -0700, George T. Joseph \(development\) wrote:
> >So... is someone working on a driver for this chip...
> 
> Yep.  I am.  Here's the patch for the kernel.  I was waiting for Jean to
> review it before doing the lm_sensors bit but since the Bad Axe 2 is
> becoming more popular maybe I'll just do the lm_sensors now and update
> it after the review.

I am not the only person on earth who can review your driver, and I am
(as usual) very busy. I am currently working a lot on i2c driver core
cleanups and evolutions which are long overdue, I can't review
individual drivers at the same time, I just don't have the time and
energy.

Having user-space support for your driver will make testing easier, so
I invite you to add this support to lm_sensors SVN and post the patch
on this list.

> Anyway, apply the patch to a 2.6.18 or greater kernel.  Sensors-detect
> won't find the driver but you can add a MODULE line to
> /etc/sysconfig/lm_sensors manually.

-- 
Jean Delvare

