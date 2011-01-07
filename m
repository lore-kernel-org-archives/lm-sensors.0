From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 07 Jan 2011 10:59:00 +0000
Subject: Re: [lm-sensors] Use of swab16() in drivers/hwmon/*.c
Message-Id: <20110107115900.497914ef@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D26ECDB.7010602@antcom.de>
In-Reply-To: <4D26ECDB.7010602@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Roland,

On Fri, 07 Jan 2011 11:37:15 +0100, Roland Stigge wrote:
> I wonder about a specific use of swab16() in several files
> in drivers/hwmon/.
> 
> Consider ds1621.c: We get big endian words from
> i2c_smbus_read_word_data(). To use it on a little endian arch, the
> driver uses swab16() for conversion by swapping bytes unconditionally.
> 
> IMHO this is not suitable on a big endian architecture. Shouldn't it be
> sth. like be16_to_cpu()?

This has nothing to do with the host's endianess. This has to do with
the fact that the SMBus specification says that words are sent low byte
first but almost all hardware monitoring devices send the high byte
first (because it makes a lot more sense.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
