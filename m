From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: i2c-parport ancestors
Message-Id: <20040315224141.0d322fd4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040313203134.1d043690.khali@linux-fr.org>
In-Reply-To: <20040313203134.1d043690.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Any plan to remove i2c-elv, i2c-velleman and i2c-philips-par from
> > the 2.6 kernel tree? Now that i2c-parport and i2c-parport-light are
> > supposed to replace them, it would be nice if we could avoid
> > spending energy maintaining them.
> 
> If you think it's ok to delete them now, I will do so.  Just let me
> know.

Well, Aurelien Jarno confirmed that he switched from i2c-elv to
i2c-parport without any problem, and I am myself testing i2c-parport and
i2c-parport-light on two different systems for weeks now, without a
problem.  So I think that everyone can safely move to these new drivers
now, and the best way to invite them to do so is probably to simply
remove the older drivers from the kernel tree.

The reason why I am proposing this now is that we will have to update
many bus drivers to include the class declaration, as it has been
discussed on another thread of this list. The fewer bus drivers, the
less work ;)  And the same would apply to other "bulk" jobs on drivers.
I saw that a few fixes were made to these old i2c over parport drivers
to make them compliant with newer GCC releases or something, and thought
it was a waste of time to go on fixing these deprecated drivers.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
