From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Jun 2011 19:43:49 +0000
Subject: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <20110616194349.GE19833@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
In-Reply-To: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 16, 2011 at 03:03:09PM -0400, everythingsfree@lineone.net wrote:
> Thanks for the fast response, replies to your questions are below...
> 
> 
> >----Original Message----
> >From: guenter.roeck@ericsson.com
> >Date: 
> 16/06/2011 19:39 
> >To: "everythingsfree@lineone.net"
> <everythingsfree@lineone.net>
> >Cc: "lm-sensors@lm-sensors.org"<lm-
> sensors@lm-sensors.org>
> >Subj: Re: [lm-sensors] Gigabyte GA-D525 core 
> temps N/A?
> >
> >On Thu, Jun 16, 2011 at 02:21:21PM -0400, 
> everythingsfree@lineone.net wrote:
> >> Hi,
> >> 
> >> I'm running Ubuntu 
> Server 10.4 LTS (64 bit) on a Gigabyte GA-D525 
> >> board and have 
> downloaded, built and installed the latest version of lm-
> >> sensors 
> (using 'sensors -v' it reports 'sensors version 3.3.0 with 
> >> 
> libsensors version 3.3.0'), as far as I can tell I've done this 
> >> 
> correctly.
> >> 
> >> I ran 'sensors-detect' and answered all of the 
> questions 
> >> and let it do its thing.
> >> 
> >> On checking what gets 
> reported through 
> >> 'sensors' I get the following which appears to be 
> failing to report the 
> >> temperatures of the cores  (I also wonder why 
> it's attempting to report 
> >> four when it's only a dual core 
> processor) although I do get some 
> >> temperatures at the bottom:
> >> 
> 
> >> 
> >> coretemp-isa-0000
> >> Adapter: ISA adapter
> >> 
> >> Core 
> 0:           N/A  (crit = +100.0°C)
> >> 
> >> coretemp-isa-0001
> >> 
> Adapter: 
> >> ISA adapter
> >> Core 1:           N/A  (crit = +100.0°C)
> 
> >> 
> >> coretemp-isa-
> >> 0002
> >> Adapter: ISA adapter
> >> Core 
> 2:           N/A  (crit = +100.0°C)
> >> 
> >> 
> >> coretemp-isa-0003
> >> 
> Adapter: ISA adapter
> >> Core 3:           N/A  (crit = 
> >> +100.0°C)
> 
> >> 
> >Your CPU may support hyperthreading. Older versions of the driver 
> 
> >don't take this into account.
> >
> 
> It's an Intel Atom D525 which 
> according to the specs does support hyperthreading, I did think that 
> may have been why.
> 
> 
> >> it8720-isa-0290
> >> Adapter: ISA adapter
> >> 
> in0:          +1.10 V  
> >> (min =  +0.00 V, max =  +4.08 V)
> >> 
> in1:          +1.52 V  (min =  +0.00 
> >> V, max =  +4.08 V)
> >> 
> in2:          +3.31 V  (min =  +0.00 V, max =  +4.08 
> >> V)
> >> 
> in3:          +2.98 V  (min =  +0.00 V, max =  +4.08 V)
> >> 
> >> 
> in4:          +3.09 V  (min =  +0.00 V, max =  +4.08 V)
> >> 
> in5:          
> >> +4.08 V  (min =  +0.00 V, max =  +4.08 V)  ALARM
> >> 
> in6:          +4.08 V  
> >> (min =  +0.00 V, max =  +4.08 V)  ALARM
> >> 
> in7:          +2.18 V  (min =  
> >> +0.00 V, max =  +4.08 V)
> >> 
> Vbat:         +3.06 V
> >> fan1:        3857 RPM  
> >> (min =    0 RPM)
> >> 
> fan2:           0 RPM  (min =    0 RPM)
> >> temp1:        
> >> -55.0°C  
> (low  = +127.0°C, high = +127.0°C)  sensor = thermistor
> >> 
> >> 
> temp2:        +64.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = 
> 
> >> thermistor
> >> temp3:        +30.0°C  (low  = +127.0°C, high = +127.
> 0°
> >> C)  sensor = thermal diode
> >> cpu0_vid:    +1.850 V
> >> 
> >> From 
> what I 
> >> understand 'coretemp' is reporting the core temperatures and 
> the other 
> >> stuff is from'it87' (these are also in '/etc/modules')
> 
> >> 
> >Yes.
> >
> >> I also noticed 
> >> that someone else has reported what 
> appears to be a similar or the same 
> >> problems with this board back 
> in April (http://lists.lm-sensors.org/pipermail/lm-sensors/2011-April/032332.html
> >> , oddly they only got two core temperature reading attempts.
> >> 
> 
> >Newer kernel version, most likely.
> >
> >No idea what is going on. You 
> might try to build and compile the latest
> >version of the coretemp 
> driver to see if it improves the situation.
> >You can download it from http://roeck-us.net/linux/drivers/coretemp/.
> >
> 
> Sadly that may be where my knowledge of building things under Ubuntu 
> (or any Linux) falls somewhat flat.  I'll take a look on-line for how 
> to do it but if you can quickly let me know that'll make the turn 
> around faster.
> 
Download the two files into some directory, then run "make" in it.
You may have to install the linux-headers package first, and possibly
the C compiler (gcc) and/or make.

After make succeeds, run "sudo make install" followed by "sudo modprobe -r coretemp"
and "sudo modprobe coretemp".

Something like

mkdir coretemp
cd coretemp
wget http://roeck-us.net/linux/drivers/coretemp/coretemp.c
wget http://roeck-us.net/linux/drivers/coretemp/Makefile
sudo apt-get install make 				# if necessary
sudo apt-get install gcc 				# if necessary
make
# Note: make will likely fail and tell you the missing headers, such as 
#make: *** /usr/src/linux-headers-2.6.35-25-server: No such file or directory.  Stop.
#make: *** [modules] Error 2
sudo apt-get install linux-headers-2.6.35-25-server	# or whatever linux version you run
make
sudo make install
sudo modprobe -r coretemp
sudo modprobe coretemp

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
