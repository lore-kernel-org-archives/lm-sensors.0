From: Jaromir Capik <jcapik@redhat.com>
Date: Tue, 27 Mar 2012 15:19:47 +0000
Subject: [lm-sensors] [PATCH] sensors-detect : PCI bus is always required even if it might be missing on some
Message-Id: <c838afb8-7576-42c2-abf6-ea56ca84daa3@zmail15.collab.prod.int.phx2.redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello guys.

I was trying to autodetect sensors on my ARM based device (PandaBoard).
This board doesn't have a PCI bus, but the sensors-detect script
always expect one and then fails with the following message:

/sys/bus/pci/devices: No such file or directory at ./sensors-detect.bak line 2895.

The attached patch should avoid dying and returns empty PCI device list instead.

Please, check it and eventually merge it to trunk.

Thanks in advance.

Regards,
Jaromir Capik.

--
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
