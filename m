From: pth@suse.de (Philipp Thomas)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: Fix for type punning in lm_sensors2
Message-Id: <20040308092204.GK28985@paradies.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040305164220.GG28985@paradies.suse.de>
In-Reply-To: <20040305164220.GG28985@paradies.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark M. Hoffman (mhoffman@lightlink.com) [20040308 05:37]:

> Hmmm... "gcc (GCC) 3.3.2 20031022 (Red Hat Linux 3.3.2-1)" doesn't
> throw any warnings about this.

Even when given -Wall?

>  What version do you use?

gcc (GCC) 3.3.2 (SuSE Linux)

The warnings from the compiler where what got me startet in the first place
because this warning is among those that will make the package fail in our
automatic build system. And instead of using -fno-strict-aliasing I decided
to fix the code instead.

> Yes that does read better.

My rule of thumb: if it needs casts it needs serious reconsideration :)
 
> I've applied it - thanks!

Thanks for applying it so quick. One patch less to maintain :)

Philipp

-- 
Philipp Thomas <pth AT suse DOT de>
SUSE LINUX AG, Maxfeldstr. 5, D-90409 Nuremberg, Germany
