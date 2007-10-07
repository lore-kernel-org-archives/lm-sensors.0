From: Jan Richling <jan@richling.de>
Date: Sun, 07 Oct 2007 17:10:05 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp driver and Celeron 430 - works
Message-Id: <470912ED.3040301@richling.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4708C611.5040808@assembler.cz>
In-Reply-To: <4708C611.5040808@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> Cool thanks. Please note that the temperature might be more non-physical. So in
> your case you have still 55C to overheat. The processor reports temp relative to
> trip point, which is "100C" in your case. If it is 85C or 100C works fine on
> mobile variants, should not on desktop CPUs.
> 
> To sum it up. Even if your temperature is not a real one, you have still 55C to
> critical level.

I know... I did a kind of "test" of this. Running burnP6 with overclock
to 3 GHz and the stock cooler triggered auto shutdown of the CPU in less
than 30 seconds. Now I have a Pentium D820 boxed cooler and the core
goes up to 69 which is still 31 below the critical level.

Regarding the patch - I guess you can add 0x17 soon. This is the new
Penryn core Intel will bring to market in november. Question is only if
there is somebody to test.

Greetings,

Jan

   ------------------------------------------------------------------
  / Dr. Jan Richling - http://www.richling.de                      /
 / Member of Computer Architecture and Communication Group -      /
/ Department of Computer Science - Humboldt University Berlin    /

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
