From: Mathieu Jobin <mathieu@justbudget.com>
Date: Wed, 10 Aug 2011 02:29:58 +0000
Subject: Re: [lm-sensors] Support for the Fintek F71889ED (found f.e. on the
Message-Id: <3A195EE8-CB37-4F69-8AA6-AC2F796071D8@justbudget.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <616631172.20100723004130@eikelenboom.it>
In-Reply-To: <616631172.20100723004130@eikelenboom.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is what I get running kernel 3.0 rc6

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `to-be-written':
  * ISA bus, address 0x600
    Chip `Fintek F71889E Super IO Sensors' (confidence: 9)

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 10h thermal sensors' (confidence: 9)

Note: there is no driver for Fintek F71889E Super IO Sensors yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.

No modules to load, skipping modules configuration.

Unloading i2c-dev... OK
Unloading cpuid... OK




On 2011-07-30, at 03:44 , Hans de Goede wrote:

> Hi,
> 
> On 07/30/2011 06:58 AM, Mathieu Jobin wrote:
>> following the thread http://comments.gmane.org/gmane.linux.drivers.sensors/22652
>> 
>> any update on this?
>> 
> 
> Yes, see:
> http://www.lm-sensors.org/wiki/Devices
> 
> The F71889ED is supported in kernel-2.6.39 and later, and
> detected by the latest sensors-detect version.
> 
> Regards,
> 
> Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
