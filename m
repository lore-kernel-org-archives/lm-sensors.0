From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Temperature measure problem
Message-Id: <3ED3E417.1050904@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030526190059.GA6938@siaco.id.pl>
In-Reply-To: <20030526190059.GA6938@siaco.id.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ryszard Lach wrote:
> On Tue, May 27, 2003 at 12:12:25PM +0200, Jean Delvare wrote:
> 
>>>I have lm-sensors installed and configured, but I suppose it does not
>>>work properly.
>>>
>>>I have a water-cooled PC. When I turn off the cooling system BIOS
>>>shows CPU temp. growing starting from 25C with speed 3-4C per minute. 
>>>
>>>When I do the same running linux and checking temperature using
>>>sensors- Temp2/CPU does not change, Temp3 grows, but starting from
>>>33C, which(I suppose) is wrong.
>>
>>Not necessarily. If you consider your Linux system takes approximatively
>>1 minute to start, and you then have to login and run the program, it
>>may take up to 1 more minute, which justifies 8 more degrees. One could
>>argue that it takes much less than 2 minutes, but on the other hand,
>>chances are it generates much more heat that just sitting in the BIOS
>>screen and do nothing.

Actually, in our testing at Penguin Computing, we find that the CPU's 
generate considerable heat when sitting in the BIOS "doing nothing".

External measurements of power used by the system agree with this 
observation.

The cause seems to be that the BIOS is in a tight loop waiting for input 
and never "sleeping" or pausing the CPU.  This tight loop keeps the CPU 
busy all the time wasting energy.  In contrast, the Linux kernel "halts" 
the CPU and puts it in a lower power state when there are no active 
tasks and the CPU is idle.

I suggest that for thermal testing, you get a copy of cpuburn or 
Dhrystone and run that continuously on your CPU to generate a heat load 
for your water cooling system.

:v)




-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
