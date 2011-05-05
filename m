From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 May 2011 10:10:52 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110505121052.468b5ff3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harry,

On Thu, 14 Apr 2011 09:57:23 +0200, Jean Delvare wrote:
> Meanwhile I've added detection support to sensors-detect:
>   http://khali.linux-fr.org/devel/misc/sensors-detect
> If you could test and report, that would be great. Proper detection of
> the chip may bring more user requests to support the chip (although the
> old age of the chip makes this event rather unlikely.)

Can you please test?

> A register dump of the chip would be welcome too. You can obtain it by
> loading the i2c-dev kernel driver and running i2cdump (from the
> i2c-tools package):
> 
> # modprobe i2c-dev
> # i2cdump N 0x2e
> 
> where N is the i2c bus number displayed by sensors-detect, and 0x2e the
> actual chip address on that bus (can be one of 0x2c, 0x2d or 0x2e.)

Can I get this register dump, please?

> Ric, out of curiosity, are you still interested in EMC6W201 support?

Ric?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
