From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 02 May 2014 06:04:07 +0000
Subject: Re: [lm-sensors] how to get SPD in Sandy or Ivy bridge ?
Message-Id: <20140502080407.0faf8015@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <53631823.9050208@yandex.com>
In-Reply-To: <53631823.9050208@yandex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 02 May 2014 07:59:31 +0400, Black.S wrote:
> Hello
> 
> For get SPD earle I used utility decode-dimms that use kernel module 
> eeprom. But now it does not work, as I understand it because module 
> eeprom in Sandy Bridge with integrated memory controller no longer 
> communicates with EEPROM.
> 
> I was hoping that getting SPD will be support later but support is still 
> not there.
> 
> May be this question is not for topic of this forum, but I do not know 
> where to properly place the question.

This is indeed off-topic here, as this has nothing to do with hardware
monitoring.

Try the linux-i2c discussion list instead:
http://vger.kernel.org/vger-lists.html#linux-i2c

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
