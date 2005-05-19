From: monmotha@indy.rr.com (MonMotha)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: PCA9555 Driver
Message-Id: <3F04C903.1070303@indy.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was curious if any work had been done on a Phillips PCA9555 driver.  It's not 
listed anywhere on the new drivers page, but the developer docs reccomended 
asking first to make sure we don't have two people both simultaneously working 
on the wheel.

This is a rather simple Phillips chip that provides 16 GP totem-pole 
inputs/outputs.  It's not quite as simple as the PCF8574 (it actually has config 
registers, GASP!), but should be quite doable.

If there's no driver written or in progress, I can go ahead and write one. 
Though pointers on where to look for examples/general docs would be useful.  Due 
to it's similar functionality, I was going to use the PCF8574 driver as a 
template, referring to other drivers to keep the general structure the same.

Please CC me in any replies if this is a reply-to list list as I'm not on the 
list (well, how many times can we use the word "list" in one sentence?)

--MonMotha
