From: office@voxel.at (Dr. Simon Vogl)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: new drivers for linux 2.6, testers wanted
Message-Id: <3FF701E0.50002@voxel.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040101092047.3c6a40b4.khali@linux-fr.org>
In-Reply-To: <20040101092047.3c6a40b4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was always agains autodetection, because I was wary not to disturb any 
chips on the line,
not to mention the times when I had other hardware on my parallel ports 
which would break
when the wrong lines pulled ;)

but it would be nice to have a kernel config option which sets the default
just my two cents ;)
Happy new year to you all,
Simon

Jean Delvare wrote:

>>>So, if any of you have parallel port i2c adapters and are running a
>>>2.6 kernel, that would be nice to you to give a try to my new
>>>drivers. You'll have to pass the type parameter that is correct for
>>>your board:
>>> 0 = Philips
>>> 2 = Velleman
>>> 3 = ELV
>>> 4 = ADM evaluation board
>>>      
>>>
>>Is there any way to autodetect this so the module parameter is not
>>needed?
>>    
>>
>
>We could autodetect if and only if (at the moment) i2c-algo-bit has been
>loaded with bit_test=1, which isn't the default. For this reason, I have
>not implemented it yet.
>
>We could duplicate the test code into the i2c-parport module(s), but I
>don't really like duplicating code. This makes maintainance harder, and
>modules bigger for not benefit. Or we could have a more simple test
>(e.g. just verify that the bus "reset" worked) but this would result in
>a less reliable detection.
>
>We could make i2c-algo-bit's bit_test=1 the default, but this would
>break (sort of) several modules that do not seem to reset the lines
>correctly at load time (i2c-matroxfb and one of the zoran modules come
>to mind). On the other hand, this would be the right time to fix them.
>This would also mean that we would be using bit_test in a way it wasn't
>made for in the first place (i.e. detection instead of debug) so we
>would obviously have to make it less verbose, which in turn would make
>it useless for debugging.
>
>One possibility I see is:
>1* Make the bus_test function of i2c-algo-bit publicly available.
>2* Have an extra parameter to that function to control its verbosity.
>3* I2c-parport would call it in non-verbose mode for detection purposes.
>
>One other possibility I see is:
>1* Testing the bus is a good idea, so this is not only 1 by default, but
>the bit_test parameter is gone.
>2* So this is not for debug purposes and has to be less verbose (i.e.
>don't output anything on success and maybe not even on error).
>3* We fix bus drivers that don't work with it.
>
>But there will still be something fundamentally broken, which is that
>the test_but function cannot detect if lines are inverted or not, nor
>which line is which. For example, if two types were supported by the
>i2c-parport module, which have SDA and SCL swapped but otherwise use
>the same pins, it couldn't possibly differenciate between them. Same
>goes for types that would use the same pins for the lines but have them
>inverted. I think that types 1 and 4 fall into this category. And the
>more adapter types the module will support, the more likely the
>detection is to fail.
>
>This make me think of another possible approach. We could consider the
>detection a one-time procedure, proposed to the user who doesn't know
>what type to use (which IMHO is unlikely because not everyone plays with
>parallel-port adapters, and I'd expect people who do to have solid
>hardware and software experience), to tell him which type to pass the
>next time he wants to load the module. Let's use an example since I'm
>not sure I've been very clear there ;)
>
>Our user has a parallel port adapter and doesn't know which type to use.
>He/she runs "modprobe i2c-parport detect=1". Inside i2c-parport, we
>would then try adapter types from 1-1=0 to the last possible type or a
>type passes the test, whatever comes first. In the logs, we would output
>the failures and succes, but not load the module. Log messages would
>look like:
>
>i2c-parport: Type 0 failed.
>i2c-parport: Type 1 succeeded. You now have to load i2c-parport with
>type=1. If it doesn't work, run detection again with detect=3.
>
>So this would basically be a way to give a hint to the user.
>
>But frankly, is it worth it? I doubt it. As said before, I don't expect
>unexperienced users to need this module, and I expect experienced users
>not to be afraid by having to "modinfo i2c-parport" and pick the correct
>type. I would have liked to implement autodetection too, were it
>possible to be sure it would work, but as underline above, there are
>cases were we already know it just won't work.
>
>But of course comments are welcome. Maybe I've missed easier ways
>that would make me revise my judgment.
>
>  
>


-- 
Dipl.-Ing. Dr. Simon Vogl !  http://www.voxel.at/
VoXel Interaction Design  !  office@voxel.at
Breitwiesergutstr. 50     !  +43 650 2323 555
A-4020 Linz - Austria     !  




