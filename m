From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC: vid scaling does not belong in kernel?
Message-Id: <rgtqBRSe.1112695032.5765250.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
In-Reply-To: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant, Philip,

> The vid voltage mapping is presented in table format on data sheets,
> and I see absolutely no reason to use anything other than a table
> lookup, for that technique provides an audit trail back to data sheet.

And some (most?) datasheets present fan clock dividers as tables too. Are
we going to convert div = (1 << n) into a 4- or 8-value table? Certainly
not. So the fact that the datasheet represents it as a table isn't a
valid reason alone for us to use a table in our implementation.

Also note that some drivers need to do the inverse operation, i.e. find
out which VID code matches best a given voltage. This can't be done
with a table-based implementation.

The fact is that the VID codes are not random. There are linear parts and
bits with special meanings. Our code reflects that. Also, various VRM
versions are partly compatible. Our code reflects that too.

If you want to audit that code, feel free to compare the output of our
function with a static table of your own.

I believe that having conversion formulas is *less* error prone than
having tables. Especially, VRM 10 is a 6-bit value, so a 64-value table
would be required. It's quite easy to mess up one value and it can take
decades before someone hits the problem.

> The art of measurement is honesty, not an obfuscated code competition.

You never saw obfuscated code, right? This one isn't. Our approach to
the problem differs from yours. That doesn't make the code obfucated.

> "The competent programmer is fully aware of the strictly limited size of
> his own skull; therefore he approaches the programming task in full
> humility, and among other things he avoids clever tricks like the plague.
> -- Edsger W. Dijkstra"

That's an interesting theory (let alone the fact that it's off-topic,
because there is no trick here). If we were following that theory to the
letter, the kernel would most probably be very large and slow as hell. A
certain amount of cleverness is required to write kernel code (or just
about any code, for that matter). While Djikstra was a briliant
mathematician, I just can't agree with him here. I would sure avoid
stupid tricks, but clever tricks, by definition, are the key to
efficient programming.

Those who attempt to write code and pretend they don't need to know any
of the internals usually write poor code. You need to know the language
well in order to write evolutive and maintainable code. And yo better
know a little bit about the hardware itself if you want to write
efficient low-level code.

--
Jean Delvare
