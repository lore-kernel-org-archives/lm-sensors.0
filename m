From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 24 Feb 2015 12:11:04 +0000
Subject: Re: [lm-sensors] ITE 8620E Support
Message-Id: <20150224131104.6f65d549@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <543DD4BE.9000308@roadrunner.com>
In-Reply-To: <543DD4BE.9000308@roadrunner.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jay,

On Tue, 14 Oct 2014 18:58:22 -0700, Jay Foster wrote:
> I have a new Gigabyte Z97X-UD5H motherboard that has the ITE 8620E 
> chip.  I see on the wiki/Devices site that there is no driver for it.  
> The notes state that you can try loading the it87 module with the 
> force_id=0x8728 option.  I can confirm that this did succeed and sensors 
> reports voltages and fan speeds.  I don't know if fan speed control works.

Thanks for the report. Can you please share the actual output of
"sensors" with us?

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
