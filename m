From: Robert.Martin@inmedia.co.uk (Robert Martin - inmedia)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Ported driver for PC87360 for 2.6 Kernel
Message-Id: <5F0794098965D51199B700508B69580905449CB2@exchange1.chalfont.kingstoninmedia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

WARNING: This e-mail has been altered by MIMEDefang.  Following this
paragraph are indications of the actual changes made.  For more
information about your site's MIMEDefang policy, contact
andrew.net.au Postmaster <postmaster@andrew.net.au>.  For more information =
about MIMEDefang, see:

            http://www.roaringpenguin.com/mimedefang/enduser.php3

An attachment named cat-sensors.sh was removed from this document as it
constituted a security hazard.  If you require this document, please contact
the sender and arrange an alternate means of receiving it.

-------------- next part --------------

Hi,

I have ported the PC87360 driver to the 2.6 kernel.  It is required for, and
only tested on, a Tyan GS10, running SuSE 9.1.  I have also made some
modifications.  It will be used with Nagios.  It would be advisable if
someone can check the code over, I haven't ported a driver to 2.6 before,
and I'm not familiar with these drivers.  I can easily arrange testing.

Modifications include:-

A parameter to select the secondary device.  This was done prior to porting.
Voltages changed to give mV.  The ability to set the voltage multiplier,
which is divided by 1000 to allow for non-integer values, and is in line
with the use of mV.  The setting of an off-set to allow for negative
voltages.

The FSCM registers can be set as a parameter, to overcome inappropriate BIOS
settings.

The fan divisors can be set.

I have included a simple BASH script I have used for testing.


In the Kconfig file, /usr/src/linux/drivers/i2c/chips/Kconfig, the following
lines should be added:-

config SENSORS_PC87360
	tristate "PC87360"
	depends on I2C && EXPERIMENTAL
	select I2C_SENSOR
	help
	  If you say yes here you get support for the Nat Semi PC8736X
series
	  of sensor chips: the PC87360, PC87363, PC87364, PC87365, PC87366

	  This driver can also be built as a module.  If so, the module
	  will be called pc87360.


In the Makefile, /usr/src/linux/drivers/i2c/chips/Makefile, the following
line should be added after the obj-$(CONFIG_SENSORS_W83L785TS)	+w83l785ts.o=
 line:-
	obj-$(CONFIG_SENSORS_PC87360)	+=3D pc87360.o

In the file /etc/sysconfig/lm_sensors

MODULE_0=3Di2c-i801
MODULE_1=3Di2c-isa
MODULE_2=EEprom
MODULE_3=3D"pc87360 secondary=3D1 fanspeedcandm=3D0x036c"


When testing I found that the status bits changed correctly, however these
do not seem to be reflected in the alarm indication.  I suspect that it may
be that some settings in some other registers require setting.  I started to
do this, however this could lead to unexpected results if some of the output
pins are connected and as a consequence of changing the values in a register
there could be unintended system resets.  A similar effect can be achieved
in the bash script if required.  I had a quick look at the Watch dog Timer,
however the address registers have not been set by the BIOS.


Regards,=20
Bob.=20

Robert Martin=20
Product Development Manager=20

Inmedia
 PO Box 2287
 Gerrards Cross
 SL9 8BF
=20
Email: robert.martin@inmedia.co.uk=20
Direct Phone   +44 (0)1494 878522=20
Direct Fax     +44 (0)1494 874433=20
Mobile         +44 (0)7771 645527=20

Web: www.inmedia.co.ukThe content of this e-mail and any attachment is
private and may
be legally privileged. If you are not the intended recipient,
any use, disclosure, copying or forwarding of this e-mail
and/or its attachments is unauthorised.

If you have received this e-mail in error please notify the
sender by e-mail and delete this message and any attachments
immediately from this system.

Inmedia Communications Limited is a private limited company
incorporated in England and Wales with registration
number 02928653 and whose registered office is at
Chalfont Grove, Narcot Lane, Gerrards Cross SL9 8TW.

For more information please visit: http://www.inmedia.co.uk


   =20

-------------- next part --------------
A non-text attachment was scrubbed...
Name: pc87360.c
Type: application/octet-stream
Size: 42673 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040911=
/ba730c3a/pc87360.obj
