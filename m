From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Linux driver for hardware monitor device
Message-Id: <3FD4D4F8.3080807@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FD10D50.9010008@edgedesign.us>
In-Reply-To: <3FD10D50.9010008@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

we would definitely be interested in the PCI eval card.
We'll let you know.

The EZUSB version is problematic. There is a linux EZUSB package
but that sounds like a lot more trouble than it's worth.

We do have LM90 support.

For the other new chips, we are best motivated by users asking
us for support and volunteering to test. You are welcome to
refer inquiring customers to us.

mds


Emmy Smaragda Denton wrote:

> Hi Phil,
> 
> Thanks for the quick response. We have evaluation boards available that we
> could provide free. Most of them are USB compatible via a Cypress EZUSB
> microcontroller. It comes with our Sensor eval software that is windows
> compatible. I know I know it's not Linux compatible, but that's all we
> have.
> 
> The part I'm specifically thinking about is the LM93 hardware monitor
> targeted for servers. We have an evaluation board that plugs into a PCI
> slot. It directly accesses the SMBus/Power on the mother through the slot
> or has a header to apply power/SMBus externally through jumpers. Needless
> to say that this evaluation board does not include the Cypress
> microcontoller and is not USB compatible. I've attached the LM93 datasheet
> as a first step. It will be release to our web in the next couple of weeks.
> 
> 
> We would also like to see support for the LM90 and LM99. The LM86 is
> compatible with the LM89, LM90 and LM99. There are very slight differences
> between these parts I would say the code is probably more than 95%
> compatible. We also have a new device the LM63 that has a very similar
> register set. The pin out is even somewhat compatible with the LM86 type of
> devices. The LM63 includes fan control. All the value registers of that
> device are compatible with the LM86 family of parts.
> 
> I'd be happy to answer questions or find an answer from other folks here at
> National for any of our LM sensor parts. Thanks again!
> 
> 
> Take care,
> 
> Emmy Denton
> National Semiconductor
> Temperature Sensor Applications
> 408-721-3267
> (See attached file: LM93dsV091.pdf)
> 
> 
> 
>                                                                                                                                        
>                       "Philip                                                                                                          
>                       Edelbrock"               To:       "Emmy Smaragda Denton" <Emmy.Smaragda.Denton@nsc.com>                         
>                       <phil@edgedesign.        cc:       "LM Sensors" <sensors@Stimpy.netroedge.com>                                   
>                       us>                      Subject:  Re: Linux driver for hardware monitor device                                  
>                                                                                                                                        
>                       12/05/2003 02:57                                                                                                 
>                       PM                                                                                                               
>                                                                                                                                        
>                                                                                                                                        
> 
> 
> 
> 
> 
> Hi Emmy, let me cc your information to our development team.
> 
> The best path to help us is to give us documentation, test hardware
> (eval boards, motherboards, or even computers) and an engineering
> contact we can use to answer any difficult questions we have which the
> datasheets don't address.
> 
> Which sensor chips, specificly, are you wishing to help us support?
> What materials could you provide to help us?  What usually happens is a
> person (or two) from our group will volunteer to take on a particular
> sensor chip driver you want us to support and you would ship or email
> any relevent hardware or documentation directly to them and they will do
> the work.  The more you provide/donate, the greater the incentive for a
> developer to step forward and tackle the project, of course.
> 
> Oh, and to answer your last question (if I understand it right), at some
> level there must be code which is sensor chip dependant (although that
> code could be in Bios space).  It is possible to link everything
> together and distribute it as one big binary driver file (like your
> Windows driver probably is), but we submit all of our source code in a
> very organized and modular way to make it easier to maintain and
> develop.  Does that make sense?  To the end user, they usually don't
> have to worry about how things have been organized.  They simply run
> 'sensors' and it uses the appropriate drivers to talk with the chips
> which are present on their computer.
> 
> Thanks for you mail!
> 
> 
> Phil
> 
> Emmy Smaragda Denton wrote:
> 
> 
>>Hi Phil,
>>
>>I'm the application engineer in charge of hardware monitors at National. I
>>would like to find out how to get you to support some of our devices that
>>are new and not listed on your site.
>>
>>We have a new device that is targeted for servers and we have been getting
>>quite a few requests for a Linux driver. If you could give me some insight
>>on what the best path for me to take I would greatly appreciate it.
>>
>>We currently have a windows driver that supports all of our devices, it is
>>not sensor device dependent. I was wondering why is the Linux sensor
> 
> driver
> 
>>device dependent?
>>
>>Thanks in advance for any help you can give me!!
>>
>>Take care,
>>
>>Emmy Denton
>>National Semiconductor
>>Temperature Sensor Applications
>>408-721-3267
>>
>>
>>
>>
>>
> 
> 
> 
> 
> 
> 

