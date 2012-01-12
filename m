From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Jan 2012 06:58:55 +0000
Subject: Re: [lm-sensors] Chipset not supported
Message-Id: <20120112075855.1e69b3c0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F09C52B.7070904@gmail.com>
In-Reply-To: <4F09C52B.7070904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

On Sun, 08 Jan 2012 11:32:43 -0500, Charles Wolf wrote:
> Hello, I'm having temperature issues with my chipset, but it's not on 
> the support list. I don't know how to help add things, and it sait to 
> mail it out to the mailing list, so here it is, I am using a laptop with 
> the Mobile Intel PM965 chipset. I'd help make it work, if someone told 
> me what I need, or someone can do it themselves. I'm willing to help 
> anyway I can. Thank you :D

Most laptops don't have usable sensors (other than the ACPI thermal
zones and CPU integrated thermal sensors). Anyway we can't say anything
about your specific system without seeing the complete output of the
latest version of sensors-detect:
  http://dl.lm-sensors.org/lm-sensors/files/

Also please check if the BIOS display voltage or fan speed values. If
it doesn't (as is the case of most laptops) then there's probably no
monitoring chip on this system so nothing we can do.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
