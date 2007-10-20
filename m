From: Dick Middleton <dick@fouter.net>
Date: Sat, 20 Oct 2007 09:38:38 +0000
Subject: Re: [lm-sensors] k8temp does produce sensible results
Message-Id: <4719CC9E.6080805@fouter.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <47014943.9080104@fouter.net>
In-Reply-To: <47014943.9080104@fouter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> On Sun, 07 Oct 2007 18:58:32 +0100, Dick Middleton wrote:
>> Sensors-detect finds:
>>
>> Driver `f71882fg' (should be inserted):
>>    Detects correctly:
>>    * ISA bus, address 0x600
>>      Chip `Fintek F71882FG/F71883FG Super IO Sensors' (confidence: 9)
>> (...)
>>
>> I don't have the f71882fg driver although I am thinking that is the one I need.
> 
> Correct. This driver is new in (upcoming) kernel 2.4.24, so you'll have
> to use a bleeding edge kernel if you want it, or wait a bit.

Thanks for the clarification. I assume you mean 2.6.24 ;-)

Dick





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
