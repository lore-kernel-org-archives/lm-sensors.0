From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 06 Feb 2006 13:10:13 +0000
Subject: [lm-sensors] [PATCH 11/11] fancontrol.init
Message-Id: <1xIAfIOP.1139231413.4385260.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <7E87AA2D-989B-4787-8ACE-4C46A63DAB27@hawaii.rr.com>
In-Reply-To: <7E87AA2D-989B-4787-8ACE-4C46A63DAB27@hawaii.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dean,

Please start a new thread when starting a new topic.

On 2006-02-06, Dean Takemori wrote:
> Submitted for the upcoming 2.10.0 release:  To upgrade the
> fancontrol.init script to the version I've been using for a while now
> on an FC1 system.

Please list the changes between the old and the new version. Are these
bug fixes? New features? The diff is very large (compared to the size of
the script) and it looks much like a complete rewrite to me, while we
want incremental changes.

Also there is a lot of noise due to reindentation. This makes the review
very difficult. Please separate the coding style cleanups from the
functional changes.

If there are any bug fixes in there, please extract them and send a
minimal patch for 2.10.0. We are not going to merge a complete rewrite
right before a release.

Thanks,
--
Jean Delvare

