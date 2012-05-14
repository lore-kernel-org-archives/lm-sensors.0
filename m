From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 May 2012 18:57:17 +0000
Subject: Re: [lm-sensors] asus_atk0110 doesn't work on motherboard P8B WS
Message-Id: <20120514205717.1d9b4f2c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAAF8EA.3070202@free.fr>
In-Reply-To: <4FAAF8EA.3070202@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 14 May 2012 20:44:08 +0200, ACCART Julien wrote:
> The BIOS of this motherboard can display CPU and M/B temp, voltage, fan 
> speed.
> Do you think we can use the asus wmi modules to read these data?
> How can I help?

Did you try just running sensors-detect and loading the proper drivers?
Who knows, this may just work. If not, booting with
acpi_enforce_resources=lax might be a workaround if you can live with
the risk.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
