From: ffl@aber.ac.uk (Fred Labrosse)
Date: Mon, 30 May 2005 09:40:05 +0000
Subject: [lm-sensors] External sensor and i2c/parallel adapters
Message-Id: <20050530083843.63973b28@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050526101154.6c823e9c@localhost>
In-Reply-To: <20050526101154.6c823e9c@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 28 May 2005 16:38:31 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Fred,
> 
> > I need to connect a compass having an i2c bus to a computer.  The
> > current plan is to use one of these i2c/parallel port adapters. 
> > However, I'm not sure if it will indeed work.  Here is what I think
> > at the moment.
> > 
> > Many kernel drivers do support e.g. the Philips adapters.  However,
> > it seems that this is not to use the adapter externally.  This would
> > however work with the i2c-pcf-epp driver, but it hasn't been ported
> > yet to linux 2.6 (I saw a more than 1 year old message on that on
> > this list, but no follow up).
> 
> There are two kinds of parallel port adapters which can be used to
> control an I2C bus.
> 
> The first kind uses the parallel port to address an external I2C
> master, such as the Philips PCF8584. What goes through the parallel
> port in this case are commands for the external master (and data
> bytes, of course). That's what the i2c-pcf-epp driver does.

But it hasn't been ported to linux-2.6 yet.

> 
> The second, more popular kind controls the lines of an I2C bus
> directly through the parallel port pins. In other words, the parallel
> port is the I2C master itself. There are various implementations, some
> use the same pin to read and write, others use different pins. That's
> what the new i2c-parport drivers does.

A long time ago (a year ago?) I have tried to plug it directly a
suggested somewhere (can't remember) but it didn't work because of
differences in levels (the compass wasn't pulling enough one of the ways
if I remember well).

> 
> In almost all cases you need to wire some electronic components
> between the parallel port and the i2c client chip(s), except for the
> i2c-pport driver (*not* the same as i2c-parport).
> 
> > The doc for the i2c-parport kernel module gives the schematics of a
> > diy "i2c-over-parallel-port" adapter.  Anybody knows how easy it is
> > to use?
> 
> I'm not sure I get what your question really means. If you are able to
> build the adapter as described, you get a fully controllable I2C bus.
> The hard part is to build it. Once it's done, using it is just as easy
> as using any other I2C or SMBus adapter under Linux.
> 
> > Any suggestions?
> 
> If you have the required electronics skills, simply build the adapter
> according to the schematics of the i2c-parport documentation (second
> one is better).

Exactly what I needed to hear.

Thanks.

Fred
