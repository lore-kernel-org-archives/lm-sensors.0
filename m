From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: I2C Patch
Message-Id: <20031122084806.4d77d42c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm sorry to bother you, I couldn't find a board to post to, but I
> just have an easy question about the I2C patch.

I CC'd the mailing-list.

> I am running Debian
> Sid 2.4.21 right now and I stupidly upgraded both i2c and lm-sensors
> to 2.8.1 (using apt) without reading that it would disable my bttv. So
> I downloaded kernel 2.4.22 and patched it using your I2C patch. (I
> think I patched it correctly, but I had type in each file to be
> patched.)

You probably forgot the "-p1" option to patch, or gave a bad value to
it. Typically, you have to move inside the /usr/src/linux-2.4.22
directory and use "patch -p1 < /path/to/linux-2.4.22-i2c-2.8.1.patch"

> My question is, after I recompile this new kernel with the
> patch do I have to reinstall both i2c and lm-sensors or just
> lm-sensors? I don't want to screw up my system more than I have
> already.

Lm-sensors should be sufficent, providing you did not only patch your
kernel but also configure it so that it will build the required modules
(i2c-core is obviously already there if you use bttv, but you also need
at least i2c-proc and preferably i2c-dev too). If this was done, you can
install lm-sensors directly. Note that you should edit the Makefile to
have the I2C_HEADERS variable point to $(LINUX_HEADERS) (this is simply
a line to uncomment).

That said, you can also install both i2c and lm-sensors as before, if
will work too.

> Again I am sorry to bother you with this, and if you could
> point me in the direction of a message board I would glady post it
> there instead so I wouldn't waste your time. Thank you again, and
> thanks for the great code!

You're welcome, thanks for the nice words :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
