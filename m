From: thenders@math.tamu.edu (Troy Henderson)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c oops
Message-Id: <Pine.LNX.4.44.0311150732320.15916-100000@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031115113245.2dd85fba.khali@linux-fr.org>
In-Reply-To: <20031115113245.2dd85fba.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The i2c_delay was introduced recently (i2c-2.8.1). Which versions of i2c
> and lm_sensors are you using? Such an error would occur if you used
> i2c-2.8.0 but lm_sensors 2.8.1, for example.

I am using the CVS of both i2c and lm_sensors.  I did a `cvs update` 
before applying each of the i2c and lm_sensors patches.  So, in theory, I 
should have the latest version of both.

> Please check that /usr/src/linux-2.4.23-rc1/include/linux/i2c.h has the
> i2c_delay function defined at the end. If it hasn't, this means you
> failed patching your kernel tree in a proper manner.

My i2c.h has NO evidence of a function called i2c_delay().  That would 
explain the error.

> Since you obviously patched your kernel, you are advised to use the
> enhanced i2c patch available here:
>   http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
> which has more than the one mkpatch.pl would produce and will let you
> use non-sensors i2c drivers as well. The patch replaces the i2c one
> only, you'll still have to apply the lm_sensors patch after that, based
> on the same version as i2c.

Could you tell me how you generated this patch?  Was it using the 
mkpatch.pl script together with another (maybe more than one) script(s)?  
The reason that I'm asking is that I'd like to do this myself for any 
kernel.  If I use your patches, I'd have to be using 2.4.21 or 2.4.22.

Troy Henderson
