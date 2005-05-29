From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 29 May 2005 22:42:05 +0000
Subject: [lm-sensors] SMSC LPC47M192 - "Device is disabled, will not use"
Message-Id: <429A2904.8040500@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <429A1930.6040409@gmail.com>
In-Reply-To: <429A1930.6040409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hello,
> In the dmesg output it says:
> 
> smsc47m1: Found SMSC LPC47M15x/LPC47M192
> smsc47m1: Device is disabled, will not use
> 
> What does this mean? How do I get this chip to tell me fan speed and CPU
> temperature (if that's even what it does?)?

It means that the logical device is disabled and it most cases it means that this chip is not used for hw. monitoring.
Please can you tell us your motherboard brand and model?
Also please run sensors-detect script include whole output in your next email.
Tell us what version of kernel and lm_sensors you use.

We can try to forcibly enable in future.

Thanks

Regards

Rudolf


