From: "Michael Darling" <darlingm@gmail.com>
Date: Mon, 21 Apr 2008 21:37:44 +0000
Subject: [lm-sensors] How to get lm-sensors to see eight processors instead
Message-Id: <c33e4330804211437l37016d1r14943f9c52ef8b07@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2210238378142858293=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2210238378142858293==
Content-Type: multipart/alternative; 
	boundary="----=_Part_10374_21089228.1208813864099"

------=_Part_10374_21089228.1208813864099
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have a HP XW8400 workstation.  It came with a single Intel Xeon E5335, and
I correctly got lm_sensors installed so I could see the four processor
temperatures.  (The E5335 is a quad xeon chip.)

I just installed a second Xeon E5335.  /proc/cpuinfo correctly sees 8
logical CPUs, however lm_sensors is still reporting temperatures for only 4
of those logical CPUs.  When I initially installed the machine on a single
Xeon, I got lm_sensors working correctly, but can't figure out now how to
expand it from reporting on 4 CPUs to 8.  My experience with lm_sensors is
extremely limited, so any advice would be much appreciated!

I ran sensors-detect, and used all default values.  The output was:
----------
Driver `smsc47b397' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0480 (Busdriver `i2c-isa')
    Chip `SMSC SCH5307-NS Super IO' (confidence: 9)

I will now generate the commands needed to load the I2C modules.
To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
To load everything that is needed, add this to some /etc/rc* file:
#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe smsc47b397
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----
----------
  None of that is new.  /etc/modprobe.conf already had "alias char-major-89
i2c-dev", and /etc/rc.local already had "modprobe i2c-isa", "modprobe
smsc47b397", and "/usr/bin/sensors -s"

lsmod gives:
Module                  Size  Used by
i2c_dev                43849  0
smsc47b397             39749  0
hwmon                  36553  1 smsc47b397
i2c_isa                39105  1 smsc47b397
...
i2c_ec                 38593  1 sbs
i2c_core               56129  4 i2c_dev,smsc47b397,i2c_isa,i2c_ec
i2cdetect and i2cdump state "Error: No I2C busses found!"

I'm running sensors 2.10.0, libsensors 2.10.0, and kernel 2.6.18-53.1.14.el5

------=_Part_10374_21089228.1208813864099
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I have a HP XW8400 workstation.&nbsp; It came with a single Intel Xeon E5335, and I correctly got lm_sensors installed so I could see the four processor temperatures.&nbsp; (The E5335 is a quad xeon chip.)</div>
<div>&nbsp;</div>
<div>I just installed a second Xeon E5335.&nbsp; /proc/cpuinfo correctly sees 8 logical CPUs, however lm_sensors is still reporting temperatures for only 4 of those logical CPUs.&nbsp; When I initially installed the machine on a single Xeon, I got lm_sensors working correctly, but can&#39;t figure out now how to expand it from reporting on 4 CPUs to 8.&nbsp; My experience with lm_sensors is extremely limited, so any advice would be much appreciated!</div>

<div>&nbsp;</div>
<div>I ran sensors-detect, and used all default values.&nbsp; The output was:</div>
<div>----------</div>
<div>Driver `smsc47b397&#39; (should be inserted):<br>&nbsp; Detects correctly:<br>&nbsp; * ISA bus address 0x0480 (Busdriver `i2c-isa&#39;)<br>&nbsp;&nbsp;&nbsp; Chip `SMSC SCH5307-NS Super IO&#39; (confidence: 9)</div>
<div><br>I will now generate the commands needed to load the I2C modules.</div>
<div>To make the sensors modules behave correctly, add these lines to<br>/etc/modprobe.conf:</div>
<div>#----cut here----<br># I2C module options<br>alias char-major-89 i2c-dev<br>#----cut here----</div>
<div>To load everything that is needed, add this to some /etc/rc* file:</div>
<div>#----cut here----<br># I2C adapter drivers<br>modprobe i2c-isa<br># I2C chip drivers<br>modprobe smsc47b397<br># sleep 2 # optional<br>/usr/bin/sensors -s # recommended<br>#----cut here----<br>----------</div>
<div>&nbsp; 
<div>None of that is new.&nbsp; /etc/modprobe.conf already had &quot;alias char-major-89 i2c-dev&quot;, and /etc/rc.local already had &quot;modprobe i2c-isa&quot;, &quot;modprobe smsc47b397&quot;, and &quot;/usr/bin/sensors -s&quot;</div>

<div>&nbsp;</div>
<div>lsmod gives:</div>
<div>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nbsp; Used by<br>i2c_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43849&nbsp; 0 <br>smsc47b397&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39749&nbsp; 0 <br>hwmon&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36553&nbsp; 1 smsc47b397<br>i2c_isa&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39105&nbsp; 1 smsc47b397<br>...</div>
<div>i2c_ec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38593&nbsp; 1 sbs<br>i2c_core&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 56129&nbsp; 4 i2c_dev,smsc47b397,i2c_isa,i2c_ec<br></div>
<div>i2cdetect and i2cdump state &quot;Error: No I2C busses found!&quot;</div>
<div>&nbsp;</div>
<div>I&#39;m running sensors 2.10.0, libsensors 2.10.0, and kernel 2.6.18-53.1.14.el5</div></div>

------=_Part_10374_21089228.1208813864099--


--===============2210238378142858293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2210238378142858293==--
