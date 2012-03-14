From: Christopher Head <headch@gmail.com>
Date: Wed, 14 Mar 2012 21:36:59 +0000
Subject: [lm-sensors] Intel DH55HC Sensors
Message-Id: <20120314143659.0c1cf55d@ritchie.cs.ubc.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I'm trying to get my DH55HC's sensors working. Detection indicates
w83627dhg-isa-0a10 as the device. According to the wiki at
<http://lm-sensors.org/wiki/VoltageLabelsAndScaling>, this chip is
capable of reading 8 mV/LSb. Here's the problem: the division ratio
doesn't make sense! In the BIOS, I observed the following values on the
12 V rail:

11.828
11.844
11.859

The difference between these values is 15 or 16 mV. But 12 V / 0.016
V/LSb = 750 LSb! Since these sensor chips don't read raw values above
255, how in the world am I getting 16 mV resolution on a 12 V input?
I'm seeing similar results on my 5 V rail, which returns values just 2
mV apart in the BIOS, and on my so-called "Memory V_SM" rail (2 mV) and
"+Vccp" rail (differences as small as 1 mV being displayed).

Any ideas?

Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
