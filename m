From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: LM Sensors Module ADM 1021 running on P4 Xeon (Foster) Procs (Dell
Message-Id: <3C39E617.436F4E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2DFA1D631549D5118E0C0090277B30ED0238AB5F@ausxmpn202.us.dell.com>
In-Reply-To: <2DFA1D631549D5118E0C0090277B30ED0238AB5F@ausxmpn202.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

we don't support the 87365.

we would need the output of 'sensors' 
(before and after running 'sensors -s')
and the contents of /etc/sensors.conf
to see what the problem is with setting the limits on the xeons.

mds


David_Papasan@Dell.com wrote:
> 
>         We have a user running LM_Sensors under Linux 7.1 that is
> experiencing thermal shutdowns at normal temperatures. The system is a Dell
> Precision 530, P4 Xeon, Intel 860 Chipset, National Inst. PC87365 HW
> monitoring. LM Sensors detects an Analog devices 1021, which would be fairly
> accurate because the xeon's have Max 1617 chips on them. Dell's normal
> monitor is that the Max monitors the chip, and works with the PC87365, the
> bios has preset thermal limits ( 70C clock throttle, 90C Thermal warning and
> shutdown counter set to 90second, 105C quickshutdown).
> 
>         What seems to be happening is
> 1.) ADM1021 loads and resets temps to 20C warning, 60C shutdown
> 2.) If you run Sensors -c it sets the desired temperature on the Secondary
> Proc, but leaves the Primary at 20C/60C.
> 3.) after 7 mins or so of 100% CPU utilization the system will do a dirty
> shitdown and the bios indicates a thermal event was reported (even thou if
> you monitor with Sensors the Temp only got to 60C)
> 
> I dont think sensors is handling the primary proc right in a dual CPU
> situation because if I remove the second CPU Sensors is not seeing any of
> the max chips. But if I dont load ADM 1021 the system will run at 100% CPU
> without error.
> 
> Is there a module that will work with the PC87365 ? or a way to monitor 2
> Max 1617 chips and set the temperature accordingly ?
> 
> Thanks
> Knickia Papasan
> Dell Precision IPS
