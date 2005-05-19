From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: some interesting twist...
Message-Id: <416DD329.6010405@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041011003213.92993.qmail@web20427.mail.yahoo.com>
In-Reply-To: <20041011003213.92993.qmail@web20427.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the clarification, you need "master-as-slave" functionality
(my #1a). Even worse, you need block write to your slave. I reread the ICH5 datasheet
and it supports slave for byte writes only, not for block writes, you are correct.
So not only do we not have it implemented but ICH5 doesn't support.

linda wang wrote:
> Hi Mark,
> 
> Many thanks for your responds.  I realized that
> my previous message wasn't clear, so here is
> some explanation.
> 
> 
> --- Mark Studebaker <mds4@verizon.net> wrote:
> 
> 
>>#1 unimplemented
>>	a) if the GEM424 is waiting a while, then is a
>>master on the bus, and needs the ICH5 to be a slave,
>>	   then you need "master-as-slave" functionality,
>>which is unimplemented in the i2c layer or in any
>>driver
> 
> 
> Both ICH5 and GEM424 have a master and a slave
> interface embedded in the chip.  
> Just that GEM424's master and slave
> interfaces can do Write Data Block. But ICH5's
> master can, but not its slave interface.
> Thus I needed a slave interface that can read in
> the data when Gem424 asserts itself as the master
> on bus and sends the data block.
> 
> Master    Slave
> ICH5 ---> GEM424 (sending request#A )
> GEM424 ---> LM93 (sending a response to the request#A)
> 
> None of the sensor chips on the motherboard that 
> I described in my previous email was able to
> read in the "response" from Gem424. Even LM93,
> an i2c slave, which is capable of reading block data,
> but all its block registers are pre-wired to read
> from the sensor registers. So, can't store
> any data that is written to it through the i2c bus.
> 
> I read throgh all of specifications with all these
> chips, and I don't see a convient way to solve
> my problem.  Therefore, we may have to 
> develope our own board with a microcontroller on it.
> 
> 
>>	b) perhaps the GEM424 is using SMBus 2.0 "block
>>write/block read process call" (a block write
>>followed by
>>	   a block read in one transacction)? If so, it is
>>implemented in the i2c layer but is not supported by
>>	   any driver (or any chip AFAIK).
> 
> 
> IPMI seems to do that; but not GEM424. Because
> GEM424 acts as a slave when it is received the data
> block (the request).  only act as master when
> it process the request, and ready to send back
> to the sender.
> 
> 
>>#2 not from our package
>>	you may wish to use the aardvark development tool
>>from www.totalphase.com but that won't help you
>>	in your real system.
> 
> 
> yes, you are also right. It won't help in our
> production system. 
> 
> Thank you for taking the time to answer my email,
> I am glad there is someone on the other end of this
> email address...
> 
> again, many many thanks for your help. 
> if you ever need any help, for any testing of the
> i2c drivers, please feel free to drop me a note.
> If i have the equipment, I will be glad to help out.
> 
> again, thank you.
> -linda
>  
> 
> 
> 
>>linda wang wrote:
>>
>>>Hi,
>>>
>>>I was wondering if anyone ca help w.r.t. how to 
>>>get some 
>>>i2c chips to do what I want them to do on a 
>>>motherboard.  It isn't easy, because I
>>>spend about a month playing with various different
>>>drivers: i801.c, lm93, and my own (gem424.c) to 
>>>get it to work; but so far no total success. sigh.
>>>
>>>I am hoping with your collective expert knowlege
>>
>>base,
>>
>>>someone will have an idea how to achieve what I am
>>>about to describe.
>>>
>>>To make long story short, GEM424 is a qlogic chip
>>>that controlls backplan of a chasis.  It only
>>
>>talks
>>
>>>SAFTE through i2c.  Normally it suppose connected
>>>directly to a SATA2 controller, and through
>>>SCSI/sg, end user can communicate to this chip.
>>>However, the SATA2 controller that it needs to
>>>communicated to isn't ready yet. :( source of 
>>>the engineering chanllenge).
>>>
>>>So, the trick is to get any chip on the
>>
>>motherboard
>>
>>>to communicate to gem424, and read back what
>>
>>gem424
>>
>>>sends back.  These are what is available on
>>>the i2c bus:
>>>
>>>
>>>pc87427    lm93      |
>>>    |        |       |
>>>----------------------------- gem424
>>>        |         |  |
>>>       ICH5      IPMI|
>>>                     |
>>>
>>>So far, I was able to use ICH5[MA 0x88/SA 0x89] 
>>>(since it has a master block write interface) to 
>>>write out a fake SAFTE command to GEM424 [SA
>>
>>0x6E].
>>
>>>GEM424 will respond to the command, and in turn,
>>>responds by asserting itself as the Master and
>>>respond back a block response to the specified
>>>slave address. 
>>>
>>>However, ICH5 only has a slave interface that
>>>read in byte-mode.  Is there a way for it
>>>to read in byte by byte of what GEM424 writes
>>
>>back?
>>
>>>(question #1)
>>>
>>>Since I didn't know how to make ICH5 read in 
>>>block mode,
>>>I then found another chip on the motherboard,
>>
>>LM93,
>>
>>>which allow block read/write.  I then program
>>>ICH5 to send out the command with LM93's slave
>>>address, and have it respond back to LM93.
>>>However, LM93's blocks are pre-programmed to 
>>>read sense temp, voltage on the chip. Therefore,
>>>any attemps to write to bytes beyond normal
>>>address space are acknowledged by the LM93 but
>>>the data are ignored.
>>>
>>>With the i2c-monitor/analyser, I was able to see
>>>GEM424 responds to the command send by ICH5 to
>>>LM93.  Is there a device driver/program that i can
>>
>>>use/modify to snoop the bus and capture the
>>
>>responds?
>>
>>>(question #2)
>>>
>>>It is all I have so far, please please don't make
>>>fun of me if what I am doing doesn't make any
>>
>>sense.
>>
>>>I am hoping someone can help me... If not, please
>>>also let me know.
>>>
>>>many many thanks in advance,
>>>-linda
>>>
>>> 
>>>
>>>
>>>		
>>>
>>>
>>
>>
> 
> 
> 
> 		
> _______________________________
> Do you Yahoo!?
> Declare Yourself - Register online to vote today!
> http://vote.yahoo.com
> 
