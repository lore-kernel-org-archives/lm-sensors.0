From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: (from cvs) sensors binary compile probs on rh8
Message-Id: <3DFA1F13.8050009@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DF93866.7070502@netroedge.com>
In-Reply-To: <3DF93866.7070502@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Phil, what processor are you compiling for? Or what's wrong with <math.h>?
It works for me, but gcc is generating floating point assembler instructions
and so it doesn't need -lm.
If we do add a -lm it should be added to lib/Module.mk for the library,
not in prog/sensors/Module.mk for sensors.


Jean Delvare wrote:
>>FYI-
>>
>>gcc -o prog/sensors/sensors prog/sensors/main.ro prog/sensors/chips.ro
>>-Llib -lsensors
>>lib/libsensors.so: undefined reference to `log'
>>lib/libsensors.so: undefined reference to `exp'
>>collect2: ld returned 1 exit stat
> 
> 
> Looks like we need an extra "-lm" on the command line.
> 

