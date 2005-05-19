From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: New subscription request to list lm-sensors from
Message-Id: <20050516204117.7d5529bd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4288E1AD.5080909@edgedesign.us>
In-Reply-To: <4288E1AD.5080909@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I got this, so I assume it's working. ;')
> 
> Phil
> 
> lm-sensors-owner@lm-sensors.org wrote:
> > Your authorization is required for a mailing list subscription
> > request approval:
> > 
> >     For:  khali@linux-fr.org
> >     List: lm-sensors@lm-sensors.org
> > 
> > At your convenience, visit:
> > 
> >     http://lists.lm-sensors.org/mailman/admindb/lm-sensors
> > 	
> > to process the request.
> > 

Actually I disabled this for both list, as I don't think we want to
constantly monitor who's joining the list. Anyone who wants to subscribe
can do so.

Sooooo. We have two lists set up (lm-sensors and lm-sensors commit).
I've changed some options and think things are now fine. Rudolf Marek
and I made some tests on lm-sensors and it seems to work just fine. I
think we are ready to move on.

I set the lm-sensors list so that non-members can post. I set the
lm-sensors-commit list so that only members can post, except for the CVS
robot.

Philip, checklist:

1* Copy and paste the subscriber list from the old list to the new one.
You can omit Rudolf and me, as we're already there.

2* Make sure that the ticket system will advertise the new list instead
of the old one.

3* Block the old list, make it send a message pointing the users to
http://www.lm-sensors.nu/, where relevant information will be available
(soon).

4* Kill the lm78@ address.

5* Edit the CVS trigger that posted commit information to the old list,
so that it now posts them to the new lm-sensors-commit list.

Axel, checklist:

1* Blast the test messages from the lm-sensors archive.

Me, checklist:

1* Search and replace all the references to the old list in i2c,
lm_sensors2, website, linux.

Let's go :)

-- 
Jean Delvare
