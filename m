From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: module reference counting
Message-Id: <200406160801.i5G81UlJ013796@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040616051054.GC2556@jupiter.solarsys.private>
In-Reply-To: <20040616051054.GC2556@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

>I've been studying the i2c-core in CVS and 2.4.26 to try to understand
>the module reference counting mechanism.

Thanks for looking into this. I really believe that we need to fix this
problem now, and the sooner, the better.

>One thing I'm not sure about is this patch from your web page.  Why did
>you strike the MOD_xxx_USE_COUNT calls there?  They look necessary to
>keep the module loaded while there's a live kernel thread.
>
>It's very possible I'm missing something though.

You better not assume that I new what I was doing back then. I had to
"fix" two dozen drivers at once with absolutely no knowledge of
neither kernel programming nor i2c subsystem internals. I started from
Mark Studebaker's recommadations as seen there:
http://archives.andrew.net.au/lm-sensors/msg03261.html
See also:
http://archives.andrew.net.au/lm-sensors/msg03383.html
for additional reference to that topic. In no way it means that what I
did was correct. It is just meant to give you some background. The
target rule was that "no module should change their own reference
count". It happpens that Marcelo doesn't really care about this in
2.4, so it was not even necessary to do that, but we didn't know that
back then. Also keep in mind that I have been working on this almost
alone. Not that I blame anyone for that, but it explains why you are
likely to find dozens of incorrectnesses in my work if you read it in
details (but I don't think you need to, see right below).

I've learned much since and would hopefully do things better, but it
happens that we don't want to go in that direction anymore anyway. We
want to revert reference counting in CVS (both in i2c and lm_sensors2)
back to what it was before, so as to bring compatibility back with the
rest of the world (kernel and third party drivers), instead of forcing
the rest of the world to our new (broken) model. In this perspective,
"my" kernel patch doesn't make any sense (this is even exactly why I
want us to go that way - I just can't maintain that borken patch
forever) so you probably don't need to study it in details (in
particular, parts of it that affect non-sensors drivers are most
probably broken, as you already noticed, and, more importantly, these
drivers won't need any change anymore if we revert the reference
counting to a 2.4-kernel-compatible model).

Thanks,
Jean
