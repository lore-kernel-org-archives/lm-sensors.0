From: timmcross@hotmail.com (Tim Cross)
Date: Sun, 22 Jan 2006 19:17:59 +0000
Subject: [lm-sensors] support for Soyo motherboard
Message-Id: <BAY107-F32A65DEB24FE12F9BBA109AC110@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was using lm_sensors on a Soyo SY-P4I865PE Plus Dragon 2 v1.0 motherboard 
without issue for some time.  At some point, the sensors command now reports 
No sensors found!  I am currently using Fedora Core 4.  Installing Windows 
on this server and using Speedfan will allow me to access this data.

Speedfan reports this:

Scanning ISA BUS at $0290...
Winbond W83627HF (ID=$21) found on ISA at $290
SuperIO Chip=Winbond W83627HF

[root at localhost ~]# sensors -v
sensors version 2.9.1 with libsensors version 2.9.1

Sensors-detect reports this:
Probing for `Winbond W83627HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')

Probing for `Winbond W83627HF Super IO Sensors'
  Success... found at address 0x0290

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)

I added these lines:
/etc/modprobe.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

and these:

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

yet I still get this:

[root at localhost ~]# sensors
No sensors found!

Any ideas?

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/


