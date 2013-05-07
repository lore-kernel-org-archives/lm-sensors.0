From: "luke.leighton" <luke.leighton@gmail.com>
Date: Tue, 07 May 2013 07:38:04 +0000
Subject: Re: [lm-sensors] Gigabyte GA-Z77N-ITX Motherboard it87 sensors module (SuperIO chip ITE 8728)
Message-Id: <CAPweEDyaMwKuXkj5H8xnJDYD2GjrJ6uWKubqdKSRWanARmqSAw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPweEDz7mv+eouxQeNxL=bxEafZwFgG3BsMW+shK9bhapjVeeA@mail.gmail.com>
In-Reply-To: <CAPweEDz7mv+eouxQeNxL=bxEafZwFgG3BsMW+shK9bhapjVeeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 7, 2013 at 8:03 AM, Jean Delvare <khali@linux-fr.org> wrote:

>>     modprobe it87 force_id=0x8720
>
> Thanks for sharing your findings. Obviously I already knew about it
> all, but your post might help others in similar situations.

 with the right keywords, aaanything is possible :)

>> also, the following page http://www.lm-sensors.org/wiki/Devices was
>> also quite terse and not immediately very helpful.  if the advice
>> about force_id had been on the wiki page, i would have saved about 2
>> hours of searching.
>
> Good point. However I'm not sure where I would add the information and
> in what form. The force_id parameter isn't it87-specific, it is
> supported by 11 different hwmon drivers, covering something 20 or 30
> different devices. In general it is also better if users can build a
> standalone driver because this gives them the right device name
> matching the configuration file for their board (if one exists.)

 in debian this is generally discouraged.  in the work environment in
which i find myself it is a *definite* no.  we have enough to deal
with in the fact that this is only available for 3.2.0 rather than
2.6.32.  we will need to do at least 2 to 3 months of testing before
3.2.0 can be *considered* to be put into production.

 and we would need to either create a debian package for the
stand-alone driver or compile ... no, we would not be able to compile
on the box because that would mean that the 800 machines in the field
would need to have gcc installed, that would mean 100% CPU for short
durations which would disrupt the customer, so no, definitely a debian
package, and that's a lot of work.

 basically it is often completely impractical to use the standalone
driver, or quite a lot of work.


> That being said, I agree that not all users can build the standalone
> driver.

 ... or it's a significant burden to do so, as well as requiring
months of testing before going live.

> Also the cases where passing the force_id parameter works
> perfectly are rather rare. So I decided to add a note about force_id in
> the IT8728F entry only.

 that works.  that works very well.  H77N could do with being added to
the list of gigabyte motherboards in that entry, it only lists 67 so
far.

 l.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
