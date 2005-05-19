From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors without modules in the kernel
Message-Id: <1063713780.3f66fbf4bd9fc@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0309101108420.19605-100000@web0.speakeasy.net>
In-Reply-To: <Pine.LNX.4.44.0309101108420.19605-100000@web0.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I completely realize my error once I actually tried a kernel with module 
> support. While the drivers I did have loaded loaded just fine and seemed 
> like it should work it didn't. The reason was apparent once I enabled 
> modules support and ran sensors-detect it detected that I have the 
> i2c-nforce2 rather than the i2c-amd756 which I thought would work for my 
> motherboard (ASUS A7N8X Deluxe). Considering that there isn't a driver 
> available for this sensor yet, certainly explains why the program would 
> not detect the sensors, and why it doesn't work on my system.

Looks like you don't fully understand how things work. Neither i2c-nforce2 nor
i2c-amd756 are enough to monitor your system. They are *bus* drivers, required
for *chipset* drivers to "plug" on. It is normal that sensors doesn't return
anything if only a bus driver, but no chip driver, is loaded.

What's more, contrary to what you seem to think, there is a driver for the
nforce2, providing you use a recent enough version of lm_sensors. Our
sensors-detect script should detect it, load the module if needed, and then
proceed to the chipsets detection.

If you're still confused, you may provide a complete log of your sensors-detect
run, so that we better understand what happens.

Jean Delvare


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
