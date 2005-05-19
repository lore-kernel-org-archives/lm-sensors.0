From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: 0410132248 - sensors-detect does not detect correctly.
Message-Id: <Pine.LNX.4.58.0410140038170.9204@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041013212149.GA10319@warpcore.positronic.net>
In-Reply-To: <20041013212149.GA10319@warpcore.positronic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Driver `via686a' (should be inserted):
>   Detects correctly:
>   * ISA bus, undetermined address (Busdriver `i2c-isa')
>     Chip `VIA Technologies VT82C686 Integrated Sensors' (confidence: 9)
>

Hello,

try

modprobe i2c-isa
modprobe via686a force_addr=0x290
sensors

Regards

Rudolf
