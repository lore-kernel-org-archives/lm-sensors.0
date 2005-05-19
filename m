From: KZEMBOWE@jhuccp.org (KEVIN ZEMBOWER)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Correct results for Intel CA810E mobo?
Message-Id: <sf3d0165.022@ccp2.jhuccp.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've just completed my first installation of lm-sensors, and wonder if anyone can give me any feedback on the results. I'm installing this on a homebrew computer based on an Intel CA810E motherboard (http://www.intel.com/support/motherboards/desktop/ca810e/ca2_prdoc.htm). This system is running RedHat 9 and I installed lm-sensors using the RH9 packages at http://atrpms.physik.fu-berlin.de/. 

The installation seemed to go well. One question I didn't understand was the instruction to:
To load everything that is needed, add this to some /etc/rc* file:
 
#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe smsc47m1
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

I wasn't sure which rc file to put this into, the /etc/init.d/lm-sensors file, or some other one. Any guidance on this is appreciated.

However, loading the modules manually seemed to work:
[root@rhtest root]# modprobe i2c-isa
[root@rhtest root]# modprobe smsc47m1
[root@rhtest root]# /usr/local/bin/sensors -s # recommended
-bash: /usr/local/bin/sensors: No such file or directory
[root@rhtest root]# /usr/bin/sensors -s # recommended      
[root@rhtest root]# sensors
smsc47m1-isa-0800
Adapter: ISA adapter
Algorithm: ISA algorithm
fan1:        0 RPM  (min = 5120 RPM, div = 1)          ALARM
fan2:        0 RPM  (min = 5120 RPM, div = 1)          ALARM

[root@rhtest root]# 

I was hoping to get temperature displays from the motherboard, and was disappointed that none showed up. I examined the CPU fan and saw that it only had two wires, red and black, and remember reading that only three wire fans can report their rpms.

Is this pretty much all I can expect out of this motherboard? I tried searching the archives on '810' but didn't find any references to this motherboard. I know you all say in your FAQ that you don't support motherboards, only chips. I hope this question isn't out of line.

Thanks for your thoughts.

-Kevin Zembower

-----
E. Kevin Zembower
Unix Administrator
Johns Hopkins University/Center for Communications Programs
111 Market Place, Suite 310
Baltimore, MD  21202
410-659-6139

