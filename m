From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: CVS?
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD4405648562@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440564855E@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440564855E@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> > I know all the fun stuff is happening on BK for the 2.6 kernels, but
> > sadly I'm still stuck working on 2.4.
> 
> Same here ;) BK is just too frightening at the moment.

Glad I'm not alone :)

> 
> > I've been working on other stuff for a while, but now I have a new
> > sensor to code up for the 2.4.20 kernel. I tried to do a 
> CVS update to
> > get the latest sensors for 2.4, but got a timeout:
> > 
> > cvs [update aborted]: connect to
> > cvs.lm-sensors.nu(206.228.191.162):2401 failed: Connection timed out
> > 
> > The machine is still there (I can ping it). Is the CVS 
> server down, or
> > with the new development on BK has it just been stopped? 
> The downloads
> > page of the web site indicates that it is still there.
> 
> The server is still up and the CVS service listening. Works 
> for me right
> now. Just retry, you might just have tried at a wrong moment.

Still failing, same symptom - I've tried a few times in the last
24 hours.

I'm now wondering if our IS people have added some port filters
to the firewall since last time I accessed it. I'll check with them - 
and maybe try accessing outside the firewall. Don't kick anything
until I can find out.

> 
> Which driver are you going to work on?
> 

It's a device on some OEM PC cards we're using. I think it's a 
custom device, probably implemented in an FPGA on the card, 
which does watchdog and alarm functions. I only have poor 
data on it and what I have does not mention any chip number. 
I don't recognize it as any standard chip.

Sensors-detect sees it (at address 0x7C) but cannot identify it.
The documentation calls it "Embedded PCI-X On Board Registers".
Does that mean anything to anyone?

I have the manufacturer's docs here, but annoyingly with a 
confidentaility notice on it. I haven't been able to find 
the same document on the internet for reference. In fact,
I can't even find the exact card we are using on their web
site, but it is similar to this one:

	http://www.forcecomputers.com/binary/files/CPCI-745.pdf

The i2c device in question is the "watchdog unit" mentioned on
page 3. (Don't bother following the link - it says nothing more
that that!)

Once I get the driver done I will offer it back to the community,
though whether the community will actually want it is a different
matter :-)

John.
