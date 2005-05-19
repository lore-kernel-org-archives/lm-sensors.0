From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Fwd: lm_sensors: initial port of i2c chip driver vt8231 to kernel
Message-Id: <40C66FE0.4010104@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

great. when you have something that looks good to you please send it to our mailing list.


> Subject:
> lm_sensors: initial port of i2c chip driver vt8231 to kernel 2.6
> From:
> Roy Thompson <roy@haematic.org>
> Date:
> Fri, 04 Jun 2004 12:04:35 +0100
> To:
> mdsxyz123@yahoo.com
> 
> 
> Hi Mark,
> 
> I have an Epia 800 board and having recently upgraded to kernel 2.6, I
> felt enspired to porting the vt8231 driver from current lm_sensors CVS
> to kernel 2.6.6, since from lm_sensor mailing list it did not appear
> that anyone else had tried to do this yet.
> 
> I basically copied what you have done for the via686a driver.
> I've got it sort of kind of working, I can modprobe it and stuff appears
> in /sys and the sensors program shows stuff, although it doesn't all
> seem terribly correct.  The voltages appear out by a magnitude of 10,
> although the processor temp seems vaguely correct (i.e. what I got with
> 2.4 kernel!).
> 
> You can get what I've done from http://www.haematic.org/vt8231.c
> 
> There are a couple of todo's in there still - I haven't done the VRM and
> VID bits yet, since the via686a didn't have these.  I'll give them a go
> soon, probably based on the ones in lm*.c.  I am sure there are other
> things I have missed too.
> 
> I am still using the sensors.conf I used with kernel 2.4/CVS sensors, I
> don't know whether this would need adjusting for 2.6.
> 
> I am happy to carry on and would like to see this driver in 2.6 kernel,
> so would appreciate any feedback.  I am not on the lm_sensors list, but
> keep an eye on it from the archives.
> 
> regards,
> Roy Thompson
