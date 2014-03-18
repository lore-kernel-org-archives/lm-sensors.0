From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 18 Mar 2014 09:39:52 +0000
Subject: Re: [lm-sensors] IT8620E/IT8623E vs. IT8603E
Message-Id: <20140318103952.573d8e93@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140316120945.4dc8b28c@endymion.delvare>
In-Reply-To: <20140316120945.4dc8b28c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 18 Mar 2014 10:29:43 +0100, Rudolf Marek wrote:
> Hi Jean
> 
> According to 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2013-August/039551.html
> 
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0x8623
>       (logical device 4 has address 0x290, could be sensors)
> 
> It has the ID of it8623. Will you have a time to prepare the patch or should I?

I will take care of sensors-detect and the wiki, and would appreciate
if you could write the patch for the it87 driver.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
