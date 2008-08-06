From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Aug 2008 08:24:44 +0000
Subject: Re: [lm-sensors] Unable to turn cooling device on
Message-Id: <20080806102444.5a5a9f2a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Wed, 30 Jul 2008 16:48:35 -0700, Paul Campbell wrote:
> I am running an older Compaq Presario 2600cl with Fedora 9
> I am getting these messages.
> I update BIOS to most recent ( Nov, 2004 )
> I have googled and worked this  problem for several hours,
> but I am still not able to stop the messages every 2-4 seconds:
> 
> Jul 31 17:13:37 sissy kernel: ACPI: Unable to turn cooling device
> [f7811f18] 'on'
> Jul 31 17:13:39 sissy kernel: w83627hf: Found W83697HF chip at 0x290
> #This is where I restarted lm_sensors
> Jul 31 17:13:43 sissy kernel: ACPI: Unable to turn cooling device
> [f7811f18] 'on'
> Jul 31 17:13:49 sissy kernel: ACPI: Unable to turn cooling device
> [f7811f18] 'on':
> (...)

This is an ACPI issue, so you're on the wrong list. Please report to
the ACPI folks.

The only thing I can suggest is that you try to not load the w83627hf
driver and see if the messages go away. Maybe the w83627hf driver is
interfering with ACPI somehow.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
