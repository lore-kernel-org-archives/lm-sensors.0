From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Jul 2013 15:21:10 +0000
Subject: Re: [lm-sensors] Missing Fintek F71868AD chip
Message-Id: <20130716172110.43dfcc51@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <51B329D9.30802@orange.fr>
In-Reply-To: <51B329D9.30802@orange.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 13 Jul 2013 13:02:51 +0000 (UTC), zthomas wrote:
> Hans de Goede <hdegoede <at> redhat.com> writes:
> 
> > So it is impossible to tell. The safe thing to do is to contact fintek 
> for
> > a datasheet, once we've that we can see if an existing driver can be
> > easily modified to support this new chip.
> 
> 
> My MSI Z77-G43 seems to have the same chip.  I am willing
> to test whatever driver you create.  My kernel is 3.8.13.

We have a datasheet now but no driver yet. I have added you to the
request list in the wiki.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
