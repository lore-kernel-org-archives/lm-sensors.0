From: james.oden@gmail.com (James Olin Oden)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: Memory leak in I2C (ticket #1898)
Message-Id: <ac921f99050308114831cf1738@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <jG6nFvCq.1108465575.6408970.khali@localhost>
In-Reply-To: <jG6nFvCq.1108465575.6408970.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 19 Feb 2005 16:50:25 -0500, James Olin Oden
<james.oden@gmail.com> wrote:
> On Sat, 19 Feb 2005 18:56:51 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> > Hi James,
> >
> > > Here is the list in the order they are loaded:
> > >
> > >     i2c-core i2c-dev i2c-proc i2c-i801 lm87b lm93 eeprom pcf8574
> > >
> > > When I found the appearant memory leak I was only loading and
> > > unloading modules lm93, eeprom, pcf8574.
> >
> > Tried with i2c-core, i2c-proc, i2c-viapro and w83781d, with only w83781d
> > cycling. I noticed that the "free" memory as reported by top would
> > decrease almost to 0. However it would NOT generate a memory shortage.
> > If I run Firefox at this point, it'll get all the memory it needs (and I
> > disabled swap for the test). So I don't think I am able to reproduce
> > what you described.
> >
> > Can you possibly try with each of the three modules (lm93, eeprom,
> > pcf8574) individually and see if all cause the trouble, or only one of
> > them?
> >
> Sure.  It will have to wait till Tuesday, when I get back into work,
> but yeah I can do that.  I was merely working other tasks until I
> could see if you could reproduce.
>
OK, it took much longer than expected (I was wrestling with a much
more difficult and significant problem).   At anyrate, I can
reproduce, with just the eeprom chip driver.  It takes I think between
30 minutes and an hour to reproduce.  Also, I have observed the
occasional (far less than before going to 2.9.0) panic while unloading
drivers as something was invoking  the sysctl functionality of the
driver.

What is rather odd, if I make several connections to the box, and load
and unload different drivers in each session (lm93 in one, eeprom in
another, ect), I tend to get the out of memory errors much faster.  I
need to do this again, though just to make sure I hadn't already
tainted the system with other tests.

Just so you know I can reproduce the memory leaks on both E7501 and
E7520 based systems.  I did not think it would be system specific but
this pretty much tells me its not.

I still need to find out if I can get it to cause the out memory
errors with other drivers or not.
I will send more info when I have it.

Cheers...james
