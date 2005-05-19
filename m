From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: tkt 1137
Message-Id: <3E6A6AC0.2000504@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

your temp1 and temp2 registers (0x20 -21) are FF. So they aren't connected
(unless there is an undocumented configuration bit that needs to be set,
but we haven't seen this problem before).
Your other temps are probably connected to a different chip.
You may wish to ask the board mfr. for connection information.

Marek Cervenka wrote:
>>Your Lm_sensors support entry has been updated.
>>
>>Please go to http://secure.netroedge.com/~lm78/support.html to check
>>the status of your entry.  
>>
>>Ticket # 1137
> 
> 
> refering to ticket 1137
> 
> [root@backupnode root]# isadump -f 0x6000
>   WARNING! Running this program can cause system crashes, data loss and 
> worse!
>   I will probe address range 0x6000 to 0x60ff.
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
> 10: 00 00 00 ff 8a ff 9e 81 00 00 00 00 00 c7 b7 81
> 20: ff ff 87 0e ca c6 c6 7f 7f 8a 00 ff 00 e7 bd e4
> 30: ba de b5 dc b4 ab d1 ab 06 c7 b7 e1 e1 c7 b7 a2
> 40: 01 12 1a 00 00 00 00 50 2d 65 00 80 00 00 00 00
> 50: 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
> 60: 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
> 70: 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> 
> other info: i have the same motherboard in other PC (with redhat 7.2 
> kernel 2.4.19 (patch) lm_sensor 2.6.5 + utils 2.7.0) 
> temperature in this PC is reported correctly
> 
