From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 16 Jun 2010 10:51:35 +0000
Subject: Re: [lm-sensors] Issue with SMSC EMC2700LPC
Message-Id: <AANLkTilHvYNE3iZfaIqP4XPlN9m1Pvjc5Gi8PYHv0K6V@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1276681506.2903.104.camel@basilisk>
In-Reply-To: <1276681506.2903.104.camel@basilisk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

>
> Yes, Juerg
> It is a Dell Poweredge T710

Then we're out of luck. It most likely is a Dell specific SMSC part
and they won't provide a datasheet for it. At least not to an HP guy
like me :-)

..juerg



>
> On Wed, 2010-06-16 at 12:14 +0200, Juerg Haefliger wrote:
>
> Is this a Dell machine?
>
> ...juerg
>
> On Wed, Jun 16, 2010 at 12:12 PM, Juan A. Moya
> <juan.a.moya@elastix-corp.com> wrote:
> >
> > Oh... thanks for the quick answer
> > I'm submitting a query to SMSC, funny enough they don't have this part listed in their catalog.
> > Conspiracy theories?? let's see :)
> >
> >
> >
> > On Wed, 2010-06-16 at 12:03 +0200, Jean Delvare wrote:
> >
> > Hi Juan,
> >
> > On Wed, 16 Jun 2010 11:45:06 +0200, Juan A. Moya wrote:
> > > Hi list!
> > > I can see that from version 3.0.3 you support SMSC EMC2700LPC part. But
> >
> > No. From version 3.0.3 we support _detection of_ the SMSC EMC2700LPC
> > part in sensors-detect. Nothing more.
> >
> > > I don't see in the available drivers list any entry to tell the linux
> > > kernel module I must load.
> > >
> > > sensors-detect tool says:
> > > Probing for Super-I/O at 0x2e/0x2f
> > > Trying family `SMSC'...                                     Yes
> > > Found `SMSC EMC2700LPC Super IO'
> > >     (no information available)
> > >
> > > Any idea?
> >
> > We don't even know if this part includes hardware monitoring features.
> > Do you have any reason to believe it does?
> >
> >
> >
> >
> > --
> >
> > Juan Antonio Moya
> >
> > R&D Engineer, Elastix Corporation
> > Sant Joan de La Salle 42, 4th floor
> > 08022 Barcelona (Spain)
> > Email: juan.a.moya@elastix-corp.com
> > Web:   http://www.elastix-corp.com
> >
> >
> > Disclaimer -- The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information.
> >
> >
> >
> >
> >
> >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>
>
> --
>
> Juan Antonio Moya
>
> R&D Engineer, Elastix Corporation
> Sant Joan de La Salle 42, 4th floor
> 08022 Barcelona (Spain)
> Email: juan.a.moya@elastix-corp.com
> Web:   http://www.elastix-corp.com
>
>
> Disclaimer -- The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information.
>
>
>
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
