From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Oct 2010 16:24:43 +0000
Subject: Re: [lm-sensors] Driver for SMSC SCH5627 needed
Message-Id: <20101021182443.188a8d6f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CBD8E44.8070909@ts.fujitsu.com>
In-Reply-To: <4CBD8E44.8070909@ts.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 21 Oct 2010 17:47:20 +0200, Juerg Haefliger wrote:
> Hi Rainer,
> 
> 
> > I received the datasheet from SMSC but under NDA, so I can't share it.
> > I'll check it against the currently supported chips to see if we have
> > something compatible or fairly close. Give me a few days though...
> 
> Took a quick glance at the datasheet. This is a totally different
> beast that is not even remotely compatible to anything we support thus
> far AFAIK. It contains an embedded microcontroller (!) which handles
> all the hwmon related tasks. The datasheet that I received doesn't
> contain any information about the microcontroller other than a simple
> block diagram. So at the moment it's absolutely a no go and even with
> all the technical data we would have to start from scratch with a new
> driver.

Thanks Juerg for checking this. Can you please update sensors-detect
with the device name and features, and also create an entry in
wiki/Devices? So that other user with that chip know the current
status, even if it's bad.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
