From: Wolfgang Grandegger <wg@grandegger.com>
Date: Thu, 25 Sep 2008 10:17:00 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: w83781d: converting to
Message-Id: <48DB651C.4030309@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CB7DC8.3060503@grandegger.com>
In-Reply-To: <48CB7DC8.3060503@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Wolfgang,
> 
> On Thu, 25 Sep 2008 11:38:12 +0200, Wolfgang Grandegger wrote:
>> Hi Jean,
>>
>> Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> I made another effort to convert the w83781d to new-style binding. The
>>> series consists of the following two patches:
>>>
>>>   [PATCH 1/2] hwmon: w83781d: make ISA interface depend on CONFIG_ISA
>>>   [PATCH 2/2] hwmon: w83781d: use new style driver binding
>>>
>>> I have tested it one a PowerPC MPC8544 board. I did not have any
>>> occasion to verify the ISA related part.
>> did you have found some time to look at these patches for the w83781?
> 
> Not yet, sorry. This is on my to-do list but this list is growing huge
> and I am _very_ busy these days (essentially real-life problems which
> take precedence over lm-sensors fun.)

No problem. Kernel hacking fun takes time, I know very well.

Wolfgang.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
