From: Timothy Normand Miller <theosib@gmail.com>
Date: Fri, 21 Aug 2009 00:13:32 +0000
Subject: Re: [lm-sensors] fancontrol using 100 megs?
Message-Id: <9871ee5f0908201713s6943e226i36c39139da99cae4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9871ee5f0908201427g2c23367awa83ab27ddce9337f@mail.gmail.com>
In-Reply-To: <9871ee5f0908201427g2c23367awa83ab27ddce9337f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Aug 20, 2009 at 7:47 PM, HUSSON Pierre-Hugues<phhusson@free.fr> wro=
te:
> Le jeudi 20 ao=FBt 2009 23:27:35, Timothy Normand Miller a =E9crit :
>> I've had my Linux box up for weeks. =A0I was looking at top and noticed
>> that the VIRT column for fancontrol said "100m". =A0Now, I know you're
>> supposed to take VIRT with a grain of salt because it includes all
>> kinds of things like shared memory, etc. =A0But isn't 100 megs a bit
>> excessive? =A0Isn't this just a shell script?
>>
>> BTW, RES and SHR are 2944 and 504, respectively.
> The VIRT column doesn't mean anything on linux (and any other modern OS),
> well, it's the allocated memory size. The actual memory consumption inclu=
ding
> libraries is RES+SHR, so 3.5MB, which seems fine to me for that.
> But if you prefer, you can rewrite it in plain C, with all the debuggings=
 and
> so on to gain maybe 2MiB :)

I'm not really worried about it.  I'm just trying to make sure it's
not the cause of swapping.  Thanks.  :)

--=20
Timothy Normand Miller
http://www.cse.ohio-state.edu/~millerti
Open Graphics Project

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
