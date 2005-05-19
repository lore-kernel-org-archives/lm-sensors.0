From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: Ticket # 1263
Message-Id: <3F05D7AB.7030008@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE3B050.37FBA117@godden.net>
In-Reply-To: <3EE3B050.37FBA117@godden.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

look at your board, see what chips are on it, look at new drivers page, see FAQ

Wim Godden wrote:
> How can I find out what I2C bus I have ?
> 
> "Mark D. Studebaker" wrote:
> 
> 
>>the 791D is an i2c-only chip, it isn't on the ISA bus.
>>If sensors-detect CVS can't find it then it's on an I2C bus that we don't have a driver for.
>>Sorry.
>>
>>Wim Godden wrote:
>>
>>>Still no result, I'm afraid.
>>>Probing for `Winbond W83781D'
>>>  Trying address 0x0290... Failed!
>>>
>>>
>>>"Mark D. Studebaker" wrote:
>>>
>>>
>>>
>>>>791D support just checked into w83781d.c and sensors-detect in CVS, give it a try.
>>>>
>>>>Wim Godden wrote:
>>>>
>>>>
>>>>>The Character C errors are gone, but the chip still isn't detected,
>>>>>although it should be supported now.
>>>>>It's a Winbond 83791, but I see :
>>>>>
>>>>>Probing for `Winbond W83781D'
>>>>> Trying address 0x0290... Failed!
>>>>>
>>>>>Any suggestions welcome...
>>>>>
>>>>>
>>>
>>>
> 
> --
> ------
> Colocation/housing kosten te hoog --> http://www.housingcenter.be
> --
> DomainWatch.be - Welke goede .be domeinnamen komen er vrij ? Pre-registreer ze hier !
> --
> Adverteren.be - 100% Nederlandstalig adverteren op kwalitatief hoogstaande sites !
> 
> 
