From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Thu, 20 Oct 2005 22:21:40 +0000
Subject: [lm-sensors] Support for SMSC 47M15x/192
Message-Id: <200510202219.13948.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510162303.21468.pavouk@pavouk.org>
In-Reply-To: <200510162303.21468.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> The smsc47m1 driver from Linux 2.6.13.4 should work just fine. Support
> for this chip was added in 2.6.13-rc1. The (minor) problem you have here
> is that your version of sensors-detect is a bit old and doesn't know
> that (fixed in lm_sensors 2.9.2).

Thanks for help. Fan measuring works now with lm_sensors 2.9.2.

sensors output:
--------------
smsc47m1-isa-0800
Adapter: ISA adapter
fan1:        0 RPM  (min =  640 RPM, div = 8)          ALARM
fan2:     1059 RPM  (min =  640 RPM, div = 8)
--------------

I look at motherboard, and there is exactly LPC47M997-NR SMSC I/O chip.
There are probably hardware monitoring block, which is not supported by
this driver. I look at bios and Winblows program PC Alert, and there are
available System and CPU Temperature. Voltages are not supported.
I searched with Google, but datasheet for this chip is not available.
What can I do next for temperature reporting?

There was some discussion about this chip: 
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket76

Best regards,

Pavel Ruzicka
