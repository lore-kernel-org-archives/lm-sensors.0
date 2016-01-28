From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Jan 2016 05:48:24 +0000
Subject: Re: [lm-sensors] Problems with lm-sensors web site / Wiki
Message-Id: <56A9ABA8.6020008@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <56A78A98.9040208@sat.dundee.ac.uk>
In-Reply-To: <56A78A98.9040208@sat.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 01/27/2016 10:06 AM, phil@philedelbrock.com wrote:
>
>> On Jan 27, 2016, at 9:12 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 01/27/2016 01:17 AM, Philip Edelbrock wrote:
>>>
>>>> On Jan 26, 2016, at 7:33 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 01/26/2016 07:02 AM, Paul Crawford wrote:
>>>>> I was just checking the wiki (that used to be) on the www.lm-sensors.=
org
>>>>> site and it looks as if someone has messed up the Apache web server, =
as
>>>>> it only has a directory 'ht' with a .rpm file in it.
>>>>>
>>>>> Does anyone know who is looking after the site and/or if this is being
>>>>> fixed?
>>>>>
>>>>
>>>> The maintainer is not reachable. I think we'll have to re-create the s=
ite
>>>> from scratch.
>>>>
>>>> Guenter
>>>
>>>
>>> Yes, unfortunately.  I see www.lm-sensors.org is pointing to the httptu=
nnel project, which is definitely not us.
>>>
>>> I just wish we had a copy of the Trac and database with all the pages a=
nd such=85 ugggg.  That=92s a bit upsetting.
>>>
>> Most or at least some of it can be found in web caches, though it will b=
e a bit of work.
>>
>>> I could set something up where the web files are on Github and we can h=
ave multiple authors.  If nothing else, somebody could always take the Gith=
ub files and run with them without having to track down a former MIA admin.
>>>
>>> It probably won=92t be too soon, though, I=92m a bit swamped with my da=
y job but I=92ll try to get something going soon with multiple admins.  I=
=92m open to other ideas, too.  I own lm-sensors.org and can get the DNS to=
 point anywhere.
>>>
>>
>> Is it possible to set up a wiki ? No idea how the back-end storage would=
 work, though.
>> We'll definitely want it backed up this time.
>>
>> Guenter
>>
>
>
> Most recent Internet Archive for lm-sensors.org is here: https://web.arch=
ive.org/web/20150905145034/http://www.lm-sensors.org/
>
> Plenty of good stuff there to copy and paste from.
>
> And I definitely agree with the sentiment on backing things up! ;=92)
>
> For hosting, I=92ll get an instance of Heroku going with a basic Ruby on =
Rails app (it can serve static pages, too, which is probably all we=92ll ne=
ed to start with): https://www.heroku.com
>
> It is free for a =91hobby=92 account which includes a PostgreSQL database=
 (up to 10,000 rows for free, I think).  They are actually an Amazon AWS re=
seller.  It pulls right from a GitHub project I'll create.  Even if all the=
 admins go MIA, the project could be cloned from github by anyone and keep =
things going.
>
> In between other work I=92ll try to get something going and give people a=
ccess to it who want to contribute.  Perhaps even this week.
>

Sounds good.

Thanks!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
