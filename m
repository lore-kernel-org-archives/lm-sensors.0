From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: LM Sensors Module ADM 1021 running on P4 Xeon (Foster) Procs (Dell
Message-Id: <3C3A1FA9.C4F7B09A@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2DFA1D631549D5118E0C0090277B30ED0238AB5F@ausxmpn202.us.dell.com>
In-Reply-To: <2DFA1D631549D5118E0C0090277B30ED0238AB5F@ausxmpn202.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The xeon only has one sensor in it, the adm1021 and 1023 each support two.
So one of the two entries for the 1021 is bogus.

The driver sees the other processor sensor as a 1023.
You need to set up an adm1023 section in sensors.conf to get its limits set.



David_Papasan@Dell.com wrote:
> 
> Suggested config Per Sensors-detect
> 
> # i2c adapter
> modprobe i2c-i801
> 
> # i2c device
> modprobe adm1021
> modprobe eeprom
> 
> #modules.conf additions
> Alias char-major-89 i2c-dev
> options adm1021 ignore=0,0x18,0,0x19
> *lookin on the LM Sensors site seems that ignore options were normally
> bogus, so have tried with and without these*
> 
> ***********Sensors default startup (no apps running so temp is
> low)************************
> 
> adm1021-0-18
> Chassis 34C      (min +20C   Max= +60C )
> CPU     34C      (min +20C   Max= +60C )
> 
> adm1023-0-19
> 
> *****************after running Sensor.conf********************
> 
> adm1021-0-18
> Chassis 34C      (min +90C   Max= +105C )
> CPU     34C      (min +90C   Max= +105C )
> 
> adm1023-0-19
> 
> ************sensors.conf*****************************
> Chip "adm1021-*"
> 
> label temp "Chassis"
> label remote_temp "CPU"
> 
> set temp_low    90
> set temp_over   105
> set remote_temp_low     90
> set remote_temp_over    105
> 
> Also if you add the options ignore 0,0x18 gets rid of the adm1021 readout,
> 0,0x19 gets rid of the adm1023
> 
> Also have tried doing a force_max1617, will also try force_max1617a.
> 
> Thanks for any insight you can provide.
> Knickia Papasan
> Dell Precision IPS
> 
> -----Original Message-----
> From: Mark Studebaker [mailto:mds@paradyne.com]
> Sent: Monday, January 07, 2002 12:17 PM
> To: David_Papasan@exchange.dell.com
> Cc: lm78@stimpy.netroedge.com
> Subject: Re: LM Sensors Module ADM 1021 running on P4 Xeon (Foster)
> Procs (Dell Precision 530)
> 
> we don't support the 87365.
> 
> we would need the output of 'sensors'
> (before and after running 'sensors -s')
> and the contents of /etc/sensors.conf
> to see what the problem is with setting the limits on the xeons.
> 
> mds
> 
> David_Papasan@Dell.com wrote:
> >
> >         We have a user running LM_Sensors under Linux 7.1 that is
> > experiencing thermal shutdowns at normal temperatures. The system is a
> Dell
> > Precision 530, P4 Xeon, Intel 860 Chipset, National Inst. PC87365 HW
> > monitoring. LM Sensors detects an Analog devices 1021, which would be
> fairly
> > accurate because the xeon's have Max 1617 chips on them. Dell's normal
> > monitor is that the Max monitors the chip, and works with the PC87365, the
> > bios has preset thermal limits ( 70C clock throttle, 90C Thermal warning
> and
> > shutdown counter set to 90second, 105C quickshutdown).
> >
> >         What seems to be happening is
> > 1.) ADM1021 loads and resets temps to 20C warning, 60C shutdown
> > 2.) If you run Sensors -c it sets the desired temperature on the Secondary
> > Proc, but leaves the Primary at 20C/60C.
> > 3.) after 7 mins or so of 100% CPU utilization the system will do a dirty
> > shitdown and the bios indicates a thermal event was reported (even thou if
> > you monitor with Sensors the Temp only got to 60C)
> >
> > I dont think sensors is handling the primary proc right in a dual CPU
> > situation because if I remove the second CPU Sensors is not seeing any of
> > the max chips. But if I dont load ADM 1021 the system will run at 100% CPU
> > without error.
> >
> > Is there a module that will work with the PC87365 ? or a way to monitor 2
> > Max 1617 chips and set the temperature accordingly ?
> >
> > Thanks
> > Knickia Papasan
> > Dell Precision IPS
