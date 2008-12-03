From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Dec 2008 19:18:05 +0000
Subject: Re: [lm-sensors] sensors-detect: testers wanted!
Message-Id: <20081203201805.6b7e69a8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081203182216.5be504cf@hyperion.delvare>
In-Reply-To: <20081203182216.5be504cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean-Marc,

Thanks for testing and reporting.

On Wed, 3 Dec 2008 13:25:10 -0500, Jean-Marc Spaggiari wrote:
> Here is what I have with your version:
> 
> Driver `it87':
>   * ISA bus, address 0xe80
>     Chip `ITE IT8720F Super IO Sensors' (confidence: 9)
> 
> Driver `to-be-written':
>   * Chip `AMD K10 thermal sensors' (confidence: 9)
> 
> 
> And here is what I had with the previous one:
> 
> Driver `it87' (should be inserted):
>   Detects correctly:
>   * ISA bus, address 0xe80
>     Chip `ITE IT8720 Super IO Sensors' (confidence: 9)
> 
> Driver `k8temp' (should be inserted):
>   Detects correctly:
>   * Chip `AMD K10 thermal sensors' (confidence: 9)
> 
> 
> I'm not 100% sur why I had a K8 before and a K10 with this new
> version. I remember that I have apply a patch in the kernel to handle
> Phenom internal sensors, but since this is kernel related, I think it
> should have no impact on the sensors-detect script. I will try to
> install and compile a brand next 2.6.27.7 kernel and retest.

You have a K10 (actually: family 10h) in both cases. What changed is
the device->driver mapping. At some point we thought that family 10h
support could be added to the k8temp driver, but now it seems that we
will have a separate driver for the family 10h CPUs. So this change is
expected.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
