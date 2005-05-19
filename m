From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: [W.Braun@HSTee.de: Troubles with i2c-piix4]
Message-Id: <20030706172405.1c928e95.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703124231.GB575@frodo.local>
In-Reply-To: <20030703124231.GB575@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Problem:
> ===> Module "i2c-piix4" does not load like expected, see the following
> answers to my commands
> 
> SRV-LIN-01:/ # modprobe i2c-piix4
> /lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o:
> init_module: Operation not permitted
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters.
>       You may find more information in syslog or the output from dmesg
> /lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o: insmod
> /lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o failed
> /lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o: insmod
> i2c-piix4 failed
> 
> SRV-LIN-01:/ # modprobe i2c-piix4 force=1
> /lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o:
> init_module: Operation not permitted
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters.
>       You may find more information in syslog or the output from dmesg
> /lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o: insmod
> /lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o failed
> /lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o: insmod
> i2c-piix4 failed

What make you think you have a PIIX4 onboard? Did sensors-detect found
it for you?

Which version of LM Sensors are you using?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
