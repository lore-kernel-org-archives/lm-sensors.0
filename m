From: choongkn@hotmail.com (KhongNeng Choong)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Questions on LM Sensor
Message-Id: <Law10-F108KShPdHfKs00056d19@hotmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear sir,

  I have been going through the source code of lm_sensor, on the w83627 
section particularly. From the source code flow, i managed to write some 
code snippets which read all the PC health monitoring values from the chip. 
However, I failed to inteprete some of those values.

  Could you provide some guidelines on how to translate the "Voltage" values 
collected directly from the monitoring register into the readable format, 
i.e. those displayed on the CMOS setting.

  Currently what i extracted from my program are as follows:

+3.3 VIN         : 202
+5 VIN            : 180
+12 VIN          : 195
fan 3 count      : 110

Values seen from CMOS setting are as follows:

V3P3             : 2.23 V
V5P0              : 4.86 V
V12P0            : 11.85 V
CPU Fan Speed : 6136 RPM

The question again is what is the formula which translates those "Voltage" 
values from the 1st group into those in the second? I managed to inteprete 
only the fan count into RPM, based on formula given on the WinBond 
specification.

Any clue?
Thanks.

regards,
  choong

_________________________________________________________________
Download the latest MSN Messenger http://messenger.msn.com.my
