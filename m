From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sat, 28 Jun 2008 15:34:33 +0000
Subject: Re: [lm-sensors] Accelerometer etc subsystem (Update on progress)
Message-Id: <48665A09.9090705@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com>	 <20080520132817.03fb74ea@hyperion.delvare> <4863D97A.9090102@gmail.com>	 <1214537367.8462.157.camel@moss.renham>  <4864B6D6.3020509@cam.ac.uk> <1214642057.4265.7.camel@moss.renham>
In-Reply-To: <1214642057.4265.7.camel@moss.renham>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Nizette <bn@niasdigital.com>
Cc: Jonathan Cameron <Jonathan.Cameron@gmail.com>, mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, hmh@hmh.eng.br, spi-devel-general@lists.sourceforge.net, Anton Vorontsov <avorontsov@ru.mvista.com>

Hi Ben,
>>> union channel {
>>> 	char data[2];
>>> 	int16_t val;
>>> }
>> Good point, I'd forgotten you could do that with unions.
> 
> Cool, just watch endianness of course :-)
> 
That and the annoyance of alignment issues making that approach taking way more
space that you'd think.
>>> Incidentally, is there much that your ringbuffer can do which kfifo
>>> can't?  Apart from having a bunch of extra nice accessor-helpers sitting
>>> on the top.
>> Not sure, I'll look into it.
> 
> kfifo won't be a drop in replacement, it's just a very simple ring fifo.
> I suspect your higher level ring buffer accessors and allocators could
> live on top of it though.
Sure, but from my understanding of kfifo it takes a much more symmetric
approach to reading and writing with locking used to prevent them occuring
concurrently.  You obviously can use it without locking but I don't believe
that it provide any facility for coping with the nasty case, (buffer full
and hence during read attempts a certain amount of what is copied out may
have become invalid).  It maybe the case that, as you say suitable high level
functions on top of a kfifo would be a good way to proceed (afterall,  kfifo
is well tested etc), but I fear, given how little of kfifo's code would actually
be used it would be more likely to cause problems than not. 

It might be best to leave this decision until the exact requirements of the ring
buffer are actually known.

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
