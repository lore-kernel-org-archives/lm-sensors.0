From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: lmsensors ticket #1144
Message-Id: <3E6A656B.5020200@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <37554.10.20.2.100.1046454982.squirrel@deathstar.of.rocnet.de>
In-Reply-To: <37554.10.20.2.100.1046454982.squirrel@deathstar.of.rocnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

very strange.
Please verify that you are using the latest 'sensors' that you compiled
(probably in /usr/local/bin) and that you don't have old libsensors files
in /usr/lib.

Claus Rosenberger wrote:
> hello,
> 
> i don't know why sensors reports "no sensors found" because i can get
> following informations out of /proc :
> 
> /proc/bus/i2c:
> i2c-0   dummy           ISA main adapter                        ISA bus
> algorithm
> 
> /proc/bus/i2c-0:
> 290     IT87 chip                               IT87xx sensor driver
> 
> /proc/sys/dev/sensors/chips:
> 256     it87-isa-0290
> 
> /proc/sys/dev/sensors/it87-isa-0290/fan1:
> 3000 3245
> 
> there are a lot of files in /proc/sys/dev/sensors/it87-isa-0290 and
> sometimes there are values in. why sensors don't report this values ?
> 
> regards
> 
> claus rosenberger
> 
> 
