From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Mon, 04 Dec 2006 17:28:55 +0000
Subject: [lm-sensors] testing w83627hf treiber?
Message-Id: <45745AD7.50809@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061204090602.07b8d41b.khali@linux-fr.org>
In-Reply-To: <20061204090602.07b8d41b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Mon, 04 Dec 2006 09:14:53 +0100, Udo van den Heuvel wrote:
>> Jean Delvare wrote:
>>> See, this is exactly the reason why we don't reset the chip by default:
>>> to preserve BIOS settings.
>> In that case Thomas really has a problem:
>>
>> Either his fans won't work or the temperature will be off.
>> (in my situation it looks like it is just the fans)
>>
>> So how can we fix this?
> 
> As I said already: look into the BIOS menu for options to adjust or
> disable the automatic fan speed control.

Will try this later this week, since the Ek8000 having this issue is my
only firewall.
I will find a moment to investigate. Maybe I can check the manual for
such an option as well.

What system does Thmas run?

Udo


