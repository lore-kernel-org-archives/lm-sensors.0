From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: w83792d_driver-1.0.1.patch: Winbond W83792D driver for linux-2.4
Message-Id: <4237B5CE.8020604@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE245CA3@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Huang0@Winbond.com.tw wrote:
> Hi MDS
> 
> Yes, I can get the file you provided, but since I have started the modifications,
> I will use the one from web CVS, after deleting the line numbers, it is same as
> the one you provided, I compared them with "diff" :-)
> 
> I have one question here:
> I add W83792D_ALARM_* into 792 driver like this:
> (please refer to the data sheet)
> #define W83792D_ALARM_IN0 0x0001
> #define W83792D_ALARM_IN1 0x0002
> #define W83792D_ALARM_TEMP1 0x0004
> #define W83792D_ALARM_TEMP2 0x0008
> #define W83792D_ALARM_TEMP3 0x0010
> #define W83792D_ALARM_FAN1 0x0020
> #define W83792D_ALARM_FAN2 0x0040
> #define W83792D_ALARM_FAN3 0x0080
> #define W83792D_ALARM_IN2 0x0100
> #define W83792D_ALARM_IN3 0x0200
> #define W83792D_ALARM_IN4 0x0400
> #define W83792D_ALARM_IN5 0x0800
> #define W83792D_ALARM_IN6 0x1000
> #define W83792D_ALARM_CHAS 0x2000
> #define W83792D_ALARM_FAN7 0x8000
> #define W83792D_ALARM_IN7 0x80000
> #define W83792D_ALARM_IN8 0x100000
> #define W83792D_ALARM_FAN4 0x200000
> #define W83792D_ALARM_FAN5 0x400000
> #define W83792D_ALARM_FAN6 0x800000
> 
> Can I replace the last 6 items with ?
> #define W83792D_ALARM_FAN7 0x4000
> #define W83792D_ALARM_IN7 0x8000
> #define W83792D_ALARM_IN8 0x10000
> #define W83792D_ALARM_FAN4 0x20000
> #define W83792D_ALARM_FAN5 0x40000
> #define W83792D_ALARM_FAN6 0x80000
> 
> With one is better? The first one or the latter?
> Are them same?
> 
> 
> Thanks
> Best Regards
> 
> Chunhao

the easiest is to form the alarms word directly from the three registers: pseudocode below
alarms=read(0x41) | (read(0x42) << 8) | (read(0x9b) << 16)
so the first one is better.
