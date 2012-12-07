From: Jaromir Capik <jcapik@redhat.com>
Date: Fri, 07 Dec 2012 15:34:47 +0000
Subject: Re: [lm-sensors] [RFE] ARM/OMAP4 temperature sensor support
Message-Id: <1164653817.44488990.1354894487972.JavaMail.root@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2095681616.44463223.1354891967908.JavaMail.root@redhat.com>
In-Reply-To: <2095681616.44463223.1354891967908.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please, hold on.

It seems the mentioned source works for OMAP4430 only.
Moreover I found some articles mentioning that the temperature
can be read via the following files:

cat /sys/class/hwmon/hwmon0/device/temp1_input
-OR-
cat /sys/bus/platform/devices/temp_sensor_hwmon.0/temp1_input 

but the directories are empty in my case and I need to
figure out what kernel switches/modules are needed.

Sorry for false alarm.

Jaromir.


--
Jaromir Capik
Red Hat Czech, s.r.o.
Software Engineer / BaseOS

Email: jcapik@redhat.com
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purkynova 99/71, 612 45, Brno, Czech Republic
IC: 27690016 


----- Original Message -----
> From: "Jaromir Capik" <jcapik@redhat.com>
> To: lm-sensors@lm-sensors.org
> Sent: Friday, December 7, 2012 3:52:47 PM
> Subject: [RFE] ARM/OMAP4 temperature sensor support
> 
> Hello.
> 
> I'd like to ask you to introduce the OMAP4 temp sensor
> support in lm_sensors.
> I found the following source code, that seems to work
> correctly with my OMAP4 cpu.
> 
> http://hardwarebug.org/files/omap4_temp.c
> 
> It seems it uses /dev/mem for reading the sensor output.
> Please, let me know. I'm always willing to test the changes.
> 
> Thanks in advance.
> 
> Regards,
> Jaromir.
> 
> 
> --
> Jaromir Capik
> Red Hat Czech, s.r.o.
> Software Engineer / BaseOS
> 
> Email: jcapik@redhat.com
> Web: www.cz.redhat.com
> Red Hat Czech s.r.o., Purkynova 99/71, 612 45, Brno, Czech Republic
> IC: 27690016
> 
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
