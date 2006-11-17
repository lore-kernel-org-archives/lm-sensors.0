From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 17 Nov 2006 10:26:16 +0000
Subject: [lm-sensors] sensors.conf syntax: anyone use escape sequences?
Message-Id: <20061117112616.cfa66388.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061112140142.GB8009@jupiter.solarsys.private>
In-Reply-To: <20061112140142.GB8009@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 12 Nov 2006 09:01:42 -0500, Mark M. Hoffman wrote:
> This is a question about sensors.conf syntax:
> 
> For a quoted string, libsensors currently accepts C language escape sequences
> like '\n' for newline, etc.  It also accepts octal escapes, like '\015', but
> for some reason it doesn't accept hex escapes, like '\x20'.
> 
> Question: is anyone actually using these escapes?
> 
> I wouldn't mind getting rid of them.

I've never seen them used. I agree that octal escapes don't sound very
useful, assuming libsensors accepts all character values in quoted
strings, and not only the 32-127 range. Same applies to C language
escape sequences, except \n, as I guess there is no other way to
include a newline in a string?

Then the question is, how much does it cost? It's not a totally
unreasonable feature, so we'd need a good reason to get rid of it.

Thanks,
-- 
Jean Delvare

