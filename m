From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 24 Oct 2007 12:39:06 +0000
Subject: Re: [lm-sensors] svn commit: r4959 -
Message-Id: <471F3CEA.4000309@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071019232531.3c767d99@hyperion.delvare>
In-Reply-To: <20071019232531.3c767d99@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
>>       Author: jwrdegoede
>>         Date: Fri Oct 19 11:48:49 2007
>> New Revision: 4959
>>    Changeset: http://lm-sensors.org/changeset/4959
>>
>> Modified:
>>    lm-sensors/branches/lm-sensors-3.0.0/etc/sensors.conf.eg
>>
>> Log:
>> The new fschmd driver uses the standard scaling values from the datasheet, so no conversion should be done from sensors.conf
> 
> I am worried by this change, for two reasons. The first reason is that
> the original comment was suggesting that the scaling resistors for the
> Hermes were external and could change from one motherboard to the next,
> while your new fschmd driver handles the scaling internally.

I don't know where the resistors are, as the "datasheet" which we have gives no 
details on this.

> If the
> resistors are actually external, then your driver should not do the
> scaling. Please clarify.
>

There are 3 reasons to do the scaling in the driver:
1) The used scale values are taken 1 on 1 from the fscher "datasheet"
2) They are all we have, the old driver directly exported register values
    which is not compliant with the sysfs interface
3) The new unified driver behaves identical for the fscpos and fscscy as the
    old drivers, the old fscher driver was the only fsc driver which didn't do
    scaling (no scaling at all, as said it directly exported register values
    which is not compliant with the sysfs interface)

> The second reason is that your change to sensors.conf.eg breaks the
> original fscher driver. I understand that the two drivers are not
> compatible in this respect (for now at least) so you can't have a
> single default configuration file that works for both, but you really
> should document the problem so that users have a chance to fix the
> config file for use with the old fscher driver. In other words, instead
> of deleting this section from the configuration file, you should have
> commented it out and added a note that users of the old driver must
> uncomment it again.
> 

Agreed, I'll put it back in commented for the 3.x.x branch, and a comment that 
the lines should be commented to the trunk sensors.conf

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
