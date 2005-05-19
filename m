From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c/kernel i2c-algo-bit.c
Message-Id: <3FB5A5F1.E3271845@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031101170944.386fd941.khali@linux-fr.org>
In-Reply-To: <20031101170944.386fd941.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

correct. cycle time is 3/2 of advertised, frequency is 2/3 of
advertised,
clock is not a 50/50 duty cycle.

I'm uneasy with bit_test the default, but if you've identified the
reason for matroxfb problems and that's the best way to fix it then
perhaps it's best.

On the TODO, that was for background. I think our goal should be to
port the most important improvements from i2c-algo-biths back to
i2c-algo-bit.
It was unfortunate that Kyosti decided to start a new driver...

Jean Delvare wrote:
> 
> > Fix #1 looks fine.
> > Fix #2 (test_bus) I'm sure is an improvement.
> > If you are really motivated, try fixing the printk's for debug=1.
> > As I recall from long ago some of them are not correct.
> 
> Could be a feature. Maybe the author considered that someone askin for
> the test shouldn't have to also set i2c_debug in order to see the result
> of the test.
> 
> My opinion is that I would rather do the test as the default (that is,
> default to bit_test=1) and not show anything about it unless
> i2c_debug>=1. The reason why I suggest this should be the default is
> that I plan to write a unified i2c-over-parport driver as a replacement
> for the 5 different drivers out there. Idealy, that driver would be able
> to autodetect which kind of parallel port adapter is present. This can't
> be done without bit_test=1 as far as I can tell. So, unless bit_test is
> likely to cause trouble (shouldn't since we check the bus isn't busy) I
> would like it to be the default.
> 
> This also solves other problems, such as sensors-detect taking forever
> to scan i2c-matroxfb busses with non DDC-compliant monitor plugged-in.
> 
> > If you want to be truly frightened try debug=9.
> 
> I don't want to be frightened. I already live right in front of a
> graveyard, that's enough ;)
> 
> > The actual cycle time is 2/3 of advertised (yes it's 3 states total,
> > not 2 or 4).
> 
> I guess you mean 3/2 of advertised. If I read you (and the code)
> carefully, this means that SCL isn't a square signal, is it? Does this
> really comply with the I2C standard?
> 
> (Just took a look at TODO... Let me be clear. All this stuff is way
> beyond me.)
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
