From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 18 Nov 2008 15:39:28 +0000
Subject: Re: [lm-sensors] Making the ticket system private
Message-Id: <191fb4ca0811180739k43850d9bybc9435a3d20e0833@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081118100005.5b20a857@hyperion.delvare>
In-Reply-To: <20081118100005.5b20a857@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Makes sense to me. Once a bug has been identified it should be entered
into the ticketing system for tracking purposes though.

...juerg


On Tue, Nov 18, 2008 at 3:09 AM, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> Jean Delvare wrote:
>> Hi all,
>>
>> Most tickets created in trac by the "ticket" user (i.e. anonymous
>> users) are of the "I can't get sensors to work on my system" type. In
>> most cases, this is either because the user did something wrong (didn't
>> run sensors-detect, or didn't load the required modules, or is running
>> an old kernel or old version of lm-sensors) or because the machine in
>> question simply doesn't have any supported hardware monitoring chip. In
>> other words, that's not a bug.
>>
>> I'd rather see these requests go to the lm-sensors mailing list, where
>> 298 persons are reading them, than in the ticket system where only 12
>> persons are notified and 4 of them have a personal account on the
>> ticket system to actually help. (In theory, anonymous users can help as
>> well, using the "ticket" account, but in practice it never happens.) I
>> think the chances for users to get an answer within a reasonable time
>> would be significantly higher on the mailing list.
>>
>> On top of that, the fact that users have to use the "ticket" account to
>> create new tickets and follow-up on them is pretty annoying. In many
>> cases users forget to mention their e-mail address so they don't get
>> notified when we reply later on, which means they are wasting their
>> time reporting the problem and we are wasting our time trying to solve
>> it. Or they give their address in later comments and we have to add it
>> manually, which is extra work for us.
>>
>> So I would like to propose the deletion of the "ticket" account. I
>> value the ticket system very much when it comes to development. As a
>> development tool for tracking progress towards the next milestone, the
>> ticket system makes a lot of sense. But as a bug tracking tool for the
>> public, it sucks. As a matter of fact, we have 53 tickets open at the
>> moment, 10 of which were opened in 2006, and 14 in 2007. Honestly, most
>> of these tickets are rotting in place. I don't get the point of putting
>> issues in a tracking system if they get ignored in the end anyway. If
>> we do not have the manpower for and/or interest in tracking these
>> public tickets, then it's better for everyone to not let them be
>> created in the first place. At least, when posting to a mailing list,
>> people know that if they don't get an answer within a week, odds are
>> that they won't get an answer at all and they should try a different
>> approach.
>>
>
> This gets a +1 from me.
>
> Regards,
>
> Hans
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
