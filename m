From: roger@planbit.co.uk (Roger Lucas)
Date: Fri, 03 Feb 2006 09:16:31 +0000
Subject: [lm-sensors] LM-Sensors with 2.6.14 and SMSC 47M997 on
Message-Id: <20060203091816.783B912E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I am looking to get full sensors support for both fan and temperature
monitoring on my Gigabyte 8I865GVMF motherboard.  I have run sensors-detect
and determined that I have an SMSC 47M192 or compatible (motherboard
inspection shows a SMSC 47M997 device which is allegedly compatible) and I
have successfully installed the sm47m1 driver which was with the kernel.

I now have fan speed detection working fine but no voltage or temperature
detection.

I would like to have the full fan/temp/voltage information available, so I
have a few questions:

1) Do I just have an old version of the code and a later version (?2.6.15?)
has a full functioning hardware monitor?
2) If the 2.6 version only supports fan monitoring, is anyone else working
on adding the temp/volt functionality (I know that there is a 2.4 kernel
version of such code)?
3) Does anyone know the reason why the temp/volt monitoring wasn't included
in the 2.6 driver (it seems odd to go to all the work of creating the driver
just to monitor the fan speeds)?

Thanks in advance,

Roger



