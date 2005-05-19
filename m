From: floyd@barrow.com (Floyd L. Davidson)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: tellerstats shell scripts from lm_sensors
Message-Id: <87llfd3ixc.fld@barrow.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4140888C.4060806@edgedesign.us>
In-Reply-To: <4140888C.4060806@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:
>
>OK, I added the links on our page.
>
>That said, this doesn't prevent you from submitting your changes sliced
>if you think they belong to our package.
>
>Thanks.

Sounds good Jean, thanks.

As for the program to init the W83627HF Super IO chip on Tyan
motherboards, I don't really think it fits into lm_sensors as
such, and probably is best that it be something people find on
your list of links.  I'll probably set up a project on
freshmeat.org for it too.

However, I should just donate some time to the cause...  and go
through the tellerstats scripts again with the intent of
incremental patches that would result in a more universal script
than what I'm using now.  I'll give it a try in a few days.

BTW, I'm still working on just the /right/ set of example
graphs.  As I write this I'm doing a stress test with repeated
compilation of the Linux kernel using "make -j2 MAKE='make -j2'"
in a loop that runs for half an hour.  I takes several hours for
things to stabalize again after running it, and I want the 48
hour graph to show two of them 24 hours apart.  So tomorrow
about this time I may have the graphs I want.  It makes for a
great demo of the potential for using the graphs as a trouble
shooting tool!  (I'm a nerd, I just love the data.)

  Have a good day,
  Floyd

-- 
Floyd L. Davidson           <http://web.newsguy.com/floyd_davidson>
Ukpeagvik "Place where people hunt snowy owls"     (Barrow, Alaska)
