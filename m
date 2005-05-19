From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: negative voltages in linux 2.6
Message-Id: <4004B1AD.9000907@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040110194936.3fb3d947.khali@linux-fr.org>
In-Reply-To: <20040110194936.3fb3d947.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the w83781d and friends appear to be swapped in sysfs AND in the sensors output:
another bug in the drivers?

w83627hf-i2c-0-2c
Adapter: SMBus AMD756 adapter at 80e0
Algorithm: Unavailable from sysfs
..
-12V:     -12.11 V  (min = -10.88 V, max = -13.18 V)              


Jean Delvare wrote:
> Hi all,
> 
> With Linux 2.6 (.0 and .1 alike) the negative voltages limits seem to be
> swapped. They are displayed correctly by sensors, but inside the chip
> they are swapped (as seen by reading from sysfs directly), causing
> alarms to trigger. This is with an as99127f, don't know if this applies
> to other drivers/chips as well.
> 
> Does anyone observe similar problems?
> 
> What could be the cause of it? I took a quick look at the w83781d driver
> in Linux 2.6.1 and did not find anything suspect there - but that was
> admittedly a very quick look.
> 
