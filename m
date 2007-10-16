From: Keith Romberg <romberg@ucar.edu>
Date: Tue, 16 Oct 2007 12:38:51 +0000
Subject: [lm-sensors] Compaq EVO W8000 Sensor/Chip Support
Message-Id: <1192538331.4059.17.camel@tiger.atd.ucar.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a Compaq EVO W8000 machine that I have been trying to get
lm_sensors to work on.  The machine is a dual Xeon board with the
following chips/sensors I believe it has:

82801BA - work in progress
LPC47m967 - unknown support
ADM1021/LM84 - supported
ADM1032/lm90 - supported

Looking at the Devices page, I believe they have the corresponding
support.

The machine is running Fedora Core 6 x86 with lm_sensors 2.10.4.  When I
run sensors-detect, nothing is found.  I was kind of expecting the LM84
and LM90 chips to be found, but they where not.  Are they dependent on
the 82801BA and LPC47m967 being found supported?  Has anyone gotten
lm_sensors to with with this machine?

Below is the output from speedfan which is a Windoze app....

Thanks,
Keith

//---------------------------------------------------------------------->>

Win9x:NO  64Bit:NO  GiveIO:YES  SpeedFan:YES
I/O properly initialized
Linked ISA BUS at $0290
SMBus successfully enabled
Linked Intel 82801BA ICH2 SMBUS at $FC00
Scanning ISA BUS at $0290...
SuperIO Chip=LPC47m967
Scanning Intel SMBus at $FC00...
ADM1021 (ID=$00) found on SMBus at $18
ADM1032 (ID=$00) found on SMBus at $4C
SMART Enabled for drive 0
Found SAMSUNG SP0802N (80.1GB)
Found SCSI drive ST318436LW (18.4GB)
Found SCSI drive ATLAS IV 18 WLS (18.4GB)
End of detection
Loaded 0 events


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
