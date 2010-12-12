From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Dec 2010 21:22:51 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101212222251.1a03235c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 12 Dec 2010 21:57:34 +0100, Jean Delvare wrote:
> Strange. The address is different from the one sensors-detect reported
> (0x800.)

Oh well, after reading the code it's all OK, there's an offset of 0x70
to the relevant register, so the difference is expected.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
