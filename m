From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: National PC87372 chip driver wanted
Message-Id: <20040520094245.06ed7799.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A9074A.5060604@acetechgroup.com>
In-Reply-To: <40A9074A.5060604@acetechgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I haven't had much time to work on sensors stuff lately, but your
> offer is interesting... not least because I recognize your company
> from a couple messages to the Philly LUG and because I live relatively
> close to Exton myself.
> 
> I took a quick look at the PC87372 datasheet - that combined with Jean
> Delvare's recent work on similar NatSemi chips should make for a
> pretty straightforward driver.

Agreed. Left apart the fact that the PC87370 family chips uses 16-bit
values for fan speed measurement, which is something new (and a good
thing IMHO since it solves clock divider issues), they look rather
similar to the PC87360 family (up to 364).

There is another chip in this family: the PC87373. Looks like an
improved 372, and compatible. It has one more fan monitoring channel (3
instead of 2) and 3 PWM outputs, which means that it is functionally
equivalent to the PC87364 (as far as fan speed control and monitoring is
concerned). We would probably want to have a single driver for the
PC7370 family, much like we did for the PC87360 family.

I just added support for the PC87373 to sensors-detect, and have been
updating our "New Drivers" page as well.

One important point would be to know for which kernel Mitchell is
interested in a driver. We will probably end up in having a driver for
both the 2.4 and the 2.6 kernel, but we will have to start with either.
For information, my PC87360 family driver is for 2.4 only at the moment.

-- 
Jean Delvare
http://khali.linux-fr.org/
