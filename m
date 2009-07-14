From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 14 Jul 2009 13:23:51 +0000
Subject: Re: [lm-sensors] resume lm_sensor from hibernate or suspend
Message-Id: <4A5C93CB.4010304@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A5C7322.6090409@redhat.com>
In-Reply-To: <4A5C7322.6090409@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/14/2009 01:59 PM, Nikola Pajkovsky wrote:
> Hi guys,
>
>      I'd like to talk about bug
> https://bugzilla.redhat.com/show_bug.cgi?idH6874. Hans says that's not
> good idea resume automatically with sensors -s in
> /usr/lib/pm-utils/sleep.d.
> Do you have any other idea?
>

Hi,

Thanks for taking this discussion here!

I'm not saying that this necessarily is a bad idea, I'm just not sure it is
a good idea. I cannot think of any side effects from the top of my head,
but maybe others can.

Also if we do a script doing this to be placed in /usr/lib/pm-utils/sleep.d
then we should do this in upstream lm_sensors, so that all distro's get it
(and there do turn out to be issues we have one central place to fix this).

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
