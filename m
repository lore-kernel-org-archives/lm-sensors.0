From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 23 Jun 2008 17:46:24 +0000
Subject: Re: [lm-sensors] Call for 2.10.7
Message-Id: <485FE170.2090304@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080623132019.549ae84e@hyperion.delvare>
In-Reply-To: <20080623132019.549ae84e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Mon, 23 Jun 2008 13:20:19 +0200, Jean Delvare wrote:
>> Hi all,
>>
>> Due to a compatibility issue between lm-sensors 2.10.6 and the upcoming
>> kernel 2.6.26 when option THERMAL is enabled, we have to release
>> lm-sensors 2.10.7 soon.
>>
>> There aren't that many changes as this is a legacy branch, nothing
>> worth mentioning here I think. See CHANGES in SVN trunk for the details.
>>
>> Proposed schedule:
>> * June 29th: SVN freeze
>> * June 30th - July 6th: testing
>> * July 7th: release
>>
>> Let me know if there is any problem with this.
> 
> Thinking about it some more, it would probably be better if lm-sensors
> 2.10.7 was released before kernel 2.6.26. And kernel 2.6.26 could be
> released soon, as we're at RC7 already. So maybe the following schedule
> would be better:
> 
> * June 25th: SVN freeze
> * June 26th-30th: testing
> * July 1st: release
> 
> This is admittedly tight but OTOH there's little activity on this
> legacy branch so I do not expect much problems (and I doubt a looser
> schedule would help find more bugs anyway.)
> 

+1

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
