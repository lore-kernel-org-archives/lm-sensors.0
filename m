From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 01 Mar 2007 08:13:36 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <45E68B30.7090409@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Jasper, please don't send HTML-only e-mails to the lm-sensors list.
> 
> Jasper Alias wrote:
>> Agreed we should be able to include both base info and
>> system info into the system. Maybe we can check the values in
>> those fields and then let the system decide with of the two
>> contains the most sensible info and select that info field to
>> be used.
> 
> It might be non-trivial to determine which fields contain relevant
> information and which do not. If the fields are empty it's clear they
> aren't relevant, but sometimes vendors put random crap in the fields
> instead, such as "None" or "System Manufacturer" or "To Be Filled By
> O.E.M.". Anyway, as Hans suggested, we don't really need to find out
> which fields are most relevant. We can use all four fields as the key
> to identify the motherboard, if parts of the key aren't meaningful it
> doesn't really matter.
> 

Exactly, except when the whole key isn't relevant, iow all 4 Fields 
contain crap / are to generic to uniquely identify a motherboard.

That is why we need a queue on the website for new motherboard dmi-info 
+ lm-sensors-config submissions, and that queue needs to be checked 
manually, we cannot expect well meaning end-users to make the decission 
of the DMI info is unique enough. And on top of that a rating system 
where people can say, good config works for me too, or crappy config 
doesn't work.

Regards,

Hans

