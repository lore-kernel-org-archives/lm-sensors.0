From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: Accessing i2c subsystem from within a kernel module
Message-Id: <414B8785.6020107@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <414B7664.9000006@lfcorreia.dyndns.org>
In-Reply-To: <414B7664.9000006@lfcorreia.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you don't use the /dev/i2c* interface, you use the exported functions in i2c-core.c,
as documented in doc/writing-clients.

Luis Correia wrote:
> Hi!
> 
> This question may or may not be related to lm_sensors, but you guys
> are the I2C master around here.
> 
> I have a small embedded hardware (PcEngines) that I whish to include
> a LCD display to use with lcd4linux.
> 
> For that I'm adapting a ppdev emulator driver, but now I need to know
> if I can (and how) access the /dev/i2c-* interface from within a
> kernel driver itself.
> 
> This is probably a very dumb question....
> 
> 
> Thanks!
> 
> Luis Correia
> Bering-uClibc Team Member
> 
> 
