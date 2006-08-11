From: fhj52rags@yahoo.com (Ric)
Date: Fri, 11 Aug 2006 21:30:29 +0000
Subject: [lm-sensors] New device: SMSC's EMC6W201 -support?
Message-Id: <20060811213029.66702.qmail@web37404.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

Holy Smokes, my luck is good. For the second time in less than a month
I found a lm_sensors post to me on Google while looking for something
else totally unrelated!
I've subscribed to the list so we won't have to push that luck. :)
My previous email fhj-52 [at] sbcglobal [dot] net is still the best but
this subscription address should be good too.
---

John: That's great that you found the datasheet! And Thank You for
posting it at http://www.youeatlard.com/6w201.pdf !

The SMSC EMC6w201 device on the GBT GA-2cewh mobo is the little (6mm x
6mm) chip in between the PCI slot(next to SDRAM slots) and the first
PCIe slot. If your eyes and magnifier are good enuf, it says SMSC
across the top with EMC6w201-2G just below it. There are more numbers
but my eyes/magnifier are not so good...

I am glad that Alfredo responded to someone because he has ignored me(
... ).  There is an issue, #562, at the SpeedFan site that has quite a
bit of info in it; tests, output from i2cget, i2cdump, etc.

Short version is that Alexander Berezkin is working on support to be
included in HMonitor( www.hmonitor.com ) and I am testing for him.  

I do not have much interest in either to be honest. Either is for
windoz and I spend less than 10% of time using Win2k. However, I am
interested in getting all my online 2CPU friends, who are almost all
windoz weenies, :), to have proper(read: real time) HWM support so will
give some time to it(either/both).
---

There are only five fan headers on this GBT mobo.  One in ~ each corner
and one near the center. Each has, according to GBT, Pulse Width
Modulation(PWM) support using the fourth pin; all have 3-pin RPM
support.  The 6w201 device can handle up to six fans, and even modulate
all 6 if the onboard cicuitry supports it by tying two sets of fans
together. I am not sure yet how GBT implememnted it.  They are a PITA
to deal with; I am not a dentist and don't expect to travel far to get
straight answers when I have, IMO, paid to get them, if you know what I
mean. 
I have PWM fans now and that is part of current upgrading effort so can
test that function should it be implemented(hopefully).

On this GBT mobo, there are only four temperatures of the 6 available
that have value(AFAIK): (1)CPU0 & (2)CPU1 plus (3)"front" and (4)"rear"
ambient.  The device outputs the two other values but they are, ithink,
unconnected and thereby providing nonsense(they do change with load but
are always low numbers hovering in-between the front & rear ambient
temps).  GBT refused to tell me explictly where the diodes are on the
board. They claim it is, I quote: "classified" information.  As soon as
I find them I am sending a description to the New York Times ... :-)
...
I am 99% certain that the so-named "Rear" ambient is the emc6w201
device ambient(internal) and not connected to a separate diode. It is
always higher than it should be(~ 8*c-10*c higher than the "front" ).

Voltages are going to be a bit tricky.  There's a chart and as far as I
can tell, one has to interpolate each voltage line on it to get a
factor that can be used on the outputs from the registers.
My initial effort at that provided some values that fell outside of
what was expected.  I'd be really happy if someone knows how to get
that to work better and would tell me. 
The good news is that the IT8712F device is providing very sensible
values for voltages.  GBT told me that the IT8712F Super I/O device
only provided I/O but ithink that support person is mistaken.  Due to
PSU issues, I ran a bunch of tests/charts and the output from the 8712F
device followed excellently with what I was doing.  Of course you guys
know a LOT more than I and might/could explain that but I think GBT
hooked-up the IT8712F voltage sensors; don't know what the SMSC device
does on those lines.

Currently this GBT system is down for upgrades(PSU, chipset fans, new
case, blah...).  I was going to dump it but GBT finally came thru with
a (beta) BIOS(f13y) that makes using Linux on it much, much better(they
removed the multiple PCI domains issue) so have decided to stick with
it. It is a good board, comparable to the Tyan Thunder K8we, and at a
much better price than the Tyan. Rock solid stable...

I've bored you enuf but hopefully not too much, :).

Thanks to all who assist!

Ric

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

