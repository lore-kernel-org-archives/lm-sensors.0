From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Feedback: lm_sensors 2.8.8, SuSE Linux 9.1, and SuperMicro P4SPA+
Message-Id: <x4e6mC90.1101292110.4424120.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200411240110.06905.dgersic@myrealbox.com>
In-Reply-To: <200411240110.06905.dgersic@myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Just wanted to send in some feedback on this combination and a thank you
> for lm_sensors.

Thanks :)

> SuSE 9.1 "Personal" edition (kernel 2.6.5-7.104-smp) distribution included
> lm_sensors 2.8.3-99. This, of course, didn't work. Some searching of your
> FAQ turned up the recommendation that lm_sensors needed to be 2.8.6 or
> newer with this kernel version. So, a download, make user, and make
> user_install later, I have the correct version installed, and it works
> fine. Thanks to the FAQ editor(s) for this.

Did you report to them? They should really not be distributing
incompatible packages. Package dependancies are there for a reason.

> # Configuration for Temp sensors
>     label temp1 "System Temp"
>     ignore temp2
>     label temp3 "CPU Temp"
>     compute temp3 @+6,(@-6)
> # end - dgersic
>
> and the outputs of lm_sensors status now match the values shown by the BIOS
> for the FAN speeds and the system and CPU temps.

The 6 degrees offset you are introducing might not be needed. If you
tried to have Linux idle temperature and BIOS idle temperature match,
it's not correct. I have a Supermicro (370DLE) motherboard and I know
for sure that the BIOS has a closed, almost undelayed while(1) loop that
keeps the CPU busy all the time. Linux reads 26 degrees idle, BIOS reads
38 degrees. Linux at full load is in the 35-40 degrees range so this
makes sense.

Like you, I was about to add an offset to sensors.conf, but now I know
it's not correct. The raw Linux reading is most likely correct and
lower than what you see in the BIOS just because you are comparing a
somewhat busy BIOS with an idle Linux.

(Or maybe I'm wrong - all boards are different.)

Thanks for the nice report anyway :)

Jean
