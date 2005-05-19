From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c oops
Message-Id: <20031115145435.32b9ce31.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031115113245.2dd85fba.khali@linux-fr.org>
In-Reply-To: <20031115113245.2dd85fba.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> My i2c.h has NO evidence of a function called i2c_delay().  That
> would explain the error.

Yes, that would. I invite you to take a look at the kernel/i2c.h file in
your local i2c CVS copy to make sure you have i2c_delay() there.
Then look at the patch you generated and make check that i2c_delay() is
there too. Hopefully you will understand where it does go wrong.

> Could you tell me how you generated this patch?  Was it using the 
> mkpatch.pl script together with another (maybe more than one)
> script(s)?  The reason that I'm asking is that I'd like to do this
> myself for any kernel.  If I use your patches, I'd have to be using
> 2.4.21 or 2.4.22.

Using mkpatch.pl and my brain and fingers (and much, much time). The
process isn't automated, because hopefully the whole thing should go
into the Linux kernel tree someday (although I was told it wouldn't be
easy, if even possible). But since I make all individual patches
available on my page, you can generate the core patch for your own
kernel tree, and then apply all individual patches which shouldn't vary
much from kernels to kernels. For 2.4.23-rc1, the media/video patch is
known to fail on some files (but this should be harmless, it fails
because the required fix is already there in another form), and one
new driver (w9968cf) misses its patch - which shouldn't cause any
trouble unless you use this very specific driver.

Eventually I'll make a patch available for 2.4.23-rc1 if there are
enough requests for such a patch.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
