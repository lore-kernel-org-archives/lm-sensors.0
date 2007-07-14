From: Vadim Zeitlin <vz-sensors@zeitlins.org>
Date: Sat, 14 Jul 2007 14:41:00 +0000
Subject: Re: [lm-sensors] [PATCH] v1 Intel FB-DIMM AMB temperature sensor
Message-Id: <E1I9io5-0007hj-JZ@teufli.physik.fu-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713014814.GS3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713014814.GS3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong <djwong <at> us.ibm.com> writes:

> Here's a first draft of a driver to report FB-DIMM temperatures via the AMB
> chips on systems with the Intel 5000 series chipset.  I've tested this
> on an IBM IntelliStation Z30, an IBM x3650 and an IBM x3550, and haven't seen
> any problems so far.  Please let me know about any problems that you
> notice with this driver, and please cc me because I'm not subscribed to
> the list.

 Hello again,

 I've tested this driver with kernel 2.6.20 with Tyan i5000XT motherboard
and it seems to work fine for me:

# grep . /sys/devices/platform/i5k_amb.0/temp*input
/sys/devices/platform/i5k_amb.0/temp0_input:78500
/sys/devices/platform/i5k_amb.0/temp16_input:75000
/sys/devices/platform/i5k_amb.0/temp32_input:64000
/sys/devices/platform/i5k_amb.0/temp48_input:63500

 Thanks!
VZ


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
