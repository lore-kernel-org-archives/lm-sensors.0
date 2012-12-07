From: Jaromir Capik <jcapik@redhat.com>
Date: Fri, 07 Dec 2012 14:52:47 +0000
Subject: [lm-sensors] [RFE] ARM/OMAP4 temperature sensor support
Message-Id: <2095681616.44463223.1354891967908.JavaMail.root@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.

I'd like to ask you to introduce the OMAP4 temp sensor
support in lm_sensors.
I found the following source code, that seems to work
correctly with my OMAP4 cpu.

http://hardwarebug.org/files/omap4_temp.c

It seems it uses /dev/mem for reading the sensor output.
Please, let me know. I'm always willing to test the changes.

Thanks in advance.

Regards,
Jaromir.


--
Jaromir Capik
Red Hat Czech, s.r.o.
Software Engineer / BaseOS

Email: jcapik@redhat.com
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purkynova 99/71, 612 45, Brno, Czech Republic
IC: 27690016 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
