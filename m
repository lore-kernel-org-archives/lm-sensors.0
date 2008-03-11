From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Mar 2008 12:34:07 +0000
Subject: Re: [lm-sensors] Kernel driver w83793
Message-Id: <20080311133407.50d86385@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47D5AF8E.5040300@assembler.cz>
In-Reply-To: <47D5AF8E.5040300@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 10 Mar 2008 23:00:46 +0100, Rudolf Marek wrote:
> It would be nice if you could run following commands and save output for me.
> Please do that when the driver is unloaded (if in kernel, just make sure that
> there is no access to /sys interface)
> 
> You will also need a i2c-dev (module)
> 
> i2cdump -l

Actually: i2cdetect -l

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
