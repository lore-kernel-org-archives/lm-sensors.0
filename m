From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: i2c/isa command line tools
Message-Id: <20040731113548.6a709645.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040725222521.1df8dfad.khali@linux-fr.org>
In-Reply-To: <20040725222521.1df8dfad.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I was thinking, instead, about an option we could add to all the tools
> (say -y for "yes") that would skip the warning and the delay.
> This would make the tools better for use in scripts.

I thought of that at first too, but it isn't trivial. Command line
parsing in these tools is tricky and adding such a flag will make things
even more complex. This may be worth the pain if someone really enjoys
the "interactive" mode, but if not, I guess we don't want to keep it.

So what I propose is to surround the "interactive" code in i2cset and
isaset with #ifdef INTERACTIVE/#endif instead of really deleting it.
This allows people who want it to enable that "feature". In case we
later switch to a more advanced command line parsing, we'll propose a
switch instead.

I would also suggest not to print anything on success in non-interactive
mode. Seems that it is a common unix practice to keep quiet when
everything's fine.

The mask is something different which can be implemented in any case.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
