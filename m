From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [Fwd: PATCH: bmcsensors and i2c-ipmi port to 2.6]
Message-Id: <4057BD5F.6020505@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4056FCE9.2020904@utsc.utoronto.ca>
In-Reply-To: <4056FCE9.2020904@utsc.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the submission.
hopefully you can figure out a way to generate the sysfs entries dynamically.
The static generation is unfortunate. Perhaps Greg could help us here.
Also I got mail from one person who had 70 sensors on his BMC.

I'm not running 2.6 on my BMC machine but I may try to backport the write code
and test it on 2.4.

We've recently changed the sysfs naming convention (from temp_min1 to temp1_min,
for example), so we'll need the naming reworked.

mds



Yani Ioannou wrote:
> Hi, attached is my e-mail to the author of the bmcsensors and i2c-ipmi 
> driver (*Mark D. Studebaker*), I realized I probably should have CCed 
> the original message to the lm-sensors development team as a whole.
> 
> Thanks :-),
> Yani
> 
> ------------------------------------------------------------------------
> 
> Subject:
> PATCH: bmcsensors and i2c-ipmi port to 2.6
> From:
> Yani Ioannou <yanii@utsc.utoronto.ca>
> Date:
> Mon, 15 Mar 2004 11:36:32 -0500
> To:
> "M. Studebaker" <mdsxyz123@yahoo.com>
> 
> 
> Hi,
> 
> As the kernel newbie faq puts it I've been "pissing in your pool" :-P so 
> I thought it best to contact you. I love the 2.6 kernel but I also loved 
> being able to read the sensors off my HP workstation x4000's IPMI BMC, 
> so I took to porting the driver to 2.6/sysfs. I seem to have been fairly 
> successful, although this could definitely do with some more testing on 
> different hardware.
> 
> First of all I'd like to thank you immensely for writing the driver :-) 
> I was very pleased beyond words when I could finally use the IPMI BMC on 
> my motherboard to see my sensors readings, although ironically with my 
> motherboard I can't read 13 voltage, fan and temperatures sensors but 
> not the CPU temperatures! I think being one of the first IPMI 1.0 
> implementations they messed up the smbus, the adm1021 driver doesn't 
> seem to be able to read the Xeon's temps either.
> 
> Attached you will find a patch for kernel 2.6.4-rc2. My main problems 
> porting the driver were in the ability of a BMC to have any number of 
> sensors (or up to 50 as set in your driver). The sysfs show and store 
> callbacks (more specifically the device.h implementation of it) do not 
> appear to provide the ability to pass any information other than the 
> device struct (and the buffer to write into), and thus making a single 
> callback that can work for all sensors turns out to be impossible as far 
> as I can see. Unfortunately (just as with the other ported sensor 
> drivers) I had to create static functions for each sensor id, (i.e. 
> 50!). In the other sensor drivers this is usually only a maximum of 8, 
> so it is not as pronounced. It would make sense to me for the show and 
> store callbacks of device.h to include information on the file that the 
> specific call pertains to (just as the base sysfs implementation does).
> 
> Note also that I implemented code to allow the setting of the thresholds 
> for the sensors, but on writing it I found that my BMC doesn't support 
> this, hence they have had no testing whatsoever, and obviously need to 
> be tested on the appropriate hardware. Further improvements that I 
> didn't get around to are creating the sysfs entries for hysteresis 
> thresholds, and of course the driver still only works for one BMC.
> 
> I'd be very grateful if you could test out the patch, and if possible 
> test the driver more throughly on other IPMI implementations.
> 
> Thanks,
> Yani
