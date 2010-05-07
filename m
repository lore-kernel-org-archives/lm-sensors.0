From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 07 May 2010 12:42:07 +0000
Subject: Re: [lm-sensors] 3.1.2 sensord duplicate RRD name problem
Message-Id: <20100507144207.2af40197@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
In-Reply-To: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Thu, 6 May 2010 21:42:30 +0200, Andre Prendel wrote:
> On Thu, May 06, 2010 at 06:12:52PM +0200, Jean Delvare wrote:
> > On Thu, 6 May 2010 14:20:56 +0200, Jean Delvare wrote:
> > > I have a patch ready, I'll give it some testing to make sure I got it
> > > right, and then I'll post it here.
> > 
> > Andre, can you please comment on the patch below? Sergey, any chance
> > you could test it? It works for me on two different machines, but I may
> > not have covered all possible cases.
> 
> Jean, the patch works for me with two sensor chips :)
> 
> So I think it's enough for the moment.

I've committed the patch, thank you. Hans, Aurelien, you probably want
to backport the fix to the Fedora and Debian packages if you are using
version 3.1.2 already:
  http://www.lm-sensors.org/changeset/5835

> I've just realised that the code is 
> still difficult to read. I hope we will find some time for more
> simplification/cleanups.

This would be very welcome. There has to be a way to come up with more
simple, less likely to break code.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
