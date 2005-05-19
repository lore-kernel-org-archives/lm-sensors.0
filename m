From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: w83l785ts.c
Message-Id: <1073898488.400263f844378@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073554584.3ffd2498612c6@imp.gcu.info>
In-Reply-To: <1073554584.3ffd2498612c6@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting fago <nuppla@gmx.at>:

> > I can't believe it. Didn't you by mistake run "i2cdump 0 0x4e"
> > instead of "i2cdump 2 0x4e"? Please make sure (using i2cdetect)
> > that you are accessing the right bus.
>  
> shouldn't it be "i2cdump 1 0x2e"? because the sensor is always in a
> directory called "1-002e".

Aha, stupid me. I'm giving you the bad address from the beginning. I'm
really sorry about that. We're lucky you're smarter than I am ;)

> but sometimes there a some X:
> (...)
> 40: 0d XX 00 00 00 80 ff ff ff ff ff ff a3 5c 70 ff   

> and i'm sorry the cop feature can't be disabled. there is only the
> q-fan feature to disable, i don't know which temperature this uses.

For my own knowledge, what does the q-fan feature do? I you disable it,
are the 'XX' still there?

> i'm using now kernel 2.6.1 with the patch, works fine (for me and
> another user :)

Great :) If you did not do any change to the code you sent to me, I'll
prepare a patch and send it to Greg for inclusion into the mainstream.

> the module is loading now at bootup time, this has been always
> working until now. but the loading problem is still here:
> (...)
> perhaps the bios is using the chip this time, and so it is not
> found.
> so it's not really a driver problem?

Yeah, I think that it is what's happening. As the driver loads, we read
a few registers from the chipset to ensure it is a W83L785TS-S. If one
read fails, the identification will fails. The 'XX' in the dumps show
that this sometimes happens.

So this is no bug in the driver, although we could try to detect read
errors and reissue a read command as they happen. Ideally this shouldn't
be done at chip driver level but in i2c-core itself I guess, but that's
still something to start with. I'll give it a go maybe this evening
unless you are willing to try it yourself.

Thanks a lot for your work and feedback :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
