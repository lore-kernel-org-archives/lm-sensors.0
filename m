From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Jun 2008 15:52:32 +0000
Subject: Re: [lm-sensors] v1211 fan control
Message-Id: <20080612175232.630c748a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
In-Reply-To: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 12 Jun 2008 08:32:02 -0700, Juerg Haefliger wrote:
> (...) The
> temp4 values only swing between 2011 and 2022, I don't know if that's
> reasonable for a thermistor, maybe others on the list can shed some
> light. But it's certainly not the CPU, maybe an on-board thermistor or
> nothing at all.

It would be unreasonably stable for an actual temperature. Could be a
voltage sensor though. As I recall, the VT1211 has a configuration
register to switch some channels between voltage mode and temperature
mode. The driver assumes that the BIOS configured the channels
properly, but maybe it is not the case on Sergio's system?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
