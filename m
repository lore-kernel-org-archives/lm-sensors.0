From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jun 2007 19:39:30 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <20070614213930.261b2a78@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chistian,

On Tue, 12 Jun 2007 19:29:42 +0200 (CEST), Christian Emmerich wrote:
> Now to my problem, I'm using an AOpen XC Cube (ex18), sensors-detect
> shows that a have to use the module f75375s, i install it using the
> driver developed by Riku Voipio, posted may 22. 
> Using w83627hf don't show any fan-speed or temperature, voltage seems
> to be ok.
> 
> I try to integrate the driver in lm-sensors, but now i'm confused how
> to get lm-sensors (svn- version) working with this chip. Could someone
> give me a hint. Maybe somone else is testing it too and could send me
> his version of lm-sensors or could publish his configuration/files.
> 
> It would also be helpfull if somone only gives an example of an driver
> which is similar to f75375s.
> 
> Is it correct that i have to update lib/chips.c, lib/chips.h and
> prog/sensors/chip.h, prog/sensors/chip.c and prog/sensors/main.c? What
> functions are needed and so on.

Yes, this is correct.

> The module is recognized by 'sensors-detect' but i'm not able to get
> an output running 'sensors', because the needed functions, structs and
> defines are mostly not correct.

I suggest that you take a look at a patch doing the same for another
driver:

http://www.lm-sensors.org/changeset/4355

This patch was adding user-space support for the dme1737 driver. You
need to do something very similar, except for sensors-detect which you
probably don't need to change.

If you have specific questions on the way, feel free to ask, but all in
all, copy and paste and a bit of trial and error should work fine.

Please submit your patch when you're done, so that we can apply it and
everybody benefits.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
