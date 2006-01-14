From: johnny@dvc.org.uk (John Pate)
Date: Sat, 14 Jan 2006 18:35:52 +0000
Subject: [lm-sensors] HP Kayak, maxilife, i2c-matroxfb
Message-Id: <Pine.LNX.4.44.0601141811080.253-100000@jpate.easynet.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

$ cat /etc/slackware-version
Slackware 10.2.0

uname -a
Linux ellie 2.4.31 #1 SMP Thu Dec 29 13:49:05 GMT 2005 i686 unknown
unknown GNU/Linux

$ /sbin/lsmod
Module                  Size  Used by    Not tainted
maxilife                8784   0 (unused)
i2c-piix4               4118   0 (unused)
dmi_scan                1604   0 [i2c-piix4]
i2c-proc                6212   0 [maxilife]
i2c-core               15780   0 [maxilife i2c-piix4 i2c-proc]

	As you might gather from the above, I installed the
lm_sensors-2.9.2 package onto an HP Kayak XU 7/550X (dual Xeon PIII 550s)
and (after some very manual configuring) it does seem to work ...

maxilife-co-i2c-0-14
Adapter: SMBus PIIX4 adapter at 2180
CPU 1 Temp:  +26.0?C  (high =   +60?C, hyst =   +55?C)
PCI Temp:    +28.5?C  (high =   +55?C, hyst =   +50?C)
CPU 2 Temp:  +28.0?C  (high =   +60?C, hyst =   +55?C)
HDD Temp:    +24.5?C  (high =   +50?C, hyst =   +45?C)
CPU Temp:    +28.0?C  (high =   +60?C, hyst =   +55?C)
HDD Fan:     2592 RPM   (min = 1408 RPM, div = 4)
PCI Fan:     1927 RPM   (min = 1408 RPM, div = 4)
CPU Fan:     1890 RPM   (min = 1308 RPM, div = 4)
pll:        14.37 MHz   (min = 12.81 MHz, max = 15.31 MHz)
V+12:       +12.47 V    (min =  +9.56 V, max = +14.37 V)
Vcpu1:       +2.04 V    (min =  +1.81 V, max =  +2.17 V)
Vcpu2:       +2.05 V    (min =  +1.81 V, max =  +2.17 V)
VcacheL2:    +1.52 V    (min =  +0.00 V, max =  +2.29 V)

	(Though why there's a report for each CPU and then a further CPU
Temp line I haven't yet figured out.)

	My first issue: the Maxilife driver itself appears to be
unfinished judging by a cursory look at the source code (for instance
there's a start on autodection but it's commented out).  Is it actually
under development or defunct now?  Is it really working correctly for the
particular version of machine I have (the code doesn't mention 550MHz
processor models)? ...

  ``This version of MaxiLife is called MaxiLife'98 and has been
   succeeded by MaxiLife'99, see below.''

	...the ``see below'' appears to imply figuring out the source code
and the way some of the #defines can be configured.

	Before I resort spending a lot of time trying to understand the
source (which is likely of limited value without technical data on what
it's trying to get at in my particular machine) I was hoping to get some
useful pointers.

	My other issue is that the machine has an (original equipment)
Matrox G400 MAX and the lm_sensors homepage implies there is a driver for
that.  It is not to be found in the package I installed however.  The
webpage doesn't appear to comment on this.  Is this driver available or
has it been rescinded for some important reason?

	(I got two of these machines for free but the amount of time I've
spent tinkering with just one of them proves there's no such thing as a
free lunch.)


-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-|message from the cookie daemon|

You know, I just got my cholesterol results.
I wish my IQ was that high.

-- 
John Pate <johnny at dvc.org.uk>
Edinburgh, Scotland (home PC)
Disclaimer: I've probably changed my opinions by the time you read this
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-



