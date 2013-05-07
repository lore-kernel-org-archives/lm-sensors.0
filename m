From: "luke.leighton" <luke.leighton@gmail.com>
Date: Tue, 07 May 2013 15:24:38 +0000
Subject: Re: [lm-sensors] Gigabyte GA-Z77N-ITX Motherboard it87 sensors module (SuperIO chip ITE 8728)
Message-Id: <CAPweEDzhYuhZ6M7yUBk-s6fyqSvmcWHhisU+fKzLSZYF-N+N5w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPweEDz7mv+eouxQeNxL=bxEafZwFgG3BsMW+shK9bhapjVeeA@mail.gmail.com>
In-Reply-To: <CAPweEDz7mv+eouxQeNxL=bxEafZwFgG3BsMW+shK9bhapjVeeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 7, 2013 at 4:07 PM, Guenter Roeck <linux@roeck-us.net> wrote:

>>  well... it kinda helps to identify it.  i did a search "H77N" - i did
>> *not* do a search by "SuperIO" or even "it87" - it was only after
>> spotting that text "unrecognised SuperIO chip" did i begin to track
>> things down.
>>
> Maybe, but H77 vs. it87 is really completely unrelated.

 ok i get it now.  H77N is not the designation of the motherboard, but
an intel chipset.  in which case i absolutely agree with you.

> The information should really be in the Gigabyte manual. Now, turns out that
> a Google search for "gigabyte h77n superio" returns the SuperIO chip as first
> response. Not really sure how we could do better than that.

 also based on this being only related to linux kernel 3.2.... wait....
http://www.h-online.com/open/news/item/Debian-7-0-will-use-3-2-kernel-1425560.html

 yep, linux 3.2 is definitely going to be around for a looong time [it
was only released in january!!]

 something to think about...

> What may make sense is a note telling people to look for the SuperIO
> chip on their board, not for any of the Intel chips. A database with
> motherboards and matching SuperIO chips might make sense too, though
> I am relatively sure that something like this already exists. If not,
> you are of course welcome to create such a database and maintain it.

 loovely :)  if i had a dozen boards i was investigating, i definitely would :)

> Thanks,
> Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
