From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Jan 2009 08:27:44 +0000
Subject: Re: [lm-sensors] Problem with order of module loading
Message-Id: <20090127092744.42cf8d5c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090125021151.GE16739@paradise.net.nz>
In-Reply-To: <20090125021151.GE16739@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Replying to myself...

On Mon, 26 Jan 2009 15:57:10 +0100, Jean Delvare wrote:
> On Mon, 26 Jan 2009 22:47:36 +1300, Volker Kuhlmann wrote:
> > A wrapper for the library, which outputs device names to /sys/class/...
> > pairs one per line in a format easily parsable by a shell script?
> 
> Either that, or with a command line interface so that you can ask
> directly for what you want. This will save some parsing in
> user-space, and also avoids computing things that the caller will
> just discard.

BTW, I forgot to mention: this won't solve the problem completely, as
the i2c bus numbers are still not stable. libsensors only addresses
this issue during configuration file parsing, where bus number
references can be bound to actual buses. But these statements have no
effect on the device names as returned by libsensors to applications.
This was the point of ticket #2238:

http://www.lm-sensors.org/ticket/2238

Unfortunately, the implementation I have in mind for ticket #2174 is
incompatible with the fact of letting bus statements have any effect
beyond the configuration file they come from:

http://www.lm-sensors.org/ticket/2174#comment:6

And I consider #2174 much more important to have than #2238, so the
latter will most certainly be closed as WONTFIX.

I tend to think that i2c bus number stability is better achieved at
kernel level anyway, maybe using the same approach used for multimedia
devices: a module parameter can be passed that specifies the desired
device number.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
