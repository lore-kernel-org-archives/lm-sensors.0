From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Ticket #: 1659   it87: it8712f module stops working
Message-Id: <20040427225213.2f535d70.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083021688.1553.27.camel@localhost>
In-Reply-To: <1083021688.1553.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i've confirmed that i can reload the module all i want prior to when
> it craps the bed.  

OK, that's what I thought.

> i've also been logging sensors output, and time and it appears to
> always stop working at 10 mins of uptime.   but i've only rebooted
> twice, which is the only way to get the chip back...
> 
> i'm going to rewrite my script now so it logs the number of calls to
> sensors, finer granularity of time ellapsed, and system state.  i'll
> also turn on debug in lm-sensors.

Yes, good idea. I don't have any idea as to why the problem occurs.
Nobody else reported the problem so far.

> any other suggestions?

You may want to see if there could be a conflict with other
drivers/devices, especially with those who use the ISA addressing space.
I invite you to try a light kernel with as few drivers as possible, and
see if the problem still occurs.

Since I don't have much idea, the more information you can gather, the
better, of course.

Good luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
