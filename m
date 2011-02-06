From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Sun, 06 Feb 2011 10:14:09 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <70A4B8A7E6AF453C8F763A3EA5F9D7D2@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



--------------------------------------------------
From: "Jean Delvare" <khali@linux-fr.org>
Sent: Sunday, February 06, 2011 11:00 AM
To: "Guenter Roeck" <guenter.roeck@ericsson.com>
Cc: "Andrea Rizzolo" <andrea.rizzolo@gmail.com>; <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F, 
NCT6776F

> On Sun, 6 Feb 2011 10:56:29 +0100, Jean Delvare wrote:
>> As for the other chips in this family, in2, in3, in7 and in8 are
>> internal voltages so their mapping and scaling is fixed. The pin names
>> also strongly suggest connecting Vcore to in0, and I've never seen a
>> board manufacturer diverge from this. So you can start with the
>> following config statements:
>>
>> chip "nct6775-*" "nct66776-*"
>
> Err, typo here of course, I meant:
>
> chip "nct6775-*" "nct6776-*"
>
> Sorry.
>
>>
>>     label in0 "Vcore"
>>     label in2 "AVCC"
>>     label in3 "+3.3V"
>>     label in7 "3VSB"
>>     label in8 "Vbat"
>>
>>     set in2_min  3.3 * 0.90
>>     set in2_max  3.3 * 1.10
>>     set in3_min  3.3 * 0.90
>>     set in3_max  3.3 * 1.10
>>     set in7_min  3.3 * 0.90
>>     set in7_max  3.3 * 1.10
>>     set in8_min  3.0 * 0.90
>>     set in8_max  3.0 * 1.10
>>
>> This leaves only 4 voltage inputs to configure, presumably for +5V,
>> +12V, and possibly 5VSB and Vdimm. Check the labels and values in the
>> BIOS (write them all down if they fluctuate) and maybe we can figure it
>> out.
>>
>
>
> -- 
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

OK, That might take some time, the box is currently transcoding/processing a 
large job and I don't really want to stop it and restart it.

Regards
Ian Dobson
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
