From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 28 Mar 2006 09:36:39 +0000
Subject: [lm-sensors] What is the status for drivers for the SMSC
Message-Id: <20060328113639.df5ca322.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <d7a66840603272032m42b97167nfa2e63b6078baa43@mail.gmail.com>
In-Reply-To: <d7a66840603272032m42b97167nfa2e63b6078baa43@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Todd,

> I have the following:
> 
> kernel: 2.6.16 (custom compile with AMD Cool'n'Quiet Driver Version 1.50.03)
> motherboard: MSI MS-7184
> cpu: AMD Athlon 64 X2 3800+
> ram: 1GB
> 
> When running sensors-detect, the output is:
> 
> # I2C adapter drivers
> i2c-isa
> # I2C chip drivers
> # no driver for SMSC 47M15x/192 Super IO Fan Sensors yet
> 
> What is the status for drivers for the SMSC 47M15x/192 Super IO Fan Sensors?

It's supported by the smsc47m1 driver since 2.6.14, so it should work
fine for you, just "modprobe smsc47m1".

The problem here is that sensors-detect isn't aware that the support
was added. We only updated the information in lm_sensors 2.9.2, so I
guess you have an older version. Except for the incomplete driver
listing in sensors-detect, it should still work OK.

> Probing for PCI bus adapters...
> Use driver `to-be-written' for device 00:14.0: ATI Technologies Inc ATI SMBus
> Probe succesfully concluded.

Note that we now have support for this SMBus master. It requires this patch:
http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-piix4-add-ati-smbus-support.patch
Which will be merged in mainline soon.

You may have additional devices behind that master. In particular, the
SMSC LPC47M192 chip is know to have voltage and temperature sensors,
for which support is being added these days. You motherboard may or may
not make use of this feature.

-- 
Jean Delvare

