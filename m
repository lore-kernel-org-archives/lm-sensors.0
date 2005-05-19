From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: EP-9NDA3+ w/ Winbond W83627THF LPC
Message-Id: <GqsEfIh3.1103277215.4479040.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
In-Reply-To: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> i have a nForce3 250GB Ultra motherboard "EPoX EP-9NDA3+" that has the
> "Winbond W83627THF LPC" chip...

How do you know it has this chip? Did sensors-detect tell you?

> but some odd reason i can't get it to work..
>
> localhost erek # modprobe w83627hf
> FATAL: Error inserting w83627hf
> (/lib/modules/2.6.8.1/kernel/drivers/i2c/chips/w83627hf.ko): No such
> device
> localhost erek #
>
> i don't understand what's wrong?

Look at your logs (/var/log/messages or dmesg) right after the loading
fails. There should be a more detailed explanation there, maybe the chip
is there but disabled by the BIOS or something like that.

--
Jean Delvare
