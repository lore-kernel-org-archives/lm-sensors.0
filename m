From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 21 Oct 2008 14:24:15 +0000
Subject: [lm-sensors] [PATCH] f71882fg add f71862fg support [0/3]
Message-Id: <48FDE60F.90005@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

As promised here is a cleaned up (all review comments taken into account) patch 
series to add f71862fg support to the f71862fg driver.

I've split this in a cleanup/preparation patch, the actual patch and then as 
last patch move the io to unreserved ioports from the find function to the 
probe function (where the ports are reserved). This is a slightly different 
order of patches then discussed before, but it was way easier to just split the 
previous patch and then add the io code move on top of that.

So the entire series is:

PATCH: f71882fg style cleanups and put some repeating code into functions [1/3]
PATCH: f71882fg add support for the f71862fg superio sensors [2/3]
PATCH: f71882fg move some io access from the detect to the probe function [3/3]

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
