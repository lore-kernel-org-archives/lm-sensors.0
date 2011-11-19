From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Sat, 19 Nov 2011 19:58:02 +0000
Subject: Re: [lm-sensors] wrong output with fam15h_power
Message-Id: <CAAek22GcN=XK11WxCB6ht52j48obPagt1fn61fztfFKxZrxQjg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321642023.1644.12.camel@tellur>
In-Reply-To: <1321642023.1644.12.camel@tellur>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

On Sat, Nov 19, 2011 at 12:50 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Fri, 18 Nov 2011 20:26:25 -0800, Phil Pokorny wrote:
>> I know that power draw
>> is increasing, because I see the temperatures rising (via k10temp
>> hacked to read fam15h temps).
>
> Which hack? The k10temp driver is supposed to already support fam15h
> CPUs (both in kernel 3.0+ and the standalone driver.)

Sure, but I'm running an older kernel, so I had to backport those updates.

Phil P.

Phil P.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
