From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Bugzilla setup for Lm_sensors
Message-Id: <WsmP13hA.1105961888.9307330.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41E718CA.3070305@edgedesign.us>
In-Reply-To: <41E718CA.3070305@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

> How will be situations as driver merge/name
> change/ or obsoleted driver/ handled? Do you plan to change name
> of sis-645 to obsoleted sis-645 or make special cathegory/whatever?

This doesn't concern that many drivers so I don't think this will be a
problem. People will simply pick the driver they use and have an issue
with. We don't much care if that driver used to have a different name
or has been obsoleted by a newer driver. IOW I would suggest as many
items as we have or had driver names, regardless of the state of driver
(we definitely have to forget what we know about the driver's history
and only consider what the user knows - i.e. not much).

> How for 2.6 kernels how for 2.4 tree?

I guess that we will have a field for the kernel version (free input?) as
well as for the lm_sensors version (drop down list?). This should be
sufficient to figure out what the reporter's setup is. Anything special
you were about to suggest?

--
Jean
