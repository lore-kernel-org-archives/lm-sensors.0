From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sat, 22 Jan 2011 15:26:40 +0000
Subject: Re: [lm-sensors] 2.6.38-rc1/-2: applesmc lockdep warning
Message-Id: <20110122152640.GA3232@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110122134513.1e1d512a@stein>
In-Reply-To: <20110122134513.1e1d512a@stein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Stefan,

> since 2.6.38-rc1, the following shows up in dmesg.  Full dmesg is included
> below the signature.  This is a Macmini1,1 i.e. a first-generation
> Intel-based mini.  I haven't experienced any actual problem during usage
> but haven't used it a lot under 2.6.38-rc yet.
> 
> applesmc: key7 fan=1 temp=7 acc=0 lux=0 kbd=0
> applesmc: init_smcreg() took 50 ms
> BUG: key f4891a1c not in .data!

Ouch. I will have to get back to this tonight, but my first reaction
is that the error message tells the truth, because the sysfs nodes are
now dynamically allocated during init. Perhaps sysfs_attr_init() is
missing or something.

Thanks!
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
