From: benthos@lqjr.qc.ca (Benjamin Lawetz)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: sensors works, but no RAW
Message-Id: <Pine.LNX.4.58.0406062144090.11322@benthos.lqjr.qc.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0405241630260.8743@benthos.lqjr.qc.ca>
In-Reply-To: <Pine.LNX.4.58.0405241630260.8743@benthos.lqjr.qc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You did not forget anything, it was removed, or more precisely it was
> replaced. The kernel/user-space interface is now under sysfs. Take a
> look at /sys/bus/i2c/devices, everything is there.

Yup, after 2 days, I just needed to send you an e-mail to find the answer 
myself 5 minutes later :-)

Thanks.

> So your scripts definitely need to be updated to support the new
> interface.

Is there anyone working on the tellerstats scripts? Or should I send you 
what I do if it's half-decent ?

> > I tried runnig sensors-detect see if maybe some things had changed.
> > sensors-detect came up with the smsc47m1 driver instead of the 
> > as99127f like it used to in 2.4.
> 
> This surprises me. These are completely different chips, it isn't
> possible to misdetect one as the other.
> 
> The SMSC chip is a Super-I/O chip which has fans monitoring and control
> capabilities. These capabilities may or may not be used on your
> motherboard. The driver hasn't been ported to Linux 2.6 yet (although
> Gabriele Gorla is working on it).
> 
> If sensors-detect doesn't detect your Asus chip, this needs fixing. I'd
> need a dump of the chip (using i2cdump) for this.

I now have a monolithic kernel, but I'll try to reproduce it (and give you 
a better description and the dump with the old kernel soon).

Thanks for your work

-- 
      \\\|///
    \\  - -  //
     (  @ @  )
---oOOo-(_)-oOOo-------------------------------
Any road followed to its end leads precisely nowhere.
Climb the mountain just a little to test it's a mountain.
From the top of the mountain, you cannot see the mountain.
		-- Bene Gesserit proverb, "Dune"
--------------Oooo-----------------------------
     oooO    (   )   Benjamin Benthos Lawetz
     (  )     ) /    mailto:Benjamin.Lawetz@lqjr.qc.ca
      \ (    (_/     ICQ# 4269530
       \_)
