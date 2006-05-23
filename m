From: christoph.galuschka@tikom.at (Galuschka Christoph)
Date: Tue, 23 May 2006 10:51:24 +0000
Subject: [lm-sensors] Question about correct sensor
Message-Id: <4473054C.6993.1E8B3737@christoph.galuschka.tikom.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <4472C4FA.18461.1D8FF3D3@christoph.galuschka.tikom.at>
In-Reply-To: <4472C4FA.18461.1D8FF3D3@christoph.galuschka.tikom.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

well things partly work now. I get the following output from sensors 
(thanks for the hint):
#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe w83627ehf

I have changed the kernel to accept modules for sensors and did a 
fresh recompile for the kernel and both lm_sensors and i2c-drivers 
(both version 2.10.0). When trying to execute "modprobe w83627ehf" I 
get:
/lib/modules/2.4.32/kernel/drivers/i2c/chips/w83627hf.o: init_module: 
No such device
Hint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters
/lib/modules/2.4.32/kernel/drivers/i2c/chips/w83627hf.o: insmod 
/lib/modules/2.4.32/kernel/drivers/i2c/chips/w83627hf.o failed
/lib/modules/2.4.32/kernel/drivers/i2c/chips/w83627hf.o: insmod 
w83627hf failed

As all other recommended modules work ( i do get a readout from the 
memory bank) did I miss something?

thanks and regards
Christoph


Am 23 May 2006 um 11:11, schrieb Rudolf Marek:

> Hello,
> 
> > thanks for the fast reply.
> > 
> > I allready did read the manual, as I have running versions of 
> > LM_Sensors on various machines.
> > I have patched the kernel according to the INSTALL file. The i2c-i801 
> > is included in the compilation.
> > When running sensors-detect I get:
> > Can't access /proc/modules! at /usr/sbin/sensors-detect line 1831.
> 
> Hmm this seems as an too old version is used? Are you using 2.10.0 version of
> lm-sensors?
> 
> If not here is a hack. Just download the 2.10.0 from the website,
> exytact archive and go to prog/detect/ run the sensors-detect
> program from there.
> 
> Then you may load the modules it suggest and generally used the older version
> from a distro if it wont have issues.
> 
> 
> Regards
> Rudolf



========================
TI.KOM Tirol Kommunikation GmbH
Eduard-Walln?fer-Platz 2
A-6010 Innsbruck

Neuer Markt 1/2
A-1010 Wien

Ing. Christoph Galuschka
Lead Consultant

Tel.:  +43 512 902 2832
Fax:   +43 512 902 2850
Mobil: +43 676 666 2832 
eMail: christoph.galuschka at tikom.at
http://www.tikom.at
-------------------------------------------------------------------------------
This email is confidential and may also be legally privileged.
If you have received this email in error, you are in notice of
its status. Please notify the sender immediately by reply
e-mail and then delete this message from your system. Please
do not copy or use it for any purposes, or disclose its contents
to any other person: to do so could be a breach of confidence.
Thank you for your co-operation.

Any views expressed in this message are those of the individual
sender and may not necessarily reflect the views of
TI.KOM Tirol Kommunikation GmbH.

Please contact our Office on +43 512 902 2801 or
+43 1 902 2841 or e-mail office at tikom.at if you require further
assistance.
========================

