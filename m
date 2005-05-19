From: linda_y_wang@yahoo.com (linda wang)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: some interesting twist...
Message-Id: <20041011003213.92993.qmail@web20427.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I was wondering if anyone ca help w.r.t. how to 
get some 
i2c chips to do what I want them to do on a 
motherboard.  It isn't easy, because I
spend about a month playing with various different
drivers: i801.c, lm93, and my own (gem424.c) to 
get it to work; but so far no total success. sigh.

I am hoping with your collective expert knowlege base,
someone will have an idea how to achieve what I am
about to describe.

To make long story short, GEM424 is a qlogic chip
that controlls backplan of a chasis.  It only talks
SAFTE through i2c.  Normally it suppose connected
directly to a SATA2 controller, and through
SCSI/sg, end user can communicate to this chip.
However, the SATA2 controller that it needs to
communicated to isn't ready yet. :( source of 
the engineering chanllenge).

So, the trick is to get any chip on the motherboard
to communicate to gem424, and read back what gem424
sends back.  These are what is available on
the i2c bus:


pc87427    lm93      |
    |        |       |
----------------------------- gem424
        |         |  |
       ICH5      IPMI|
                     |

So far, I was able to use ICH5[MA 0x88/SA 0x89] 
(since it has a master block write interface) to 
write out a fake SAFTE command to GEM424 [SA 0x6E].

GEM424 will respond to the command, and in turn,
responds by asserting itself as the Master and
respond back a block response to the specified
slave address. 

However, ICH5 only has a slave interface that
read in byte-mode.  Is there a way for it
to read in byte by byte of what GEM424 writes back?
(question #1)

Since I didn't know how to make ICH5 read in 
block mode,
I then found another chip on the motherboard, LM93,
which allow block read/write.  I then program
ICH5 to send out the command with LM93's slave
address, and have it respond back to LM93.
However, LM93's blocks are pre-programmed to 
read sense temp, voltage on the chip. Therefore,
any attemps to write to bytes beyond normal
address space are acknowledged by the LM93 but
the data are ignored.

With the i2c-monitor/analyser, I was able to see
GEM424 responds to the command send by ICH5 to
LM93.  Is there a device driver/program that i can 
use/modify to snoop the bus and capture the responds?
(question #2)

It is all I have so far, please please don't make
fun of me if what I am doing doesn't make any sense.
I am hoping someone can help me... If not, please
also let me know.

many many thanks in advance,
-linda

 


		
