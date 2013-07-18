From: Satoshi Imamura <s.imamura@qub.ac.uk>
Date: Thu, 18 Jul 2013 14:51:33 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon, fam15h_power: Tweak runavg_range on resume
Message-Id: <E6436667-B728-4226-A061-5768E2462900@qub.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120920103408.GD4602@alberich>
In-Reply-To: <20120920103408.GD4602@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thank you very much for your cooperation.

Regards,

Satoshi

-- 
Satoshi Imamura
Visiting Researcher
School of Electronics, Electrical Engineering and Computer Science
Queen's University of Belfast
Email: s.imamura@qub.ac.uk

On Jul 18, 2013, at 3:47 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Satoshi,
> 
> On Wed, 17 Jul 2013 21:35:43 +0000 (UTC), Satoshi Imamura wrote:
>> Hello Mr. Andreas Herrmann,
> 
> I don't think Andreas is still reading the lm-sensors list, so I am
> adding him to Cc.
> 
>> I'm trying to measure power consumption of AMD Opteron 6272 using fam15h_power.
>> Linux kernel version is 3.9.4.
>> Even when all cores are idle, fam15h_power shows about 85W.
>> However, the power consumption decreases to about 74W
>> when a process is executed with all cores.
>> 
>> For Linux kernel 3.9.4, the patch for fam15h_power is already applied.
>> Moreover, "RunAvgRange" (p. 460 of BKDG for Family 15h) is 
>> appropriately set to "0x9" as following:
>> 
>> % setpci -s 00:18.5 0xe0.l
>> % 00372c99
>> 
>> Why is the power consumption so high (85W) when all cores are idle?
>> Why does it decrease when a process is executed with all cores?
>> I would appreciate if you could give me a advice.
>> 
>> Sincerely yours,
>> 
>> Satoshi


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
