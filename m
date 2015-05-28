From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 28 May 2015 10:58:15 +0000
Subject: Re: [lm-sensors] sensors-detect and my monitor
Message-Id: <20150528125815.4d169832@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20150516T211122-274@post.gmane.org>
In-Reply-To: <loom.20150516T211122-274@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 28 May 2015 12:10:49 +0200, Jean Delvare wrote:
> Sensors-detect OTOH reads register values in completely random order so
> it is difficult to know which was the last one.

For the record: I instrumented the exact version of sensors-detect your
used and it would seem that the last I2C transaction for address 0x4f
was reading from register 0xbf. So if my theory is correct that would
be the value the mysterious chip was set to when your display was in
the broken state.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
