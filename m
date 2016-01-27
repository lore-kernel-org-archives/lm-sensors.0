From: phil@philedelbrock.com
Date: Wed, 27 Jan 2016 18:06:29 +0000
Subject: Re: [lm-sensors] Problems with lm-sensors web site / Wiki
Message-Id: <6552F9EE-5474-4849-B7CC-95FC8261C21A@philedelbrock.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <56A78A98.9040208@sat.dundee.ac.uk>
In-Reply-To: <56A78A98.9040208@sat.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> On Jan 27, 2016, at 9:12 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> On 01/27/2016 01:17 AM, Philip Edelbrock wrote:
>>=20
>>> On Jan 26, 2016, at 7:33 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>=20
>>> On 01/26/2016 07:02 AM, Paul Crawford wrote:
>>>> I was just checking the wiki (that used to be) on the www.lm-sensors.o=
rg
>>>> site and it looks as if someone has messed up the Apache web server, as
>>>> it only has a directory 'ht' with a .rpm file in it.
>>>>=20
>>>> Does anyone know who is looking after the site and/or if this is being
>>>> fixed?
>>>>=20
>>>=20
>>> The maintainer is not reachable. I think we'll have to re-create the si=
te
>>> from scratch.
>>>=20
>>> Guenter
>>=20
>>=20
>> Yes, unfortunately.  I see www.lm-sensors.org is pointing to the httptun=
nel project, which is definitely not us.
>>=20
>> I just wish we had a copy of the Trac and database with all the pages an=
d such=85 ugggg.  That=92s a bit upsetting.
>>=20
> Most or at least some of it can be found in web caches, though it will be=
 a bit of work.
>=20
>> I could set something up where the web files are on Github and we can ha=
ve multiple authors.  If nothing else, somebody could always take the Githu=
b files and run with them without having to track down a former MIA admin.
>>=20
>> It probably won=92t be too soon, though, I=92m a bit swamped with my day=
 job but I=92ll try to get something going soon with multiple admins.  I=92=
m open to other ideas, too.  I own lm-sensors.org and can get the DNS to po=
int anywhere.
>>=20
>=20
> Is it possible to set up a wiki ? No idea how the back-end storage would =
work, though.
> We'll definitely want it backed up this time.
>=20
> Guenter
>=20


Most recent Internet Archive for lm-sensors.org is here: https://web.archiv=
e.org/web/20150905145034/http://www.lm-sensors.org/

Plenty of good stuff there to copy and paste from.

And I definitely agree with the sentiment on backing things up! ;=92)

For hosting, I=92ll get an instance of Heroku going with a basic Ruby on Ra=
ils app (it can serve static pages, too, which is probably all we=92ll need=
 to start with): https://www.heroku.com

It is free for a =91hobby=92 account which includes a PostgreSQL database (=
up to 10,000 rows for free, I think).  They are actually an Amazon AWS rese=
ller.  It pulls right from a GitHub project I'll create.  Even if all the a=
dmins go MIA, the project could be cloned from github by anyone and keep th=
ings going.

In between other work I=92ll try to get something going and give people acc=
ess to it who want to contribute.  Perhaps even this week.

Thanks!


Phil
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
