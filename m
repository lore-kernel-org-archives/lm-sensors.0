From: jon.roland@the-spa.com (Jon Roland)
Date: Tue, 23 Aug 2005 20:27:31 +0000
Subject: [lm-sensors] Processes causing CPU to overheat
Message-Id: <430B2447.6030004@the-spa.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <430A5153.2040604@linux-migration.net>
In-Reply-To: <430A5153.2040604@linux-migration.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am trying to write some scripts that would:

1. Sense when the CPU temperature rises above a preset threshold level, and if it 
does, launch a program to remedy the condition.

2. The launched program would kill the first process named "perl -w".

3. It would then sleep for some period of time, say 30 seconds, to allow time for 
the prelink process to start, which seems to always come after the perl processes, 
and which itself threatens an overheat.

4. Kill the prelink process.

Some of the scripts I have written so far:

psk:

kill `ps -ef | grep "$1" | egrep -v grep | awk '{print $2}'`

psu:

ps -ef --colsP0 | grep "$1" | egrep -v grep 2>&1 | tee `date +%y%m%d%H%M`_ps.log

soh (pseudocode):

if [overheat trigger, returns true when CPU temp > 49 C]
then
   psk "perl -w"
   sleep 30
   psk prelink
end

My problem is to figure out how to write that overheat trigger, presumably based 
on the sensors command in some way. Is there something already written that would 
do that? I have been searching for one and haven't found one yet.

It also appears there are two prelink processes, and it is the second one that 
needs to be halted. Only the first perl process needs to be killed, and it is 
distinguished by the "-w" flag.

Attached are some diagnostic log files. It is clear that the prelink process is 
luanched by anacron, but it is not clear what is launching the perl processes. I 
have manually checked the CPU fan and it shows no sign of slowing or stopping when 
the overheating condition arises.

-- Jon

----------------------------------------------------------------
Linux Migration Network   7793 Burnet Road #37, Austin, TX 78757
512/374-9585 www.linux-migration.net jroland@linux-migration.net
----------------------------------------------------------------

-- 

----------------------------------------------------------------
Starflight Corporation    7793 Burnet Road #37, Austin, TX 78757
512/374-9585 www.the-spa.com/jon.roland/  jon.roland@the-spa.com
----------------------------------------------------------------
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0508230323_sensors.log
Type: text/x-log
Size: 12967 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050823/3806f365/0508230323_sensors-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 050823_pst.log
Type: text/x-log
Size: 8169 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050823/3806f365/050823_pst-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 050823_psu.log
Type: text/x-log
Size: 1634 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050823/3806f365/050823_psu-0001.bin
