From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Fri, 03 Feb 2006 20:50:38 +0000
Subject: [lm-sensors] LM-Sensors with 2.6.14 and SMSC 47M997 on
Message-Id: <200602032150.38295.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060203091816.783B912E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20060203091816.783B912E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> I am looking to get full sensors support for both fan and temperature
> monitoring on my Gigabyte 8I865GVMF motherboard.  I have run sensors-detect
> and determined that I have an SMSC 47M192 or compatible (motherboard
> inspection shows a SMSC 47M997 device which is allegedly compatible) and I
> have successfully installed the sm47m1 driver which was with the kernel.

Are you sure, that this chip have support for voltages?
I have this chip on my motherboard (RS480M2-IL), and I have not support
for voltages. Only FAN measuring, regulation and temperatures.
Look at your BIOS if you have voltages there.
If not, probably voltage measuring will not be supported on your board.

Best regards,

Pavel Ruzicka

