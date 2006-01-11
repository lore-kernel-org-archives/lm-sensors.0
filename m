From: avolkov@varma-el.com (Andrey Volkov)
Date: Wed, 11 Jan 2006 19:03:24 +0000
Subject: [lm-sensors] [RFC] i2c: Combined ST m41txx i2c rtc chip driver
Message-Id: <43C5567C.8070106@varma-el.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <20051116025714.GK5546@mag.az.mvista.com> <20051219210325.GA21696@mag.az.mvista.com> <43A7D76E.5050008@varma-el.com> <20060111000912.GA11471@mag.az.mvista.com> <43C4D275.2070505@varma-el.com> <20060111161954.GB6405@mag.az.mvista.com>
In-Reply-To: <20060111161954.GB6405@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>, Jean Delvare <khali@linux-fr.org>
Cc: adi@hexapodia.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Mark,

Mark A. Greer wrote:
> On Wed, Jan 11, 2006 at 12:40:05PM +0300, Andrey Volkov wrote:
> 
>>
>>Mark A. Greer wrote:
>>
>>>On Tue, Dec 20, 2005 at 01:05:34PM +0300, Andrey Volkov wrote:
>>>
>>>
>>>>Hello Mark
>>>>
>>>>Big Thanks, I check it on my board today-tomorrow.
>>>>But check some comments below.
>>>
>>>
>>>Did you have a chance to test it?
>>>
>>
>>I testing it now (holidays, sorry).
>>Aprrox 3-4 hours delay.
> 
> 
> No problem.  Just curious if it works for you.
> Please let me know.
> 
> Thanks,
> 
> Mark
> 
Attached patch fix some misspellings and, mainly,
_reset_ HT flag. If this flag is set, then STM418xx
doesn't run in spite of ST flag state.
With this patch my board work ok.

P.S. Jean, "i2c_master_send vs i2c_smbus_write_byte_data"
problem still open.
Could you made executive decision about it?

-- 
Regards
Andrey Volkov
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 01-stm_combind_fixes.diff
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060111/662a70d3/01-stm_combind_fixes.pl
