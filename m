From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 10 Aug 2006 08:35:04 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060810103504.8480da09.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Anthony,

> > What about my question on the locale you use?
> 
> Locale is en_US.UTF-8

Pretty standard. But just in case, would you mind recompiling
libsensors with locale set to C or POSIX, and then running "sensors"
with the same locale?

> It seems that the only thing the parser recognizes are lm_sensors
> keywords (label, compute, set), but only if they are in the first
> position on the line.  The sample sensors.conf will not work for me with
> the spaces in front of the terms.  I get Invalid Keyword errors.
> 
> In a compute line, I havent figured out how to make it process without
> error, I get syntax errors on the computation part of the line, if it
> put it into quotes, I get an unexpected EOL error.

Compute lines are by far the most complex ones in the configuration
file. Given the trouble you had for more simple statements, it's likely
they will never work.

-- 
Jean Delvare

