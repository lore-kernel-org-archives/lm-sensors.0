From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 29 Jul 2008 23:57:56 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] applesmc: add support for Macbook v3.
Message-Id: <20080729165756.48dc9d39.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1216814135.5834.9.camel@sirius>
	<488F30F7.4030804@boichat.ch>
	<488F323E.6040403@boichat.ch>
In-Reply-To: <488F323E.6040403@boichat.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>
Cc: mhoffman@lightlink.com, roberto@unbit.it, mactel-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, khali@linux-fr.org, lm-sensors@lm-sensors.org, guilherme.m.schroeder@gmail.com

On Tue, 29 Jul 2008 23:07:42 +0800
Nicolas Boichat <nicolas@boichat.ch> wrote:

> 
> This patches adds support for Macbook v3 (sensors and accelerometer).

Anally changed to "Add support for ...".  There is no need to put the
text "This patch ..." in a changelog.

> From: guilherme m. schroeder <guilherme.m.schroeder@gmail.com>
> Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>

Nope.  The way to signify authorship is to put a From: line right at
the very start of the email.  If that line is missing, we'll fall back
to using the email headers to determins the authorship.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
