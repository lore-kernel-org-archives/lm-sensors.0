From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 08 Apr 2014 14:47:48 +0000
Subject: Re: [lm-sensors] MCP68 SE not listed
Message-Id: <20140408164748.679abf6c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <14733-1396967453-397931@sneakemail.com>
In-Reply-To: <14733-1396967453-397931@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lucas,

On Tue, 8 Apr 2014 14:30:53 +0000, Lucas Malor wrote:
> Hi all. I have an old Asus M4N68T-M LE V2. For what I see in its documentation, its chip is the Nvidia MCP68 SE. Unfortunately it is not present in your device list. 

It's indeed not listed. But if the PCI ID of the SMBus block is the
same as a supported chip, it could still work. Please share the output
of:

# lspci -nn | grep SMBus

(or the full output of "lspci -nn" if the above doesn't return
anything.)

> Currently I'm using the module it87, sugested by sensors-detect. Is this one the correct module, or i2c-nforce2 is the good one?

You can't compare it87 to i2c-nforce2. The former is a driver for the
integrated sensors in a Super-I/O (LPC) chip. The latter is a driver
for the SMBus controller in nVidia's south bridges. i2c-nforce2 won't
provide hardware monitoring information directly. It could, however,
give you access to the SMBus, to which other hardware monitoring chips
could be connected.

Most boards have a single hardware monitoring chip, so if the it87
driver works for you, you might be set already. However Asus made a
number of boards with two monitoring chips, so if you think some inputs
are missing with just it87, then maybe you need i2c-nforce2 + another
driver.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
