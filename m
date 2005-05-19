From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors/i2c 2.8.2
Message-Id: <20040104171808.14a79143.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040104141910.64b647a2.khali@linux-fr.org>
In-Reply-To: <20040104141910.64b647a2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > And in fact I could even update my 2.4.21 patch from 2.8.0 to 2.8.2.
> > I though nobody would be interested in it, but obviously you, at
> > least, are. I want to have a new patch for 2.4.24-preX anyway, so
> > I'll some work on the web page and files soon.
> 
> OK, I'll wait for the 2.4.21 patch, that should apply better to RH's
> 2.4.20. FC1 is not the preferred distro for serious and stable server
> monitoring that lm_sensors targets, so most people would like to see
> it in RH9/RH7.3 (which is 2.4.20 with some 21-pre patches applied).

Done! Please give it a try and tell me how it goes.

> Also if 2.8.3/2.9.0 keep i2c 2.8.2 compatibility, I will be able to
> supply new kernel module rpms for lm_sensors/i2c w/o rebuilding the
> kernel. :)

Yes, it should be compatible. It should be released as 2.8.3 at the
time Linux 2.6.1 is released.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
