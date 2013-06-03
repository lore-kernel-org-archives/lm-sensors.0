From: Paul Crawford <psc@sat.dundee.ac.uk>
Date: Mon, 03 Jun 2013 15:01:01 +0000
Subject: Re: [lm-sensors] Module load order dependency
Message-Id: <51ACAFAD.2050709@sat.dundee.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <51A9CC8D.2010105@sat.dundee.ac.uk>
In-Reply-To: <51A9CC8D.2010105@sat.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,
> I believe the manual page libsensors(3) is pretty complete. What do you
> think is missing? Suggestions are welcome, and patches even more so ;)

I have the lm-sensors package installed on my machine (Ubuntu 12.04) and 
that has not added a man page for libsensors, but I don't know if that 
is Canonical's actions or the lm-sensors suite. Looking at the site's 
page here:

http://www.lm-sensors.org/wiki/man/libsensors

Start with this:

"int sensors_init(FILE *input);
(Re)load the configuration file and the detected chips list. If this 
returns a value unequal to zero, you are in trouble; you can not assume 
anything will be initialized properly."

What format is the file? I presume it is the sensors.conf format, but 
that is not stated.

What if 'input' is NULL, will it use defaults, if so what are they?

Can I call it for multiple files or will that destroy past configurations?

The sensors_cleanup() is clear, but then there is a list of functions to 
do various things without an explanation of what those things are. Take 
for example there two:

"const char *sensors_get_adapter_name(int bus_nr);
const char *sensors_get_algorithm_name(int bus_nr);
These functions return the adapter and algorithm names of a bus number, 
as used within the sensors_chip_name structure. If it could not be 
found, it returns NULL"

What is 'the adapter'? The specific chip used to sense? It seems not to 
be covered anywhere else on that page.

What is an 'algorithm name'? Is this the computation details of 
converting digital count to physical parameter? What possible values can 
this be?

What is the 'bus number'? I am guessing it is I2C address or something, 
but how would I know what it will be? There is no obvious call to find 
out the bus numbers and it is not mentioned elsewhere on that page. Do I 
even need to know them unless I am doing hardware development, or can I 
just read all sensors without such knowledge?

Maybe this would be clearer if the 'sensors_chip_name' structure was 
documented, but it is not on that page nor linked from it.

(similar thoughts for other function calls)

It may be that studying the source code for the sensors library would 
reveal these things, but the purpose of a library & documentation is so 
you don't need to go through the low-level details of how it all works 
because you have a simple described API that will do it for you.

(sorry if that sounds a bit of a rant)

> I didn't know /dev/temperature had ever existed.

I have never seen it actually used.

We did have some of the old WDT-500 ISA bus watchdog cards once that I 
believe provided this, though we were using them under DOS only for 
watchdog work around 18 years ago.

> The problem is that there is no read(2), write(2) or ioctl(2)
> implemented for hwmon devices, so the point of having device nodes is
> hard to justify.

I can see read() making sense, but maybe not write(). ioctl() could be 
used to set limits, but I guess that is not the current way of thinking.

> We agree on the analysis. I suppose this could be solved by adding a
> (somewhat artificial, granted) dependency between both "services" (or
> whatever upstart calls these.)

Things like that are really working with the symptoms in a way, as the 
underlying problem is the kernel has no fixed order for the hwmon stuff. 
In a sense, libsensors is doing the same but at least it is a 
centralised solution to that problem!

Regards, Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
