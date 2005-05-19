From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: i2c-i801.o (fwd)
Message-Id: <35sipVi1.1111133963.8708780.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSO.4.58.0503171700270.26676@mpi.mpi-softtech.com>
In-Reply-To: <Pine.GSO.4.58.0503171700270.26676@mpi.mpi-softtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

> i2c-i801.o version 2.6.5 (20020915)
> i2c-i801.o: Error: Can't detect I801, function 3!
> i2c-i801.o: I801 not detected, module not inserted.
>
> while lspci gives the output
> 00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller
>   (rev 02)

The version of lm_sensors you are using (2.6.5) is very old. Support for
the Intel 82801EB (ICH5) was added in lm_sensors 2.8.0, so you need at
least this version.

--
Jean Delvare
