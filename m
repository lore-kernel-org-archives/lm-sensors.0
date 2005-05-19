From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: lm_sensors 2.8, linux 2.4.22, and a tyan tiger mpx (s2466n-4m)
Message-Id: <20030907193631.7aa1e9f2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1062646002.1248.7.camel@mycrondo.mycronite>
In-Reply-To: <1062646002.1248.7.camel@mycrondo.mycronite>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> i just recently moved to linux 2.4.22, since the XFS patch from sgi
> has been released, and i've noticed a problem that seems to have been
> introduced into the i2c patches available from:
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
> 
> The patches work, in that they do compile, but i can't get the w83781d
> driver to actually activate both of the sensor chips, I'm only getting
> half the readings:
> namely, the one labelled 
> 
> w83627hf-i2c-0-2c
> Adapter: SMBus AMD75x adapter at 80e0
> 
> shows up, but the other one (starts with "w83782d-*", forget the full
> string), does not.

The patch is unlikely to be the cause, because there have been very few
changes between the 2.4.21 patch and 2.4.22 patch. What's more, the
driver you talk about is part of lm_sensors, not i2c itself.

I guess that you were using lm_sensors 2.8.0 with the 2.4.21 kernel, and
that you are now using lm_sensors CVS with a 2.4.22? In this case, this
simply means that a bug was introduced in the w83781d driver after 2.8.0
was released, and tracking the changes using CVS should reveal it (I
can't verify this right now, since I'm offline, but I will as soon as
possible).

OTOH, if you are still using lm_sensors 2.8.0, trying CVS could help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
