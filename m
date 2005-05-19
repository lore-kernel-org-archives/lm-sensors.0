From: amartin@eurielec.etsit.upm.es (Alejandro Martinez)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: Ticket #1734 patch OK
Message-Id: <20040802101704.GA1792@eurielec.etsit.upm.es>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The proposed patch for ticket #1734 worked fine on a 2.6.7

Now the i2c bus is there:
  Installed I2C busses:
      i2c-0       unknown         SMBus SIS630 adapter at 1080
	  Algorithm unavailable

sensors-detect only scans ISA and Super I/O buses and fails to
find any chip. But as sensors was already configured, it works:
mc1066-i2c-0-4e
Adapter: SMBus SIS630 adapter at 1080
..

Thanks
