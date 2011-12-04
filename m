From: Charles <c@catcons.co.uk>
Date: Sun, 04 Dec 2011 16:30:21 +0000
Subject: Re: [lm-sensors] Enhancement request: fancontrol error messages to
Message-Id: <4EDB9D4D.2010704@catcons.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4ED8A09B.20601@catcons.co.uk>
In-Reply-To: <4ED8A09B.20601@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/12/11 20:03, Jean Delvare wrote:
>> > How about modifying the fancontrol script to write error messages to stderr?
>> > 
>> > It would be more conventional and, for example could be used to make it
>> > less verbose -- while allowing any error messages to appear -- when run
>> > from boot scripts  by something like:
>> > 
>> > fancontrol > /dev/null
> I agree this makes sense. I've made the necessary changes, please give a try to:
>   http://khali.linux-fr.org/devel/misc/fancontrol
> Make sure you don't get a cached version, as I just updated it.
> 
> If it works OK for you, I'll commit both changes to the repository.

Thanks Jean :)

It tests OK (no output) when run by

fancontrol >/dev/null &

Best

Charles


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
