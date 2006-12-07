From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 07 Dec 2006 19:28:49 +0000
Subject: [lm-sensors] [PATCH] W83793 driver
Message-Id: <20061207202849.e4e80962.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F59C51.6070004@sh.cvut.cz>
In-Reply-To: <44F59C51.6070004@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Sat, 02 Dec 2006 17:46:34 +0100, Rudolf Marek wrote:
> > It would be great if we could fix the driver quickly so that I can push
> > it in kernel 2.6.20.
> 
> Many thanks for the review! Btw what about coretemp driver ;) ?

One thing at a time, if we want the w83793 driver in 2.6.20.

> I have today only few minutes left for lm-sensors :/ Tomorrow hmm ... some 
> hours? I will try to do that...
> 
> Do you think we have like two weeks?

We have less than that, I'd like to push the i2c and hwmon patches to
Linus by the end of the week, because next week I'll be mostly
unavailable. And I also need to learn how to use git to send the
patches to Linus.

> Oh and one more thing, I'm attaching the not-ready-yet documentation, just FYI 
> (Yuan inheritance)

Ah, great, I didn't know we had documentation at all. I've updated it a
bit, it should be suitable for upstream submission now.


-- 
Jean Delvare

