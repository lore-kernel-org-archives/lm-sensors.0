From: frank.beesley@aeroflex.com (Frank Beesley)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: driver for mic184 chip
Message-Id: <41FE48E5.10700@aeroflex.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41FAB35E.1050208@aeroflex.com>
In-Reply-To: <41FAB35E.1050208@aeroflex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Mark,
>
>  
>
>>since MIC184 has TWO sensors, it should not be added to lm75 IMHO.
>>We shouldn't add a second sensor to the lm75 driver.
>>    
>>
>
>It doesn't really have two sensors. It simply can use an external sensor
>*instead of* the internal one. It cannot use both at the same time. It
>is certainly possible to design a driver that continuously switches from
>internal to external and back, but that would require a clever timing
>and I don't think it's worth the effort. The chip is simply not designed
>for this use. I invite you to consider all the drawbacks of such a
>design (delayed interrupt response to overtemperature, need to have the
>same overtemperature and hysteresis temperature for both "channels",
>impossibility to know which "channel" caused an alarm/interrupt, and
>possibly more bad surprises if we were to really write such a driver).
>
>Anyway, I don't think that Frank was interested in this - the mic184.c
>driver he proposed would only export one set of sysfs files.
>
>Thanks,
>  
>
Jean - I guess I sent one version back that did not have the correct set 
function. That appears to be the only thing different with my latest 
version. Thats what happens when you pull from a development machine 
instead of cvs.

Your summary seems to pretty much correct. That's fine. If anybody is 
looking for this driver in the future, let me know as we will continue 
to use it ourselves. You did have some good tips that were are going to 
evaluate.

As far as our target, it is a Kontron CPU module on a custom carrier 
board. The carrier then connects to a PCI based backplane that has i2c, 
onewire, pci, cplds, fpgas, multiple ps2 keypads, and other fun 
hardware. Currently we are running a 2.4.25 (Redhat 9 based) kernel and 
I am migrating to a 2.6.9 (or later, may go to 10 or 11) kernel.
