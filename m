From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Nov 2008 09:31:55 +0000
Subject: Re: [lm-sensors] a problem with lm-sensor 2.10.7.
Message-Id: <20081111103155.36b8a5bd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU118-W44880F25FDEF937C07D991A21A0@phx.gbl>
In-Reply-To: <BLU118-W44880F25FDEF937C07D991A21A0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sergio,

On Mon, 10 Nov 2008 19:20:05 +0100, Sergio Gutierrez Verde wrote:
> I have a problem using a function of lm-sensors 2.10.7.
> 
> In the next extract of code I try to get the CPU TEMP of a
> certain chip. But when  'sensors_get_feature' is called,
> there is a problem, a Segmentation fault.
> I also try to use the most part of the code of lm-sensors
> 2.10.7 (like main.c, chips.c and so on), but the problem persists.
> The chip and the sensors are the right.

If I can allow myself a side comment, writing code for libsensors 2.x
today is a bit odd. The libsensors 3.x API is perfectly stable by now
and it is much better than 2.x so you should really use 3.x for new
applications.

> Could anyone find the wrong in my code?

Did you try building it with -Wall -W? In many cases it is sufficient
to point you to the problematic code.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
