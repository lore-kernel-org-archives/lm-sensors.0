From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 26 Jul 2007 11:39:58 +0000
Subject: Re: [lm-sensors] dme1737 very slow read...
Message-Id: <20070726113958.GI3796@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A8157E.7040003@sandeen.net>
In-Reply-To: <46A8157E.7040003@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Juerg Haefliger <juergh@gmail.com> [2007-07-25 22:39:40 -0700]:
> > >> 1.53 seconds to read "0\n" !  :)
> > >>
> > >> Any idea if this is a hardware or software delay?  I haven't yet dug
> > >> into profiling the kernel code to see what might be taking so long...
> > >
> > > It's simple: We have to read a lot of registers which we can only get
> > > to via I2C which is veeerrrrryyyyy sloooooowwwwww.

Max rate for standard I2C/SMBus is 100KHz.  However, the hardware which is
most common on PCs usually runs at something like 10KHz.

> > Ok, I thought it might be along those lines.  Is there any other
> > performance impact to the system while it's waiting for the I2C bus?
> 
> Good question, I don't know. That's more a question for the I2C
> mailing list. Jean?

It depends on the specific I2C bus driver.  All of the most common ones use
polling, so unfortunately you will see CPU % go to 100 during that 1.5 sec.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
