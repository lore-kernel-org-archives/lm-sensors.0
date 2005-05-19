From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: lm90 driver
Message-Id: <20030906000353.40951246.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I see on the new drivers page that an lm90 driver is written.  I have
> a Soyo KT400 Dragon Ultra Black edition with that chip on it and would
> be glad to assist in testing if you still need help.  I am not a
> programmer byu any stretch of the imagination, but I would classify
> myself as a power user and can install software from source.  Let me
> know if there are any tasks that need to be done.

Yes, testers are still wanted. In order to test the driver, you'll have
to install the CVS version of both I2C and LM Sensors. If you don't use
other I2C-related devices (frame grabbers and TV tuners are, among
others), simply follow the instructions here:
http://secure.netroedge.com/~lm78/download.html#cvs
It's as easy as "make && make install" for i2c and "make && make install
&& ldconfig" for LM Sensors. Then, run "sensors-detect" and it should
detect your LM90.

If you do use other I2C-related devices, follow the more detailed
installation guide here:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/

(If you don't know, try method 1 first, since it's easiest; if you
encounter problems, move to method 2.)

Let us know how the driver works for you!
Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
