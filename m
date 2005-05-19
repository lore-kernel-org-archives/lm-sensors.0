From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: i2c adapters class
Message-Id: <20040310215512.6dc0e360.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040224223843.2fb3394a.khali@linux-fr.org>
In-Reply-To: <20040224223843.2fb3394a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > BTW, don't you think I2C_ADAP_CLASS_SMBUS is a misnomer? It's about
> > hardware monitoring, not the SMBus protocol. I'd say
> > I2C_ADAP_CLASS_HWMON or I2C_ADAP_CLASS_SENSORS would have been more
> > appropriate (although it may be a bit late for a change...)
> 
> Yeah, it doesn't make the most sense.  Care to propose something that
> does make sense?  Or something to just fix this class stuff up all
> together?

Well, all depends on what we want to do. Renaming I2C_ADAP_CLASS_SMBUS
to anything different means breaking compatibility with older code.
Maybe people outside of the kernel tree already use this define. At
least the rivatv project now does (because of me, admittedly). So
basically, the question is: is the change worth a compatibility change.

It's not very difficult to fix for the "user", and supporting both
defines looks easy, using something as:

#ifdef I2C_ADAP_CLASS_SMBUS
#ifndef I2C_ADAP_CLASS_SENSORS
#define I2C_ADAP_CLASS_SENSORS I2C_ADAP_CLASS_SMBUS
#endif
#endif

at the top of the using code. So the renaming option sounds acceptable.

Another possibility would be to provide both defines for some times. The
compatibility work would be the same for the "user", except that it can
be postponed to much later (at the time we remove the
I2C_ADAP_CLASS_SMBUS define).

Both options are fine with me. No option is also fine to me, we can live
with _SMBUS, although it is a bit confusing at first IMHO.

My two proposals for a new name are I2C_ADAP_CLASS_HWMON and
I2C_ADAP_CLASS_SENSORS. Either is fine with me too, I don't have any
preference. Or any other with a similar meaning.

As for fixing the class problem, again, we need to decide what we want
to do. Changing the code is easy after that. My opinion is that classes
are a good way to make things clearer and prevent excessive probing of
chips, and reduce the risks of misdetection for a limited number of
chips too. So defining classes consistently in adapters and checking for
them in chips makes sense.

But if anyone objects that it also makes the code slightly more complex
and gives a little more work to maintain and support, that's true too.
Question here is whether it's worth it or not. I tend to think it is
(but no strong opinion here either).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
