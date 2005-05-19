From: npfdd@gmx.ch (Daniel Schregenberger)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lmsensors-CVS on 2.6.0-test10
Message-Id: <1070143270.4320.20.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031126190459.724240ad.npfdd@gmx.net>
In-Reply-To: <20031126190459.724240ad.npfdd@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 2003-11-29 at 22:39, Jean Delvare wrote:
> > I got it working!
> > All I had to do was to include ISA support in the kernel. (in the
> > meantime I switched to test11)
> 
> You are also invited to update your local lm_sensors2 CVS repository.
> We've been fixing a couple of problems these last few days.

I did this right before I started. On the last try sensors gave me
segfaults no matter what modules were loaded, but now it's ok.

> > Now I load the following modules:
> > w83781d, i2c_sensor, i2c_dev, i2c_isa, i2c_i801, i2c_core
> > and get these results from sensors:
[...]
> > Now I'll have to find the proper settings in the conf file for my
> > board.
> 
> That's the least to say. Looks like you don't have a config file at all.
> Make sure you have /etc/sensors.conf. If not, copy it from
> lm_sensors2/etc/sensors.conf.eg. It should be a lot better (both labels
> and values).

You're right, I don't have one. :)
I remember seeing a post on the web by someone with the same board as
me. I think I'll search my history and use this as a starting
configuration.

> > Some strange things in the above listing are: fan3 is the power
> > supply and corresponds exactly with the real values but the processor
> > fan is not listed. Maybe because my BIOS always complains it "failed"?
> > It rotates very slow since I exchanged the Intel boxed for a more
> > silent one. But it definately rotates. :)
> 
> Then you want to play with divisors. Slower fans need increased
> divisors. If it's very slow, you need a very big divisor. In this case
> it would be fan2 (since fan1 already as max divisor and still doesn't
> show any value).

OK. Thanks for the hint. I'll try this.

> > And I don't know what temperature belongs to CPU or mainboard and
> > what's the third?
> 
> Usually, temp1 is the chipset internal temperature, which is considered
> to be your motherboard temperature. temp2 would be your CPU here, you
> can run some compilation job or even cpuburn to make sure (the CPU
> temperature will raise quickly). temp3 is probably not wired to
> anything, 208 is a common value in this case.

OK. Thanks. I think this conforms with my BIOS, there are also onyl 2
temperatures as far as I remember. And yes, I tried it: temp2 is my
CPU...it's also indicated in the output but I didn't realize it at
first.

-- Daniel
