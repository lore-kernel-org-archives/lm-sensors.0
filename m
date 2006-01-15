From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 15 Jan 2006 18:00:38 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <20060115190038.24e2fb96.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

> > OK, great :) The /usr/local variants should always be before the /usr
> > variants in $PATH, but depending on the distribution and/or the user,
> > it might not actually be the case.
>
> Suse 10.0 in my case

I just installed Suse 10.0 on one of my systems yesterday, and I do
have /usr/local/bin before /usr/bin as expected. Maybe you have some
custom configuration on your own account.

That being said, there still is a problem when you have the same
library installed under /usr/lib and /usr/local/lib, regardless of
$PATH.

> I hadn't, but now that you mention it, I see that now in the Changes 
> File. I notice that the version number has changed from 2.9.3 to 2.10.0. 
> As an aside, I also notice that the projected release date for 2.10.0 is 
> incorrect ;)

This is just a planned name for the future release. We change that line
(and especially the date) when we do the real release. I changed from
2.9.3 to 2.10.0 this time because I think that's how we'll number the
next release, but this hasn't been publicly discussed yet AFAIR.

Anyway, this version is better refered to as "CVS".

-- 
Jean Delvare

