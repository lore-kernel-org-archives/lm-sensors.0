From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: sensors CVS updates for weekend
Message-Id: <3E6A6E86.6010405@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0302072336210.31635-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0302072336210.31635-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hey Ky?sti, what's the latest on the cleanup? would like to get things
back in order and also get something over to 2.4.21 if possible...
I'm available for testing...
thanks
mds

Ky?sti M?lkki wrote:
> I hope I get the major clean-up finished on Saturday. This involves
> going through the PCI detection routines and putting back some printk's
> with no hardware to test.
> 
> Apparantely I did introduce some compile-time problems. Some reports are
> clearly use of old kernel/i2c headers, some not so obvious and not
> reproducable to me.
> 
> 
