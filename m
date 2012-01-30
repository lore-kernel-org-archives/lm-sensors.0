From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Jan 2012 07:15:55 +0000
Subject: Re: [lm-sensors] SMBus and i801
Message-Id: <20120130081555.03d68cab@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F25FEE1.1010201@papillon.ru>
In-Reply-To: <4F25FEE1.1010201@papillon.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 30 Jan 2012 08:22:25 +0600, 189 Lytkin Anton (PROG) wrote:
> I know some of "lm-sensors" developers wrote module for i2c-i801. I hope 
> you can advice me what to do: I faced with incompatibility for some 
> devices as they are using 16bit reg address, but smbus specs assumes 
> only 8bit command. Is there any workarounds?
> Device is simple cmos sensor - mt9j003.

Wrong list. You should ask on linux-i2c:
http://vger.kernel.org/vger-lists.html#linux-i2c

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
