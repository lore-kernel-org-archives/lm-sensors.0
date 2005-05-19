From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: sensors on Athlon 1000 and Asus A7V VIA KT133
Message-Id: <3CBC78B6.1E2C8F4D@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000c01c1e2ff$a9e96e30$0700a8c0@ibammer>
In-Reply-To: <000c01c1e2ff$a9e96e30$0700a8c0@ibammer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> "Dr. Markus Ammer, Ingenieurb?ro Ammer" wrote:
> 
> Hello,
> 
> System :Athlon 1000 system (motherboard Asus A7V VIA KT133)
> Sensor: as99127f
> OS    SuSE Linux 7.2, Kernel 2.4.16
> sensors version 2.6.0
> 
> 
> 1) sensors-detect does not work correctly.

known problem with Asus boards.

> 
> 
> 2) temp2 (CPU) obviously is double the raw value.
> LVCool-Idle loop   temp2 = 35,5?C (BIOS)  18 (raw) (36?C WinNT)
> 100% load          temp2 = 50?C   (BIOS)  25 (raw) (50?C  -"- )
> 

fix in sensors.conf.


> 
> 3) I do "modprobe w83781d" in a startup script  Is there a devicename /dev/xyz which is connected from sensors ? 
> 

no, sorry, there isn't.
