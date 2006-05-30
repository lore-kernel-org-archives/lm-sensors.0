From: roger@planbit.co.uk (Roger Lucas)
Date: Tue, 30 May 2006 22:19:35 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <20060530221750.9822012ED4@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

There was a similar thread on this list last year about how to set up a
system that automatically detects motherboards and their configurations.

We needed something to do this and our brief spec was for:
- a system that would confidently pick a configuration that was specific to
an exact motherboard, not based on chip probing.  This stopped any problems
with external voltage scaling resistors etc that were motherboard specific.
- a system that we could quickly add new configuation files to.
- a system with a standardised naming convention for the sensors themselves
so that the output from "sensors" could be easily parsed by a script or
similar and where the script did NOT need changing for different
motherboards.

Our solution was to create a unique sensors.conf file for each motherboard
which included information about the motherboard "dmidecode" output and the
modules that were needed to run.  A script ran the dmidecode utility and
scanned all the conf files in a folder looking for the best match.  It could
then optionally install the appropriate .conf file and add the appropriate
modprobe commands to the modules file.

We picked a naming convention for the sensors based on a prefix of:
	V_	voltage sensor
	T_	temperature sensor
	F_	Fan sensor

There then followed a unique identifier string - if it was a voltage rail
described as a target voltage (e.g. 3.3v rail) then we followed a typical
engineering practice of removing the "." and replacing it with "V" for
voltages.  A suffix of "P" indicated a positive voltage and "N" a negative
voltage - again common practice in schematics and similar.  If there were
multiple sensors reading the same type of parameter (e.g. multiple CPUs)
then a suffix of _0, _1, _2, ... was added.  This made the parser extremely
simple.

e.g.
    label in0 "V_VCORE_0"    #"VCore"
    label in2 "V_3V3P"    #"+3.3V"
    label in3 "V_5V0P"    #"+5V"
    label in4 "V_12V0P"    #"+12V"
    label in5 "V_12V0N"    #"-12V"
    label in6 "V_5V0N"    #"-5V"
    label in7 "V_V5SB"    #"V5SB"
    label in8 "V_VBAT"    #"VBat"

    label fan1 "F_CPU_0"
    label fan2 "F_MB_0"
    label fan3 "F_MB_1"
    label fan4 "F_MB_2"
    
    label temp1 "T_MB_0"
    label temp2 "T_CPU_0"

This has worked _really_ well for us.

I have attached the python script that we wrote as well as several sensors
files.  If this is of use to anyone then enjoy !

Comments welcome.

BR,

Roger
 
> -----Original Message-----
> From: lm-sensors-bounces at lm-sensors.org [mailto:lm-sensors-bounces at lm-
> sensors.org] On Behalf Of Hans de Goede
> Sent: 30 May 2006 11:36
> To: LM Sensors
> Subject: Re: [lm-sensors] LM Sensors autoconfig tool project awarded as
> google SOC project
> 
> 
> 
> Jean Delvare wrote:
> > Hi Hans,
> >
> > A few comments about DMI tables:
> > * Depending on the system, the DMI table may be conveniently and
> > accurately filled, or empty, or useless. Systems with poor DMI tables
> > won't be supportable.
> 
> Yes I just encountered the first of such a system, any idea for
> alternative methods to identify these? I'm myself thinking about
> memmapping the bios and getting info from the bios image, anyone got any
> experience with this?
> 
> Here is what my pcchips M811 gives:
> Handle 0x0002, DMI type 2, 8 bytes.
> Base Board Information
>         Manufacturer:
>         Product Name: VT8367-8235
>         Version:
>         Serial Number:
> 
> Clearly the didn't change this from the VIA reference bios.
> 
> > * Some systems have no type 2 (Base Board Information) DMI record but
> > do have type 1 (System Information) or type 3 (Chassis Information)
> > records you can fall back on.
> The above motherboard doesn't contain any usefull info there either.
> 
> > I don't think that being able to export the database is a key feature.
> > End users shouldn't need this.
> >
> 
> They will, one cannot assume a internet connection and even if one
> assumes an internet connection, phoning home applications are evil!
> 
> > Likewise, I don't like the hotplug/udev stuff you mention in point 2.
> > Configuration is only done once, so I don't quite see how hotplug is
> > relevant here.
> 
> The idea behind this is to make things truely plug and play, so if I
> drop a new motherboard in my system the OS should reconfigure itself
> automaticly and everything should work as if nothing has changed. I've
> done this a couple of times and this currently works pretty well with
> Linux as OS, except for lm_sensors.
> 
> > It's more simple, and more efficient too, to integrate
> > the motherboard recognition code into sensors-detect. If enough DMI
> > data is available, propose to connect to the online database to find a
> > configuration file. If a configuration file is found, copy it, and skip
> > all the probing phase. This is how I'd do it, anyway.
> >
> 
> See above, besides I want lm_sensors to just work (tm), having to run
> sensors-detect is not just working. I do agree that the detected
> motherboard should be stored somewhere and that the existing config
> should not be overwritten if the motherboard wasn't changed.
> 
> 
> Regards,
> 
> Hans
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
-------------- next part --------------
A non-text attachment was scrubbed...
Name: abit_LG81.conf
Type: application/octet-stream
Size: 725 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/01aca96f/abit_LG81-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: asrock_K7S41GX.conf
Type: application/octet-stream
Size: 3175 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/01aca96f/asrock_K7S41GX-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: EPIA.conf
Type: application/octet-stream
Size: 2802 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/01aca96f/EPIA-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: MSI_KM266-8237.conf
Type: application/octet-stream
Size: 3235 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/01aca96f/MSI_KM266-8237-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: template.conf
Type: application/octet-stream
Size: 3091 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/01aca96f/template-0001.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors4mobo
Type: application/octet-stream
Size: 19047 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/01aca96f/sensors4mobo-0001.obj
