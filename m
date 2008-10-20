From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 20 Oct 2008 17:48:28 +0000
Subject: Re: [lm-sensors] Fintek F71862FG
Message-Id: <48FCC46C.8060907@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2e01cfe50810121347xeac7909kd144dd0f7f13769d@mail.gmail.com>
In-Reply-To: <2e01cfe50810121347xeac7909kd144dd0f7f13769d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 20 Oct 2008 17:09:31 +0200, Hans de Goede wrote:
>> Tony McConnell wrote:
>>> I've got a Jetway NC81-LF board with an AM2 4850e processor. The k8temp 
>>> hwmon driver reports rubbish for the core temperatures... don't worry, 
>>> I'm not going to ask why.
>>>
>>> The board also has a Fintek F71862FG Super IO sensor on board which is 
>>> listed as recognised but not supported by the lm-sensors website.
>>>
>>> Messed around a bit (a tiny bit) with the f71882fg driver, adding the 
>>> chip ID (0x0601), and it appears to work so far as reporting fan speeds 
>>> and cpu/case temperatures.
>>>
>> Note to people interested in F71862FG I've just mailed a patch to the list 
>> adding support for the F71862FG to the f71882fg driver.
> 
> Please update the F71862FG entry in wiki/Devices accordingly.
> 

Done.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
