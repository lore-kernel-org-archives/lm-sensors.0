From: Robert Hancock <hancockrwd@gmail.com>
Date: Sun, 20 Sep 2009 07:47:43 +0000
Subject: [lm-sensors] coretemp support for Core i5 CPU
Message-Id: <4AB5DE1F.1020004@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
Cc: r.marek@assembler.cz

Trying to load the coretemp driver for CPU temperature monitoring on a 
Core i5 750 CPU gives:

coretemp: Unknown CPU model 1e
coretemp: Unknown CPU model 1e
coretemp: Unknown CPU model 1e
coretemp: Unknown CPU model 1e

Looks like this model needs to be added to the list in 
drivers/hwmon/coretemp.c. Though this doesn't really seem like a very 
good approach as we'll keep having to update this driver whenever a new 
CPU model gets released. Intel has a CPUID field that indicates if the 
thermal sensor is supported: "The processor supports a digital thermal 
sensor if CPUID.06H.EAX[0] = 1." We should likely be using this instead 
of hard-coded CPU model checks..

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
