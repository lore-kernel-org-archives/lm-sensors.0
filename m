From: michaelnel@comcast.net (Michael Nelson)
Date: Sun, 10 Sep 2006 20:13:26 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060910201326.GB11993@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Sep 10, 2006 at 12:46:22PM -0700, Michael Nelson wrote:
> On Sun, Sep 10, 2006 at 07:52:59PM +0200, Jean Delvare wrote:
> 
> > You need lm_sensors SVN for voltage values:
> > http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4155-20060908.tar.bz2
> 
> OK, I will grab that.

Here's the output using that:

$  /usr/local/bin/sensors
w83627ehf-isa-0290
Adapter: ISA adapter
VCor1:     +1.14 V  (min =  +0.00 V, max =  +1.74 V)
VCor2:     +1.82 V  (min =  +1.06 V, max =  +1.05 V) ALARM
+3.3V:     +3.26 V  (min =  +2.61 V, max =  +0.10 V) ALARM
+5V:       +5.48 V  (min =  +0.22 V, max =  +0.81 V) ALARM
+12V:      +4.62 V  (min =  +0.00 V, max =  +1.22 V) ALARM
-12V:      -6.77 V  (min = -11.78 V, max =  -5.00 V)
-5V:       -3.92 V  (min =  -7.66 V, max =  -2.81 V)
V5SB:      +5.51 V  (min =  +0.11 V, max =  +5.78 V)
VBat:      +3.10 V  (min =  +1.34 V, max =  +2.56 V) ALARM
CPU Fan:   869 RPM  (min =  803 RPM, div = 16)
Case Fan: 2083 RPM  (min = 1704 RPM, div = 8)
Power Fan: 948 RPM  (min =  803 RPM, div = 16)
MB Temp:     +30??C  (high =   +35??C, hyst =   +40??C)
CPU Temp:  +44.5??C  (high = +70.0??C, hyst = +40.0??C)

Some of the readings and settings look screwy.  More /etc/sensors.conf
tweaking needed.

Thanks

Michael

-- 

San Francisco, CA

