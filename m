From: lcampagn@mines.edu (Luke Q Campagnola)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: module not found?
Message-Id: <20020319152506.62cfadfe.lcampagn@mines.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am running Debian/Woody, kernel 2.4.17 .. I'm having a problem finding a module I need. Here's some of my sensors-detect output: 

Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801BA ICH2
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): 
modprobe: Can't locate module i2c-i801
Loading failed ()... skipping.


Despite much effort, I can not seem to locate this module anywhere. I have tried installing the most recent source, which didn't help. I was unable to find anything that would tell me the location of the driver in your FAQ or install docs, as well as the kernel documentation. I did find i2c-i801 on your drivers page, but again, that does not tell me where to get the driver. Does this driver come with the kernel, and if so, where is it located in the configuration? Does it come with your software? 


Very Confused, 

Luke 
