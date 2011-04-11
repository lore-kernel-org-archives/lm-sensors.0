From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Mon, 11 Apr 2011 22:14:26 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (sht15) add checksum validation
Message-Id: <1302559776-sup-3925@sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302198246-22212-4-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1302198246-22212-4-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Excerpts from Jonathan Cameron's message of 2011-04-08 14:33:07 -0400:
> Why a u8? It is boolean. Obviously that'll work in a u8 but it almost
> implicitly implies it might contain some data.
> > +    u8                checksumming;

Ok, I've updated flags with the bool type.

> If it's a flag, perhaps u8 implies it might be something other than 0 or 1.
> Admittedly this is true of some of the other elements, but we live and learn.
> >      u8                flag;

As it represents the different states the driver may be in (i.e. what
action it is doing), I've changed it to an enumeration of actions
(nothing, reading temp or humid).

Regards,
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
