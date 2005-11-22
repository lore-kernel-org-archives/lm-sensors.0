From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Tue, 22 Nov 2005 17:49:19 +0000
Subject: [lm-sensors] Re: hwmon-vid: Unknown VRM version of your x86 CPU
Message-Id: <43834BEA.20801@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43834A86.6090205@sh.cvut.cz>
In-Reply-To: <43834A86.6090205@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,

Rudolf Marek wrote:
>>I saw this line in my logs:
>>
>>hwmon-vid: Unknown VRM version of your x86 CPU
>>
>>
>>I run a VIA Epia CL-6000E board for my firewall.
>>Could you fix the patch?
>>Can I help?
> 
> Yes give me please the cat /proc/cpuinfo
> 
> and result of "cpuid" utillity

# cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Samuel 2
stepping        : 3
cpu MHz         : 601.477
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1204.51

cpuid utility? Which/where?
It is a VIA C3 Samuel 2.

Kind regards,
Udo

