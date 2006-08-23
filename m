From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Wed, 23 Aug 2006 15:28:13 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04708A1725E@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 

-----Original Message-----
From: Mark M. Hoffman [mailto:mhoffman at lightlink.com] 
Sent: Wednesday, August 23, 2006 7:19 AM
To: Calabro, Anthony
Cc: LM Sensors
Subject: Re: [lm-sensors] Flex Scanner Jammed Problem

Hi:

* Calabro, Anthony <anthony.calabro at lmco.com> [2006-08-22 16:19:55
-0400]:
> I guess Im going to try to start over with this thread.  I have solved

> the Flex Scanner Jammed problem by going back to sensors version
2.9.0.
> When using 2.10.0 the best I could do is get label lines to parse 
> correctly, but I never had any luck with the compute lines.  I also

Did you install 2.9.0 from source?  Looking back at the archives, you
actually started with 2.8.7 - it probably came with the distro.

Yes, I installed it from source.


If you were able to install 2.9.0 from source, but not 2.10.0... well
that is very strange.  The scanner didn't change between those versions.

??

Anyway, if you're still interested in trying to debug the scanner error:
please add the flag '-d' to the last line of the Makefile.  It should
look like this:

 	$(FLEX) -Psensors_yy -t -d $< > $@

Then 'make clean' && 'make' && 'make install'.  That flag will cause the
scanner to make a lot of noise about what it's doing.  Send some results
back to this list and I'll have a look.

I will try this later this afternoon and send the output.

> upgraded my linux kernel from 2.6.9-34 to 2.6.9-42.  In this new 
> version there is an i2c sensors update.  We are running the newest 
> version of RedHat Enterprise with AS 4.  Is there any support for the 
> Winbond 83627HG chip, or the nVidia nForce Pro 2200 (CK804)???
> 
> Right now I have sensors up and running using the Winbond 83627HF 
> driver, and this is giving me incorrect readings.
> 
> 
> Are these chips or busses supported right now?  

The Winbond (sensor) chip is supported including access by ISA bus...
so you don't need any other bus driver to get that working.

The 83627HG uses the same drivers as the 83627HF???


Regards,

--
Mark M. Hoffman
mhoffman at lightlink.com




Ok,  I went into BIOS and read the output of the sensors it is reading,
and compared it with the lm_sensors output.   Below is what BIOS is
reading, and attached is the output of sensors, as well as a few other
programs to give input on what is going on the system, including
sensors-detect, systool, lspci, lsmod.  Please let me know what, if any
other input would be helpful.  I'm going to try to find out how the BIOS
is reading the sensors and maybe ill have a better shot doing it that
way.


BIOS INFO:

CPU1 VCore:			1.19V
CPU2 VCore:			1.19V
CPU1 DIMM Volt:		2.62V
CPU2 DIMM Volt:		2.63V
1.2V Hyper-Transport:	1.21V
1.5V:				1.50V
2.5V:				2.63V
3.3V VCC:			3.44V
3.3V SB:			3.44V
5Vin:				5.10V
12Vin:			12.06V
-12V Vcc:			-12.09V
Vbatt:			3.07V

CPU1:				17 C
CPU2:				0 C
SYS Temp:			25 C

FAN1:				NA (not attached)
FAN2:				~7000
FAN3:				NA (not attached)
FAN4:				6750
FAN5:				NA (not attached)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lsmod.out
Type: application/octet-stream
Size: 1813 bytes
Desc: lsmod.out
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060823/25dfd06c/attachment-0007.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspci.out
Type: application/octet-stream
Size: 26720 bytes
Desc: lspci.out
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060823/25dfd06c/attachment-0008.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspci-x.out
Type: application/octet-stream
Size: 8398 bytes
Desc: lspci-x.out
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060823/25dfd06c/attachment-0009.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors.out
Type: application/octet-stream
Size: 1203 bytes
Desc: sensors.out
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060823/25dfd06c/attachment-0010.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensorsblank.out
Type: application/octet-stream
Size: 1203 bytes
Desc: sensorsblank.out
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060823/25dfd06c/attachment-0011.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors-detect.out
Type: application/octet-stream
Size: 5593 bytes
Desc: sensors-detect.out
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060823/25dfd06c/attachment-0012.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: systool.out
Type: application/octet-stream
Size: 1934 bytes
Desc: systool.out
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060823/25dfd06c/attachment-0013.obj 
