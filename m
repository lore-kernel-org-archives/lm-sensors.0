From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: SMBus/I2C Drivers (for XBox-Linux)
Message-Id: <20020904101625.P16408@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi, I made some comments below:

On Wed, Sep 04, 2002 at 01:20:56PM +0200, Michael Steil wrote:
> > Hi, I was browsing the XBox-linux email archive and noticed the
> > discussion of I2C/SMBus support a few times.  I cofounded Lm_sensors a
> > few years ago, and we've also become the maintainer for the I2C
> > project.  Our I2C project is standard in the Linux kernel, and soon
> > our sensors half will be, too.
> 
> Excellent! It's really great you contact us, we were considering 
> contacting you.
> 
> > The sensors half of the project (lm_sensors) includes drivers for
> > SMBus hosts, eeproms, temperature sensors, etc.  Perhaps this would
> > give you a jump start in your project?  In any case, if you'd like to
> > get your code included in the kernel, it would most likely need to
> > merge with ours.  We may be able to short-cut that process by working
> > together from the get-go.
> >
> > Let me know how we can assist.
> 
> Definitely. I have seen that lm_sensors containes nForce SMBus 
> controller support from 2.6.4 on (kernel/busses/i2c-amd756.c). The 
> vendor and device id of the Xbox SMBus controller are the same, and a 
> look into the source told us that your code will certainly work for us 
> out of the box.

Hopefully it works, sounds like it should.

I suggest you grab our code from CVS (see our download page on our
site for instructions www.lm-sensors.nu).

> The Xbox has some devices connected through the SMBus:
> * The PIC, a 16 bit microprocessor handling the buttons, the DVD eject 
> function and the video connector. We plan to write a driver for this 
> device making use of your I2C modules.

If you know the protocol, then it should be cake.  You could either 
start a new chip driver for it, or write a user-space app which 
communicates with it via /dev/i2c-? files.

> * The Conexant video encoder. We're working with existing sources to 
> control the Conexant, I (personally) don't know whether they use the 
> kernel I2C intrastructure. If they don't, we plan to rewrite these parts.

OK.  There are a number of existing drivers for the BT### chips 
(depending upon the chip).  I wrote one for the BT869 a while back.  I 
think most if not all (especially those accepted into the kernel) work 
off our I2C stack.

> * A temperature sensor (ADM1032). I don't think lm_sensors already 
> contains code for this one, although similar chips are already there. 
> Anyway, the kernel won't have to support it, because the PIC already 
> takes care of shutting the system down, if it gets too hot.

The ADM1032 is compatible with an existing driver we have, I believe.

> * A 256 bytes serial EEPROM. Your code should work for us. I have just 
> one question: How can applications access the eeprom? We're thinking 
> about /dev/eeprom and /proc/xbox/eeprom.txt - do you think this would be 
> practical?

Yeah, the eeprom driver should work for you.  BTW- A word about 
interfaces: There are three ways to grab data from an I2C/SMBus chip, 
1) through a driver's /proc files (all our files are in 
/proc/sys/dev/sensors), 2) Through library routines (libsensors), and 
3) through a more 'raw' interface via the /dev/i2c-* files.

> A different question: I haven't had a thorough look into your code yet - 
> can drivers using i2c-amd756 register to receive interrupts issued by 
> the SMBus controller? The PIC includes some watchdog functions (the box 
> gets reset/turned off when the eject or power button gets pressed and 
> the CPU does not respond to the I2C message), and it would of course be 
> better to add interrupt handlers than do polling.

Good question.  I'm not sure how best to address that, or which
interrupt to use or who would listen to it.  Perhaps if a PIC
monitoring daemon were written, and listened to that interrupt.  It
could check that PIC status (either directly via /dev/i2c-*, or by a
chip driver) when it received an interrupt.  I don't believe that the
i2c-amd756 lists to an interrupt... and I'm not sure what it would do
if we configured it to... it would need to punt that to something else
(probably a user-space app) to do something about it (like shutdown
the system).

> Thanks for your time. We'll forward all mailing list posts on this topic 
> to you, if you wish.

OK, that sounds fine.


(from a later email:)
> > /proc/bus/smbus/* would fit better, i think.                                
> 
> Perhaps Phil can settle this... the difference between SMB and 
> I2C... as I understand it everything is I2C in the box. 

We keep general bus info in /proc/bus/i2c-*.  E.g.:

[root@Dust-Puppy /etc]# cat /proc/bus/i2c
i2c-0	smbus    	SMBus PIIX4 adapter at 1040     	 Non-I2C SMBus adapter           
[root@Dust-Puppy /etc]# cat /proc/bus/i2c-0   
50	EEPROM chip                     	EEPROM READER                   
51	EEPROM chip                     	EEPROM READER                   

Interactions with the chips on the busses are done in 
/proc/sys/dev/sensors:

[root@Dust-Puppy sensors]# cd /proc/sys/dev/sensors
[root@Dust-Puppy sensors]# ls -l 
total 0
-rw-r--r--    1 root     root            0 Sep  4 09:58 chips
dr-xr-xr-x    2 root     root            0 Sep  4 09:58 eeprom-i2c-0-50
dr-xr-xr-x    2 root     root            0 Sep  4 09:58 eeprom-i2c-0-51

[root@Dust-Puppy sensors]# cat chips
256	eeprom-i2c-0-50
257	eeprom-i2c-0-51

The differences between I2C and SMBus are minor.  There are some
differences in the ranges of supported bus voltages and timings, but
most I2C chips work happily on SMBuses.  Here's a quick breakdown on
the differences:

http://dbserv.maxim-ic.com/appnotes.cfm?appnote_number56


Phil

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
