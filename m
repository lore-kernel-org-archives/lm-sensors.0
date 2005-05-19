From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: database
Message-Id: <287910000.1042125029@krabat.ahsoftware>
List-Id: <lm-sensors.vger.kernel.org>
References: <89950000.1034392779@krabat.ahsoftware>
In-Reply-To: <89950000.1034392779@krabat.ahsoftware>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

late answer but first I was very busy, and then I've made some weeks 
without computer. ;)

--On Sonntag, Oktober 20, 2002 19:38:20 -0400 "Mark D. Studebaker" 
<mds@paradyne.com> wrote:

> you're on the right track.
> Didn't realize submissions didn't work yet :)
>
> You can take defaults from the current etc/sensors.conf.eg.
> Sorry I don't quite understand your gl518sm question.

The question is if I could use in0 for vdd, or if those names (vdd and vin1 
in the example) are hardcoded in the driver.


I hope to get some this week to finish it.

Regards, Alexander



>
> The file doc/developers/proc may also give you some good info.
>
> I would change "inputs" to "voltage inputs".
> Also, fans and temps can have compute lines, not just voltages.
>
> mds
>
>
> Alexander Holler wrote:
>>
>> Hi Mark,
>>
>> --On Donnerstag, Oktober 17, 2002 09:43:42 -0400 Mark Studebaker
>> <mds@paradyne.com> wrote:
>>
>> > way cool. what a great start.
>> > I think it's ready for a link on our home page.
>>
>> Uh, but it isn't working.
>>
>> > A couple of suggestions for the database page -
>> > - a link back to our home page would be good
>> > - A link for comments/suggestions/bugs would be good. Do we want them
>> > to submit   bugs on berlios, or email Alexander, or email sensors?
>>
>> I would prefer mail. But I have already enough mail. ;)
>>
>> > - Some descriptions / disclaimers would be good. These are submitted by
>> > users, not   verified or tested by us, etc, etc, etc
>> > - some field in the database of who submitted the entry, how to
>> > contact, etc.
>>
>> ok, but up to now, nobody can submit anything. ;)
>>
>> What I need to know is, if the system behind would work. E.g. on chip
>> gl518sm there is a vdd and vin1, can I use label in0 "+5V" on that chip?
>>
>> Regards,
>>
>> Alexander
>

