From: Sebastian Flothow <lists@flothow.de>
Date: Wed, 22 Aug 2007 19:45:41 +0000
Subject: Re: [lm-sensors] Submitting motherboard-specific support? (w/
Message-Id: <4e09dc1e74aa0f49f00638b0d635f15b@flothow.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C997B4.50509@dolbeau.org>
In-Reply-To: <46C997B4.50509@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am 21. Aug 2007 um 19:17 Uhr schrieb Jean Delvare:
> Do we really need a mail validation mechanism (as bugzilla and mailman
> do) AND a captcha? I thought that we only needed one method. I've
> always seen the captcha as a replacement for email validation when
> email validation is considered too much.

My experience from running online fora (using phpBB) suggests that 
captchas are actually a harder test than email verification - 
apparently spambots do read their mail and follow through on 
confirmation links.

So, email verification has its place for confirming address ownership 
(to catch typos and prevent abuse), but it's not much use when the 
spambot _is_ the legitimate owner of an email address. Also, even the 
bots who don't go to this trouble still end up creating loads of bogus 
user accounts.

Captchas aren't perfect, either - some bots succeed reading them, but 
maybe phpBB's captcha generator is too deterministic. Still, they have 
reduced the amount of spam by many orders of magnitude, to about two or 
three posts per month, making manual deletion feasible.


> In the case of trac we want an email address anyway (for ticket change 
> notifications).

Which would indeed suggest having both mechanisms, IMO.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
