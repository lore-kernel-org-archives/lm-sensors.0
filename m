From: Alan Swanson <swanson@ukfsn.org>
Date: Mon, 28 Jan 2013 13:52:54 +0000
Subject: [lm-sensors] Gigabyte GA-F2A85X-UP4 Configuration
Message-Id: <1359381174.2167.20.camel@trillian.infiniteimprobability.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-QJnlXE9noOStDNG7yuZD"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--=-QJnlXE9noOStDNG7yuZD
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Attached is a working lm_sensors configuration for Gigabyte
GA-F2A85X-UP4 to be added to the wiki please.

Voltage divisors determined by following the excellent wiki guide for
the onboard IT8728F chip at 1bit per 12mV. For reference, the BIOS
voltages used are below. 

3.3V | 0.020V/bit |  3.264  3.284  3.304  3.363 
5V   | 0.030V/bit |  4.950  4.980  5.010  5.040  5.100  5.130
12V  | 0.072V/bit | 11.952 12.024 12.096 12.168 12.240 

-- 
Cheers, Alan.

--=-QJnlXE9noOStDNG7yuZD
Content-Disposition: attachment; filename="gigabyte-ga-f2a85x-up4.conf"
Content-Type: text/plain; name="gigabyte-ga-f2a85x-up4.conf"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

chip "it8728-*"
	label in0 "VCore"
	label in1 "VDram"
	label in2 "+12V"
	  compute in2 @*(72/12) , @/(72/12)
	  set in2_min 12*0.95
	  set in2_max 12*1.05
	label in3 "+5V"
	  compute in3 @*(30/12) , @/(30/12)
	  set in3_min 5*0.95
	  set in3_max 5*1.05
	label in4 "+3.3V"
	  compute in4 @*(20/12) , @/(20/12)
	  set in4_min 3.3*0.95
	  set in4_max 3.3*1.05
	ignore in5
	ignore in6

	label fan1 "CPU Fan"
	label fan2 "SYS1 Fan"
	label fan3 "SYS2 Fan""
	label fan4 "SYS3 Fan"
	label fan5 "SYS4 Fan"

	label temp1 "SYS Temp"
	  set temp1_max 55
	ignore temp2
	label temp3 "CPU Temp"
	  set temp3_max 65

--=-QJnlXE9noOStDNG7yuZD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-QJnlXE9noOStDNG7yuZD--

