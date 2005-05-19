From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: i2c adapters class
Message-Id: <20040312193903.1fe5f99f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040224223843.2fb3394a.khali@linux-fr.org>
In-Reply-To: <20040224223843.2fb3394a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Well, all depends on what we want to do. Renaming
> > I2C_ADAP_CLASS_SMBUS to anything different means breaking
> > compatibility with older code. Maybe people outside of the kernel
> > tree already use this define. At least the rivatv project now does
> > (because of me, admittedly). So basically, the question is: is the
> > change worth a compatibility change.
> 
> I don't care at all about "compatibility changes" as we can fix up all
> of the in-kernel usages.  Anyone trying to keep drivers outside of the
> main kernel tree deserve the pain that this causes :)

OK, I take note.

> > It's not very difficult to fix for the "user", and supporting both
> > defines looks easy, using something as:
> > 
> > #ifdef I2C_ADAP_CLASS_SMBUS
> > #ifndef I2C_ADAP_CLASS_SENSORS
> > #define I2C_ADAP_CLASS_SENSORS I2C_ADAP_CLASS_SMBUS
> > #endif
> > #endif
> > 
> > at the top of the using code. So the renaming option sounds
> > acceptable.
> 
> Ick, no.  Just rename the thing.

I don't think you got me here. The code snippet above was not meant for
in-kernel files. It was simply a suggestion of what "drivers outside of
the main kernel tree" could do to support both pre-change and
post-change trees. I was just trying to demonstrate that a change would
be easily handled by those.

So I guess we in fact agree. Rename it, period :)

> But what are these "classes" used for exactly?  That was my main
> question.  Does anyone really use them?  Can we just delete them
> altogether?

Aha. I was expecting you to tell us ;) You are the one who introduced
them in the first place, aren't you? If not, we definitely want to
contact that person to know what he/she had in mind.

There were no classes concept in our 2.4 drivers, which tends to prove
that we can possibly live without them. See my previous posts for my
opinion on the topic.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
