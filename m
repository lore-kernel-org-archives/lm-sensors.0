From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: as99127f PWM kinda working
Message-Id: <20040530220754.0eb5754a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A74A47.6010601@marcansoft.com>
In-Reply-To: <40A74A47.6010601@marcansoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sensors-detect tells me I have a rev.1 chip:
> Probing for `Asus AS99127F (rev.1)'... Success!
>     (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
> Probing for `Asus AS99127F (rev.2)'... Failed!

OK... The one I tested on was rev.2, so both must be the same for PWM.

> i2cdump tells me that the default value for 0x59 is 0x8f (without
> having touched it since bootup)

I *think* I remember it waas 0x9f for me.

> BTW, I didn't mention 0x83 before, it's just an intermediate value,
> say 70% speed.

You *did* mention it actually.

> My real name is H?ctor, I had my new accounts half set-up still and 
> that's why you got that From: name. I'll be sending email from this 
> account from now on. I don't like my nick on things like this, it
> makes me feel that people are going to think that I'm afraid to say my
> name or something heh heh.

No problem, I prefer it that way too. I've updated the file.

> Please tell me your results with these and other values, so we can
> make some tests to find out what exactly does what.

My own as99127f is a rev.1 and PWM doesn't seem to be wired on my board.
The successful tests were on another board which doesn't belong to me
and to which I have no access anymore, sorry.

In any case I'm not really motivated to work on undocumented chips
anymore. There's more than enough work on documented ones...

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
