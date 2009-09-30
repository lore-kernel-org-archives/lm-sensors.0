From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 30 Sep 2009 08:10:33 +0000
Subject: Re: [lm-sensors] sensors.conf manpage name
Message-Id: <4AC31279.1020106@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AC1C369.8090901@redhat.com>
In-Reply-To: <4AC1C369.8090901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 09/29/2009 02:57 PM, Jean Delvare wrote:
> Hi Hans,
>
> On Tue, 29 Sep 2009 10:20:57 +0200, Hans de Goede wrote:
>> I just received this bug report:
>> https://bugzilla.redhat.com/show_bug.cgi?idR6178
>>
>> Which makes sense, so now I was thinking how to best handle this. We
>> can make a sensors3.conf.5 symlink to sensors.conf.5 or we can just
>> rename it. There is something to be said for both cases.
>>
>> sensors3.conf is the new default name, but sensors.conf is still used
>> as a fallback by libsensors.
>>
>> So what is your 2 cents on this ?
>
> I believe a symlink would solve the problem better. If we rename the
> man page, then I can see old-timers complain next time they try "man
> sensors.conf" and it fails. And as you said, both names are equally
> valid.
>

Ok, so a symlink it is. Hmm:

[hans@localhost trunk]$ svn update
svn: OPTIONS of 'http://lm-sensors.org/svn/lm-sensors/trunk': could not connect to server (http://lm-sensors.org)
[hans@localhost trunk]$

Am I doing something wrong, or ?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
