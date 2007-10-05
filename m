From: Stian Jordet <liste@jordet.net>
Date: Fri, 05 Oct 2007 07:53:20 +0000
Subject: [lm-sensors] ipmisensors almost working...
Message-Id: <4705ED70.6080206@jordet.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

after great help from Corey Minyard and Andrew Cress, I finally got 
ipmi_si working on my SC450NX system :)

I'm now (trying) to use Yani Ioannou's ipmisensors module 
(http://bmcsensors-26.sourceforge.net). It's working, and I get mostly 
sensible values. But there are some problems.

For instance, here is a output from sensors (from lm-sensors)

bmc-isa-0003
Adapter: ISA adapter
SCSI-N Volt:
           +1.33 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard 1.5V:
           +1.98 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard 2.5V:
           +1.98 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard 3.3V:
           +1.87 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard 12V:
           +3.06 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard 5V:
          +15.61 V  (min =  +0.00 V, max =  +0.00 V)
Baseboard -12V:
           +4.79 V  (min =  +0.00 V, max =  +0.00 V)
PwrShare Fan 3:
          4740 RPM  (min =    0 RPM)
PwrShare Fan 2:
          2610 RPM  (min =    0 RPM)
PwrShare Fan 1:
          2520 RPM  (min =    0 RPM)
Baseboard Fan 6:
          2640 RPM  (min =    0 RPM)
Baseboard Fan 7:
          2700 RPM  (min =    0 RPM)
Baseboard Fan 8:
          2850 RPM  (min =    0 RPM)
Baseboard Fan 5:
          2910 RPM  (min =    0 RPM)
Baseboard Fan 3:
          2730 RPM  (min =    0 RPM)
Baseboard Fan 4:
          2970 RPM  (min =    0 RPM)
Baseboard Fan 1:
          2730 RPM  (min =    0 RPM)
PwrShare Temp:
           -12.8 C  (high =    +0 C, hyst =    +0 C) 
Processor 4 Temp:
           +61.0 C  (high =    +0 C, hyst =    +0 C) 
Processor 3 Temp:
           +27.0 C  (high =    +0 C, hyst =    +0 C) 
Processor 2 Temp:
           +27.0 C  (high =    +0 C, hyst =    +0 C) 
Processor 1 Temp:
           +26.0 C  (high =    +0 C, hyst =    +0 C) 
Basebrd PXB Temp:
           +26.0 C  (high =    +0 C, hyst =    +0 C) 
Basebrd PCI Temp:
           +31.0 C  (high =    +0 C, hyst =    +0 C) 

It mostly makes sense, except for the voltages and the PwrShare temp and 
Processor 4 temp. But when I disconnected the fan marked 4 on my system, 
the sensors command showed "Baseboard Fan 1: 0 RPM", while the command 
"ipmiutil sensor" correctly said that Baseboard Fan 4 had 0 rpm (or it 
actually said: 80000000.00 instead of the usual 80000182.00). I 
experimented a little more, and found this:

ipmiutil sensor         lm-sensors
------------------------------------------------------------------
Baseboard Fan 1         (not listed...)
Baseboard Fan 2         SCSI-N Volt (!!!)
Baseboard Fan 3         Baseboard Fan 4
Baseboard Fan 4         Baseboard Fan 1
Baseboard Fan 5         Baseboard Fan 3
Baseboard Fan 6         Baseboard Fan 7
Baseboard Fan 7         Baseboard Fan 8
Baseboard Fan 8         Baseboard Fan 5
PwrShare Fan 1          Baseboard Fan 6
PwrShare Fan 2          PwrShare Fan 1
PwrShare Fan 3          PwrShare Fan 2


Because of obvious reasons, the fans were the only thing I could 
disconnect to see what would happen. Hard to do that with voltages and 
temperatures. The table means that when I disconnected baseboard fan 4 
(it's marked on the pcb), the command ipmiutil sensor shows me that 
baseboard fan 4 has 0 rpm. But the sensors command from lm-sensors 
(which uses the ipmisensors module) show that baseboard fan 1 has 0 rpm! 
And even stranger, when I disconnect Baseboard fan 2, lm-sensors says 
that my SCSI-N Volt is 0 volts! Obviously there must be some errors 
here. For instance, the PwrShare Temp looks very much like it should 
have been the Baseboard -12V sensor...

I guess I'll have to hope Yani will look at this, but if someone else 
have an idea, I'd be very grateful!

Regards,
Stian

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
