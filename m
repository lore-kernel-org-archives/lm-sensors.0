From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: clockchips via SMBus - sorry for offtopic but I can't find any
Message-Id: <40A26F36.50405@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405121723.29867.marcin_ml@sekretarka.no-ip.org>
In-Reply-To: <200405121723.29867.marcin_ml@sekretarka.no-ip.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sounds like an interesting project.

Probably the reason why there isn't such a driver is because there 
hasn't been much interest?

The drivers in our package are written by folks who wanted/needed the 
driver.  So, if you want a driver for your needs, you'll have to write 
it yourself.  If you can't, you may need to find somebody with a similar 
interest who /can/ write the driver and work with them.  Lastly, you 
could try to make someone interested in writing the driver by offering 
to pay them. ;')

I suggest you try to scrape together as much technical detail on how 
such a driver would work, and adapt a similar existing driver (like the 
icspll driver) to work for your needs.  Another idea is to try to 
reverse engineer a driver by doing a little hardware hacking to monitor 
and log what happens on the I2C/SMBus while you noodle with the settings 
under Windows (I'm not sure exactly how that would work... perhaps rig a 
parallel port connected to the I2C/SMBus?)... of course, that's assuming 
that it really is controlled over I2C/SMbus and not by, say, a CPU register.

Anyways, if you tackle the driver we'd welcome the addition to the project!


Phil

Marcin Ka?u?a wrote:

>Hello
>I searched the net quite a lot to find any information on accessing mainboard 
>PLL's under linux but couldn't find anything.
>For windows there are many programs that can change FSB and other parameters 
>without the need to reboot the PC, but they are of course closed source.
>However I can't find anything about it for linux except your's icspll driver - 
>can anybody give me any hint where to start looking for it (I'm particularly 
>interested in nforce2 PLL/ amd 2500+ barton). 
>I know there are drivers in kernel but only for mobile versions.
>Can anybody tell me where's the catch - for MS there are so many progs that 
>support so many chips and nothing for linux? Are these information not freely 
>available? too expensive to get? 
>The reason I'm looking for it is that I wanted to write some kind of 
>program/daemon that would monitor system load and if it's completely idle - 
>turn the clocks down to reduce heat production.
>Has anybody seen something like this anywhere
>Thanks for any help
>Martin
>
>  
>
